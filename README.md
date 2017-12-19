# Fetcher

[![CI Status](http://img.shields.io/travis/Brightify/Fetcher.svg?style=flat)](https://travis-ci.org/Brightify/Fetcher)
[![Version](https://img.shields.io/cocoapods/v/Fetcher.svg?style=flat)](http://cocoapods.org/pods/Fetcher)
[![License](https://img.shields.io/cocoapods/l/Fetcher.svg?style=flat)](http://cocoapods.org/pods/Fetcher)
[![Platform](https://img.shields.io/cocoapods/p/Fetcher.svg?style=flat)](http://cocoapods.org/pods/Fetcher)
[![Slack Status](http://swiftkit.brightify.org//badge.svg)](http://swiftkit.brightify.org)

## Introduction

Fetcher is a small HTTP networking library for Swift. Its main goal is to simplify common tasks like sending REST requests. Networking is a very complex subject and our goal is not to cover everything that can be done. But we provide API that allows you to implement what you need or to customize behavior of Fetcher (this is handy if your server for some reason does not obey any standard).

Main features:

* Easy to use API
* Compile time safety (as much as possible)
* Abstraction of data encoding by using [DataMapper](https://github.com/Brightify/DataMapper)
* Almost everything is customizable
* Data mapping on background thread
* Designed with DRY principle in mind
* Support for RxSwift

## Changelog

List of all changes and new features can be found [here](CHANGELOG.md).

## Requirements

- **Swift 3**
- **iOS 8+**

## Installation

### CocoaPods

Fetcher is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your test target in your Podfile:

```ruby
pod "Fetcher"
```

This will automatically include "Core" and "AlamofireRequestPerformer" subspecs.

If you want only Fetcher without RequestPerformers (you have your own implementation), use:

```ruby
pod "Fetcher/Core"
```

Fetcher comes with support for [RxSwift](https://github.com/ReactiveX/RxSwift):

```ruby
pod "Fetcher/RxFetcher"
```

Note: "RxFetcher" subspec does not depend on "AlamofireRequestPerformer". So if you want to use it, you need to add it extra by:

```ruby
pod "Fetcher"
```

or:

```ruby
pod "Fetcher/AlamofireRequestPerformer"
```

## Usage

Below is a complete list of all features this library offers and how to use them. Some examples of usage can be found in [tests](Tests). This documentation presumes that you are already familiar with [DataMapper](https://github.com/Brightify/DataMapper). Also you should know some basics about HTTP.

### Quick overview

Below is shown a simple use case. It does not explain all of the concepts used. Refer to corresponding chapters for explanations.

Lets say we want to send `GET` request which will retrieve some data from our server. Our data looks like this:

```Swift
struct ExampleObject {

    let id: String?
    let text: String?
}
```

To simulate our server we will use [httpbin.org/get](https://httpbin.org/get). It returns everything you send to it. For example look at the response for [httpbin.org/get?id=1&text=a](https://httpbin.org/get?id=1&text=a).

```Swift
let fetcher = Fetcher(requestPerformer: AlamofireRequestPerformer())

    fetcher.request(GET<Void, SupportedType>("https://httpbin.org/get", modifiers: URLQueryItem(name: "id", value: "1"), URLQueryItem(name: "text", value: "a")), callback: { response in
    switch response.result {
    case .success(let value):
        let object = ExampleObject(id: value.dictionary?["args"]?.dictionary?["id"]?.string,
                                   text: value.dictionary?["args"]?.dictionary?["text"]?.string)

        print(object) // ExampleObject(id: Optional("1"), text: Optional("a"))
    case .failure(let error):
        // Handle error
        break
    }
})
```

This is probably the simplest code you can write (and simultaneously the ugliest). Also there is almost no difference between this and [Alamofire](https://github.com/Alamofire/Alamofire) code. However, we can improve it a bit:

```Swift
let fetcher = Fetcher(requestPerformer: AlamofireRequestPerformer())

fetcher.request(Endpoints.get(id: "1", text: "a"), callback: { response in
    switch response.result {
    case .success(let value):
        // value was already transformed by DataMapper.
        print(value)
    case .failure(let error):
        // Handle error
        break
    }
})

struct Endpoints: EndpointProvider {

    static func get(id: String, text: String) -> GET<Void, ExampleObject> {
        return create("https://httpbin.org/get", modifiers: URLQueryItem(name: "id", value: "\(id)"), URLQueryItem(name: "text", value: "\(text)"))
    }
}

struct ExampleObject: Deserializable {

    let id: String?
    let text: String?

    init(_ data: DeserializableData) throws {
        id = data["args"]["id"].get()
        text = data["args"]["text"].get()
    }
}
```

Here [DataMapper](https://github.com/Brightify/DataMapper) is used to remove mapping from the request and endpoint is moved to extra struct, so that it can be easily reused. There are still some problems that left that will become worse as we further extend our code. For example if we want to add new data objects, then `data["args"]` needs to be written everywhere because of the server API. Also if we add new endpoints, then the base URL will be on multiple places.

```Swift
let fetcher = Fetcher(requestPerformer: AlamofireRequestPerformer())
fetcher.register(requestEnhancers: HttpBinResponseTranslation())
fetcher.register(requestModifiers: BaseUrl(baseUrl: "https://httpbin.org"))

fetcher.request(Endpoints.post(), input: ExampleObject(id: "1", text: "a")) {
    if let error = $0.result.error {
        // Handle error
    }
}

struct Endpoints: EndpointProvider {

    static func get(id: String, text: String) -> GET<Void, ExampleObject> {
        return create("get", modifiers: URLQueryItem(name: "id", value: "\(id)"), URLQueryItem(name: "text", value: "\(text)"))
    }

    static func post() -> POST<ExampleObject, Void> {
        return create("post")
    }

    static func put() -> PUT<ExampleObject, Void> {
        return create("put")
    }

    static func delete(id: String) -> DELETE<Void, Void> {
        return create("delete", modifiers: URLQueryItem(name: "id", value: "\(id)"))
    }
}

struct HttpBinResponseTranslation: RequestEnhancer {

    func deenhance(response: inout Response<SupportedType>) {
        response = response.map { $0.dictionary?["args"] ?? .null }
    }
}

struct ExampleObject: Mappable {

    var id: String?
    var text: String?

    init(id: String?, text: String?) {
        self.id = id
        self.text = text
    }

    init(_ data: DeserializableData) throws {
        try mapping(data)
    }

    mutating func mapping(_ data: inout MappableData) throws {
        data["id"].map(&id)
        data["text"].map(&text)
    }
}
```

Problem with `data["args"]` is solved using `HttpBinResponseTranslation` and thanks to `BaseUrl` there is no longer need to write the base URL everywhere (see [RequestEnhancer](#requestenhancer) if you want to know how all of this works). Another important feature of this example is the `fetcher.request(Endpoints.post(), input: ExampleObject(id: "1", text: "a"))` which demonstrates how some data can be send to the server.

### Fetcher

`Fetcher` is responsible for processing requests and responses. It uses `RequestPerformer` (see [RequestPerformer](#requestperformer)) to do the actual data transfer.

In `init` you can pass several more arguments:

* objectMapperPolymorph: `Polymorph` - Polymorph used for mapping objects passed to `Fetcher` (see [DataMapper](https://github.com/Brightify/DataMapper))
* errorHandler: `ErrorHandler` - see [ErrorHandler](#errorhandler)
* callQueue: `DispatchQueue` - Queue where almost all of Fetcher's logic is done (including object mapping). Default is the background queue.
* callbackQueue: `DispatchQueue` - Queue on which the callback passed in request is called. Default is the main queue.

`Fetcher` can have additional configuration done by `register` methods:

```Swift
func register(requestEnhancers: [RequestEnhancer])

func register(requestEnhancers: RequestEnhancer...)

func register(requestModifiers: [RequestModifier])

func register(requestModifiers: RequestModifier...)
```

These are used to add `RequestEnhacer` and `RequestModifier` which are used in every request (see [RequestEnhancer](#requestenhancer)).

By its nature `Fetcher` will usually be created only at one place in your code. But sometimes you may want to have more of them (for example if you want to two servers with different base URL). In this case it may be handy to copy settings from one instance of `Fetcher` to another. This can be done via:

```Swift
init(copy fetcher: Fetcher)
```

#### Requests

`request` support all kinds of data. The main difference between them is whether there is input data and if [DataMapper](https://github.com/Brightify/DataMapper) is used. Example of `request` overload:

```Swift
func request<IN: Serializable, OUT: Deserializable>(_ endpoint: Endpoint<IN, OUT>, input: IN, callback: @escaping (Response<OUT>) -> Void) -> Cancellable
```

The first generic type of `Endpoint` (see [Endpoint](#endpoint)) says what kind of data will be send to the server and the second one is what will the server send back. `Void` stands for no data, `NSData` means that [DataMapper](https://github.com/Brightify/DataMapper) won't be used and `SupportedType` lets you manually do the transformation. If `Endpoint` has `Void` as its input type, then the `request` does not have `input` parameter.

`request` supports everything that [DataMapper](https://github.com/Brightify/DataMapper) does (plus exceptions mentioned above). Even though it is possible to create `Endpoint` with any input and output types, you won't be able to use them in `request`.

`Cancellable` returned from `request` can be used to cancel the request if it is no longer necessary.

```Swift
let cancellable = fetcher.request(Endpoints.endpoint()) { response in
    // Do some stuff
}

cancellable.cancel()
```

#### Retry

```Swift
extension Request {

    func retry(max: Int = Int.max, delay: DispatchTimeInterval = .seconds(0), failCallback: () -> Void = {})
}
```

Sometimes repeating a request may result in a completely different behavior. For example your request failed because there is no internet connection. In that case you may want to try the request later. Exactly for this scenario is there `retry` method of `Request` (see [Request](#request)).

It does the same thing as calling the request again manually. `max` says how many times will be the request retried. If this count is reached, then instead of repeating the request, `failCallback` is called. Each call of `retry` retries the request only once. But because this is usually done in callback (which is called for every try), `retry` is called in cycle (and here comes in play `max`). `delay` modifies how long should `Fetcher` wait before it attempts again. `Cancallable` obtained from the original request works for retried request too. Example:

```Swift
fetcher.request(...) { response in
    guard let value = response.result.value else {
        return response.request.retry(max: 3) {
            print("error")
        }
    }

    print(value)
})
```

Here `retry` is called only if `result` is failure. After `retry` is called this callback ends. Next time it is called with a different `Response` and this cycle repeats (in this case max three times). If after all these retries the `result` is still failure, then `print("error")` is called and no more attempts are made.

### Request

```Swift
struct Request {

    var modifiers: [RequestModifier] = []

    var URLRequest: URLRequest

    var callback: (Response<Data>) -> Void

    var cancellable: Cancellable

    var retried = 0

    var retryClosure: (Request, Int, DispatchTimeInterval, () -> Void) -> Void

    func retry(max: Int = Int.max, delay: DispatchTimeInterval = .seconds(0), failCallback: () -> Void = {})
}
```

`Request` is a wrapper over `NSURLRequest`. It provides delegates for all methods from `NSURLRequest`. You can access `Request` in `RequestEnhancer` (see [RequestEnhancer](#requestenhancer)) and in `Response`. You can modify `Request` in `RequestEnhancer` as you like. `cancellable` is the same `Cancellable` returned by `Fetcher.request` that created this `Request`. `retried` counts the number of times `retry` is called, `retryClosure` represents the implementation of `retry`.

### Response

```Swift
struct Response<T> {

    public let result: FetcherResult<T>
    public let rawResponse: HTTPURLResponse?
    public let rawData: Data?
    public let request: Request
}
```

`Response` represents result of `Request` (server's response to it). You get an instance of `Response` in every callback of `fetcher.request`. Declaration:

`T` is the same type as `OUT` in `Endpoint`. `FetcherResult<T>` is type alias to `Result<T, FetcherError>`.

There are also some extensions:

```Swift
extension Response {

    func map<U>(_ transform: (T) -> U) -> Response<U>

    func flatMap<U>(_ transform: (T) -> FetcherResult<U>) -> Response<U>

    var rawString: String?
}
```

`map` and `flatMap` works the same way as in `Result` (and are applied only to `result`). `rawString` returns `rawData` decoded using the character coding specified in the response headers.

### Endpoint

`Endpoint` is a class which defines URL (`path`) of request, which `InputEncoding` will be used, `RequestModifier`s that are specific to the request and HTTP method of the request. The implementation has these constructors.

```Swift
init(_ path: String, modifiers: [RequestModifier])

init(_ path: String, inputEncoding: InputEncoding, modifiers: [RequestModifier])

init(_ path: String, modifiers: RequestModifier...)

init(_ path: String, inputEncoding: InputEncoding, modifiers: RequestModifier...)
```

Normally you won't use `Endpoint` directly or create subclasses of it. See [Methods](#methods).

#### EndpointProvider

`EndpointProvider` is a protocol that supports pattern for creating reusable endpoints. It provides `create`, a static method that has the same signature as Endpoint, but creates a specific implementation based on the context. The pattern looks like this:

```Swift
struct Endpoints: EndpointProvider {

    static func get(id: String, text: String) -> GET<Void, ExampleObject> {
        return create("get", modifiers: URLQueryItem(name: "id", value: "\(id)"), URLQueryItem(name: "text", value: "\(text)"))
    }

    static func post() -> POST<ExampleObject, Void> {
        return create("post")
    }
}
```

Notice that `create` could be replaced with `GET` and `POST` but we think it's better to specify the type in just one place. Another advantage of `create` is that you can add implicit `RequestModfier` (see [RequestModifier](#requestmodifier)) to every `Endpoint`. To do this, implement `implicitModifiers`:

```Swift
struct Endpoints: EndpointProvider {

    static var implicitModifiers: [RequestModifier] = [StatusCodeResponseVerifier(code: 200)]

    static func post() -> POST<ExampleObject, Void> {
        return create("post")
    }
}
```

It is also possible to declare endpoints as properties:

```Swift
struct Endpoints: EndpointProvider {

    static var post = POST<ExampleObject, Void>("post")
}
```

This can be only done if you don't pass any parameters directly to URL. In this example `implicitModifiers` wouldn't work. If needed, it can be fixed like so:

```Swift
struct Endpoints: EndpointProvider {

    static var post: POST<ExampleObject, Void> = create("post")
}
```

#### Methods

These are predefined implementations of `Endpoint` which represent some HTTP method:

* CONNECT
* DELETE
* GET
* HEAD
* OPTIONS
* PATCH
* POST
* PUT
* TRACE

### RequestEnhancer

```Swift
protocol RequestEnhancer {

    static var priority: RequestEnhancerPriority { get }

    var instancePriority: RequestEnhancerPriority? { get }

    func enhance(request: inout Request)

    func deenhance(response: inout Response<SupportedType>)
}
```

`RequestEnhancer` is a protocol which modifies behavior of `Fetcher`.

`enhance` is applied to each `Request` after the input data are encoded to it (see [InputEncoding](#inputencoding)) and before it is performed by `RequestPerformer` (see [RequestPerformer](#requestperformer)). You can modify the `Request` as you like. Default implementation does nothing.

`deenhance` does the same thing but for incoming `Response`. It is called after the output data is decoded (see [InputEncoding](#inputencoding)) and before the callback of the request. Default implementation does nothing.

`priority` is used to decide in which order should be multiple instances of `RequestEnhancer` applied. Default value is `.normal`.

`instancePriority` solves problem that each instance of `RequestEnhancer` may have different priority (`priority` is static). Default value is nil, in which case `priority` is used. If `instancePriority` is not nil, then it is used instead of `priority`.

`RequestEnhancer` can be added to `Fetcher` by `register` methods (see [Fetcher](#fetcher-1)).

#### RequestEnhancerPriority

```Swift
enum RequestEnhancerPriority {

    case low  
    case normal
    case high
    case fetcher
    case max
    case custom(value: Int)
}
```

`RequestEnhancerPriority` represents priority of `RequestEnhancer`. The order is from the lowest to the greatest priority. `.normal` is default priority. `.fetcher` is used for internal `RequestEnhacer` and shouldn't be used by other programs. `.max` should be used only if you need to precede internal `RequestEnhancer`. It is recommended to use `.custom` only when necessary.

```Swift
extension RequestEnhancerPriority {

    var less: RequestEnhancerPriority

    var more: RequestEnhancerPriority
}
```

These modifiers allow you to say that one `RequestEnhancer` should run before another (it is a convenient way to specify the order without having to care about the order or unrelated enhancers). They are also the reason for `priority` being static. In this example `RequestEnhancer2` will always run before `RequestEnhancer1`:

```Swift
struct RequestEnhancer1: RequestEnhancer {

	func enhance(request: inout Request) {
		...
	}
}

struct RequestEnhancer2: RequestEnhancer {

	static let priority: RequestEnhancerPriority = RequestEnhancer1.priority.more

	func enhance(request: inout Request) {
		...
	}
}
```

#### RequestModifier

`RequestEnhancer` is used for all requests made by an instance of `Fetcher`. `RequestModifier` is a marker protocol that can be added to each request separately. `RequestEnhancer` can then look into `Request.modifiers` to see if there is an instance to act accordingly. For example behavior of `RequestLogger` is specified by `RequestLogging` which is `RequestModifier` with some additional data.

There are three ways to add `RequestModifier` to request:

1. `register` method in `Fetcher` (see [Fetcher](#fetcher-1)). `RequestModifier` is applied to all requests.
2. `implicitModifiers` in `EndpointProvider` (see [EndpointProvider](#endpointprovider)). `RequestModifier` is applied to all requests using `Endpoint` created by `create` method of the `EndpointProvider`.
3. `modifiers` parameter in `Endpoint` `init` (see [Endpoint](#endpoint)). `RequestModifier` is applied only to the requests which use this specific instance of `Endpoint`.

#### Implementations

*BaseUrl*

`BaseUrl` is `RequestModifier` that tells `BaseUrlRequestEnhancer` what URL to insert before the URL specified in `Endpoint`. `BaseUrlRequestEnhancer` is registered by default. `BaseUrl` uses `RequestEnhancerPriority` to decide which one will be used if more then one is registered. `baseUrl` parameter of `init` specifies what URL to insert. If it is nil then nothing happens. There is a special instance `BaseUrl.Ignore` which suppresses other `BaseUrl`.

Example can be found in the last example in [Quick overview](#quick-overview).

*RequestLogger*

`RequestLogger` is a good tool to debug requests. By default it logs some information about the request (and the response) to the console, although it can be overridden using `logFunction` in `init`. What to log is specified using `RequestLogging` (`RequestModifier`). `RequestLogging` is an `OptionSet` so multiple options can be selected by putting them into array. If there is no instance of `RequestLogging` then `defaultOptions` from `init` are used. Options for `RequestLogging`:

* `requestUrl`
* `time`
* `responseCode`
* `requestHeaders`
* `requestBody`
* `responseHeaders`
* `responseBody`
* `all` - everything from above
* `disabled` - nothing

`defaultOptions` consists from `requestUrl`, `responseCode`, `time`.

*ResponseVerifier*

```Swift
protocol ResponseVerifier: RequestModifier {

    func verify(response: Response<SupportedType>) -> FetcherError?
}
```

`verify` is called by `ResponseVerifierEnhancer` (registered by default). `ResponseVerifierEnhancer` takes all instances of `ResponseVerifier` and calls `verify` method. The first non-nil result, is used to modify the response by `Response.flatMap`. It only performs an action if `Response.result` is success.

`StatusCodeResponseVerifier` is a preimplemented `ResponseVerifier` that compares status code of response with codes from `init`. If match is not found then it returns `.invalidStatusCode`, nil otherwise.

### InputEncoding

`InputEncoding` is a marker protocol which says how the data should be encoded to `Request` and decoded from `Response`. Each `Endpoint` has default encoding based on the method it uses (`GET` encodes data to the URL, `POST` to the request body atc.) but this can be changed by passing different encoding in its `init` (see [Endpoint](#endpoint)).

#### InputEncodingWithEncoder

```Swift
protocol InputEncodingWithEncoder: InputEncoding {

    func encode(input: SupportedType, to request: inout Request)
}
```

`InputEncodingWithEncoder` is an extension of `InputEncoding`. Normally `DataEncoder` takes care of encoding the input data based on `InputEncoding` (see [DataEncoder](#dataencoder)). With this protocol the `encode` method is called to do the job instead.

#### StandardInputEncoding

```Swift
enum StandardInputEncoding: InputEncoding {

    case queryString
    case httpBody
}
```

`StandardInputEncoding` represents two encodings that all `DataEncoder` understand.

`.queryString` encodes the input data into the request URL (`http://url.xxx?param1=value`). As shown in examples in [Quick overview](#quick-overview) this may also be done manually. `.queryString`'s disadvantage is that the input data must be a dictionary.

`.httpBody` simply sends the data in the request body. Encoding depends on `DataEncoder` implementation (may be JSON, XML, etc.).

### RequestPerformer

```Swift
protocol RequestPerformer {

    var dataEncoder: DataEncoder { get }

    func perform(request: Request, callback: @escaping (Response<Data>) -> Void) -> Cancellable
}
```

`RequestPerformer`'s duty is to communicate with the server (perform requests). This is done in the `perform` method that takes `Request` and calls `callback` with `Response` (this call may not happen immediately). It returns `Cancellable` (way to cancel the request).  

`RequestPerformer` also specifies `DataEncoder`, which will be used to encode and decode the data.

#### DataEncoder

```Swift
protocol DataEncoder {

    func encodeToQueryString(input: SupportedType, to request: inout Request)

    func encodeToHttpBody(input: SupportedType, to request: inout Request)

    func encodeCustom(input: SupportedType, to request: inout Request, inputEncoding: InputEncoding)

    func decode(response: Response<Data>) -> Response<SupportedType>
}
```

`DataEncoder` is called by `Fetcher` to encode the input data into `Request` and to decode data from `Response`.

`StandardInputEncoding` specifies which of `encodeToQueryString` or `encodeToHttpBody` is used.

`encodeCustom` is called if a custom implementation of `InputEncoding` is used and it is not `InputEncodingWithEncoder`. By default calling this method will result in a crash (`InputEncoding` is unknown).  

#### Implementations

*AlamofireRequestPerformer*

`AlamofireRequestPerformer` is an implementation on top of [Alamofire](https://github.com/Alamofire/Alamofire). By default it uses `AlamofireJsonDataEncoder` (encoder for JSON) as `DataEncoder` but this can be changed in its `init`.

`AlamofireJsonDataEncoder` knows a special type of `InputEncoding` and that is `FormInputEncoding` which supports content type `application/x-www-form-urlencoded`.

### Header

```Swift
protocol Header: RequestModifier {

    var name: String { get }
    var value: String { get }
}
```

`Header` is a special type of `RequestModifier`, which represents headers of the request. Registered instances of `Header` are added to `Request` by internal `RequestEnhancer`.

#### Predefined headers

`Headers` gathers all predefined headers. They are represented as nested structs added by extensions. For example this is the implementation of `Accept`:

```Swift
extension Headers {

    struct Accept: Header {

        let name = "Accept"

        let value: String

        init(value: String) {
            self.value = value
        }
    }
}

extension Headers.Accept {

    static let applicationJson = Headers.Accept(value: "application/json")
    static let textPlain = Headers.Accept(value: "text/plain")
}
```

Another headers can be added the same way (as well as specific values of the headers).

Currently there are these headers: `Accept`, `ContentType`, `Charset`.

`Custom` is a special type of header. It is meant to by used if some header is needed in only one place, so it is not worth creating a new struct.

### FetcherError

```Swift
enum FetcherError: Error {
    case requestError(Error)
    case invalidStatusCode
    case nilValue
    case custom(Error)
    case unknown
}
```

`FetcherError` is used as the type of error in `Response.result`.

### ErrorHandler

```Swift
protocol ErrorHandler {

    func canResolveError(response: Response<SupportedType>) -> Bool

    func resolveError(response: Response<SupportedType>, callback: (Response<SupportedType>) -> Void)
}
```

`ErrorHandler` tells `Fetcher` what to do if `Response.result` is a failure. It can be set in its `init` with parameter named `errorHandler`. The default one is a `NoErrorHandler`.

When resolving error, `Fetcher` first calls `canResolveError`. If it returns `false`, there is no change in behavior and callback is called with unchanged `Response`. If `true`, `resolveError` is called instead of the callback. However the callback is passed as a closure, which you can call with the modified `Response`.

#### BaseStatusCodeErrorHandler

`BaseStatusCodeErrorHandler` is an "abstract" class for implementations that resolves errors based on the status code of the response. It has similar `init` to `StatusCodeResponseVerifier`. `canResolveError` returns `true` if the status code is one of the codes from `init`.

#### CompositeErrorHandler

```Swift
struct CompositeErrorHandler: ErrorHandler {

    init(handlers: [ErrorHandler])

    init(handlers: ErrorHandler...)
}
```

`CompositeErrorHandler` allows composition of multiple `ErrorHandler`s. Only the first `ErrorHandler` that can resolve the error is used to actually resolve the error.

#### Implementations

*NoErrorHandler*

`NoErrorHandler` does nothing (`canResolveError` always returns `false`).

*NoInternetErrorHandler*

```Swift
final class NoInternetErrorHandler: BaseStatusCodeErrorHandler {

    init(maxRepetitions: Int = 3, delay: DispatchTimeInterval = .seconds(1))
}
```

`NoInternetErrorHandler` handles the status code `599` by calling `retry` (see [retry](#retry)). Parameters for `retry` can be set in `init`.

*RequestTimeOutErrorHandler*

```Swift
final class RequestTimeOutErrorHandler: BaseStatusCodeErrorHandler {

    init(maxRepetitions: Int = 3, delay: DispatchTimeInterval = .seconds(0))
}
```

`RequestTimeOutErrorHandler` handles the status code `408` by calling `retry` (see [retry](#retry)). Parameters for `retry` can be set in `init`.

### RxFetcher

Instead of using the callbacks, you can make your requests in a more "reactive" way by using `Observable`. To do that, you need an instance of `RxFetcher`, which can be obtained by `rx` property of `Fetcher`. `RxFetcher` has the same `request` methods, but they return `Observable`. Modified third example from [Quick overview](#quick-overview):

```Swift
let fetcher = Fetcher(requestPerformer: AlamofireRequestPerformer())
fetcher.register(requestEnhancers: HttpBinResponseTranslation())
fetcher.register(requestModifiers: BaseUrl(baseUrl: "https://httpbin.org"))

fetcher.rx.request(Endpoints.get(id: "1", text: "a").subscribe(onNext: { response in
    switch response.result {
    case .success(let value):
        // value was already transformed with DataMapper.
        print(value)
    case .failure(let error):
        // Handle error
        break
    }
}).addDisposableTo(...)
```

#### Observable extensions

```Swift
extension ObservableConvertibleType where E: ResponseProtocol {

    func retryRequest(max: Int = Int.max, delay: DispatchTimeInterval = .seconds(0)) -> Observable<E>

    func asResult() -> Observable<FetcherResult<E.T>>
}
```

`retryRequest` is a reactive variant to `retry` of `Request` (see [retry](#retry)).

`asResult` returns a mapped sequence with `Response.result`.

### Thread safety

`Fetcher` by default does many things on the background thread, so it needs to be thread safe. This also applies to objects like `RequestPerformer`, `RequestEnhancer`, `ErrorHandler` and so on. Usually all methods from these protocols are  implemented as pure functions, so they don't cause any problems. Also see [DataMapper#ThreadSafety](https://github.com/Brightify/DataMapper#threadsafety).

## Versioning

This library uses semantic versioning. Until the version 1.0 API breaking changes may occur even in minor versions. We consider the version 0.1 to be prerelease, which means that API should be stable but is not tested yet in a real project. After the testing we'll make the necessary adjustments and bump the version to 1.0 (first release).

## Author

* Tadeas Kriz, [tadeas@brightify.org](mailto:tadeas@brightify.org)
* Filip Dolník, [filip@brightify.org](mailto:filip@brightify.org)

## Used libraries

* [DataMapper](https://github.com/Brightify/DataMapper)
* [Result](https://github.com/antitypical/Result)

### AlamofireRequestPerformer

* [Alamofire](https://github.com/Alamofire/Alamofire)

### RxFetcher

* [RxSwift](https://github.com/ReactiveX/RxSwift)

### Tests

* [Quick](https://github.com/Quick/Quick)
* [Nimble](https://github.com/Quick/Nimble)

## License

Fetcher is available under the [MIT License](LICENSE).
