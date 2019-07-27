import RxSwift
import DataMapper
import Foundation

// Extension for output type SupportedType.
extension RxFetcher {

    public func request(_ endpoint: Endpoint<SupportedType, SupportedType>, input: SupportedType) -> Single<Response<SupportedType>> {
        return observe { self.fetcher.request(endpoint, input: input, callback: $0) }
    }

    public func request(_ endpoint: Endpoint<Void, SupportedType>) -> Single<Response<SupportedType>> {
        return observe { self.fetcher.request(endpoint, callback: $0) }
    }

    public func request(_ endpoint: Endpoint<Data, SupportedType>, input: Data) -> Single<Response<SupportedType>> {
        return observe { self.fetcher.request(endpoint, input: input, callback: $0) }
    }

    public func request<IN: Serializable>(_ endpoint: Endpoint<IN, SupportedType>, input: IN) -> Single<Response<SupportedType>> {
        return observe { self.fetcher.request(endpoint, input: input, callback: $0) }
    }

    public func request<IN: Encodable>(_ endpoint: Endpoint<IN, SupportedType>, input: IN) -> Single<Response<SupportedType>> {
        return observe { self.fetcher.request(endpoint, input: input, callback: $0) }
    }

    public func request<IN: Serializable & Encodable>(_ endpoint: Endpoint<IN, SupportedType>, input: IN) -> Single<Response<SupportedType>> {
        return observe { self.fetcher.request(endpoint, input: input, callback: $0) }
    }
}

// Extension for output type Void.
extension RxFetcher {

    public func request(_ endpoint: Endpoint<SupportedType, Void>, input: SupportedType) -> Single<Response<Void>> {
        return observe { self.fetcher.request(endpoint, input: input, callback: $0) }
    }

    public func request(_ endpoint: Endpoint<Void, Void>) -> Single<Response<Void>> {
        return observe { self.fetcher.request(endpoint, callback: $0) }
    }

    public func request(_ endpoint: Endpoint<Data, Void>, input: Data) -> Single<Response<Void>> {
        return observe { self.fetcher.request(endpoint, input: input, callback: $0) }
    }

    public func request<IN: Serializable>(_ endpoint: Endpoint<IN, Void>, input: IN) -> Single<Response<Void>> {
        return observe { self.fetcher.request(endpoint, input: input, callback: $0) }
    }

    public func request<IN: Encodable>(_ endpoint: Endpoint<IN, Void>, input: IN) -> Single<Response<Void>> {
        return observe { self.fetcher.request(endpoint, input: input, callback: $0) }
    }

    public func request<IN: Serializable & Encodable>(_ endpoint: Endpoint<IN, Void>, input: IN) -> Single<Response<Void>> {
        return observe { self.fetcher.request(endpoint, input: input, callback: $0) }
    }
}

// Extension for output type Data.
extension RxFetcher {

    public func request(_ endpoint: Endpoint<SupportedType, Data>, input: SupportedType) -> Single<Response<Data>> {
        return observe { self.fetcher.request(endpoint, input: input, callback: $0) }
    }

    public func request(_ endpoint: Endpoint<Void, Data>) -> Single<Response<Data>> {
        return observe { self.fetcher.request(endpoint, callback: $0) }
    }

    public func request(_ endpoint: Endpoint<Data, Data>, input: Data) -> Single<Response<Data>> {
        return observe { self.fetcher.request(endpoint, input: input, callback: $0) }
    }

    public func request<IN: Serializable>(_ endpoint: Endpoint<IN, Data>, input: IN) -> Single<Response<Data>> {
        return observe { self.fetcher.request(endpoint, input: input, callback: $0) }
    }

    public func request<IN: Encodable>(_ endpoint: Endpoint<IN, Data>, input: IN) -> Single<Response<Data>> {
        return observe { self.fetcher.request(endpoint, input: input, callback: $0) }
    }

    public func request<IN: Serializable & Encodable>(_ endpoint: Endpoint<IN, Data>, input: IN) -> Single<Response<Data>> {
        return observe { self.fetcher.request(endpoint, input: input, callback: $0) }
    }
}

// Extension for output type Deserializable.
extension RxFetcher {

    public func request<OUT: Deserializable>(_ endpoint: Endpoint<SupportedType, OUT>, input: SupportedType) -> Single<Response<OUT>> {
        return observe { self.fetcher.request(endpoint, input: input, callback: $0) }
    }

    public func request<OUT: Deserializable>(_ endpoint: Endpoint<Void, OUT>) -> Single<Response<OUT>> {
        return observe { self.fetcher.request(endpoint, callback: $0) }
    }

    public func request<OUT: Deserializable>(_ endpoint: Endpoint<Data, OUT>, input: Data) -> Single<Response<OUT>> {
        return observe { self.fetcher.request(endpoint, input: input, callback: $0) }
    }

    public func request<IN: Serializable, OUT: Deserializable>(_ endpoint: Endpoint<IN, OUT>, input: IN) -> Single<Response<OUT>> {
        return observe { self.fetcher.request(endpoint, input: input, callback: $0) }
    }

    public func request<IN: Encodable, OUT: Deserializable>(_ endpoint: Endpoint<IN, OUT>, input: IN) -> Single<Response<OUT>> {
        return observe { self.fetcher.request(endpoint, input: input, callback: $0) }
    }

    public func request<IN: Serializable & Encodable, OUT: Deserializable>(_ endpoint: Endpoint<IN, OUT>, input: IN) -> Single<Response<OUT>> {
        return observe { self.fetcher.request(endpoint, input: input, callback: $0) }
    }
}

// Extension for output type Decodable.
extension RxFetcher {

    public func request<OUT: Decodable>(_ endpoint: Endpoint<SupportedType, OUT>, input: SupportedType) -> Single<Response<OUT>> {
        return observe { self.fetcher.request(endpoint, input: input, callback: $0) }
    }

    public func request<OUT: Decodable>(_ endpoint: Endpoint<Void, OUT>) -> Single<Response<OUT>> {
        return observe { self.fetcher.request(endpoint, callback: $0) }
    }

    public func request<OUT: Decodable>(_ endpoint: Endpoint<Data, OUT>, input: Data) -> Single<Response<OUT>> {
        return observe { self.fetcher.request(endpoint, input: input, callback: $0) }
    }

    public func request<IN: Serializable, OUT: Decodable>(_ endpoint: Endpoint<IN, OUT>, input: IN) -> Single<Response<OUT>> {
        return observe { self.fetcher.request(endpoint, input: input, callback: $0) }
    }

    public func request<IN: Encodable, OUT: Decodable>(_ endpoint: Endpoint<IN, OUT>, input: IN) -> Single<Response<OUT>> {
        return observe { self.fetcher.request(endpoint, input: input, callback: $0) }
    }

    public func request<IN: Serializable & Encodable, OUT: Decodable>(_ endpoint: Endpoint<IN, OUT>, input: IN) -> Single<Response<OUT>> {
        return observe { self.fetcher.request(endpoint, input: input, callback: $0) }
    }
}

// Extension for output type Deserializable & Decodable.
extension RxFetcher {

    public func request<OUT: Deserializable & Decodable>(_ endpoint: Endpoint<SupportedType, OUT>, input: SupportedType) -> Single<Response<OUT>> {
        return observe { self.fetcher.request(endpoint, input: input, callback: $0) }
    }

    public func request<OUT: Deserializable & Decodable>(_ endpoint: Endpoint<Void, OUT>) -> Single<Response<OUT>> {
        return observe { self.fetcher.request(endpoint, callback: $0) }
    }

    public func request<OUT: Deserializable & Decodable>(_ endpoint: Endpoint<Data, OUT>, input: Data) -> Single<Response<OUT>> {
        return observe { self.fetcher.request(endpoint, input: input, callback: $0) }
    }

    public func request<IN: Serializable, OUT: Deserializable & Decodable>(_ endpoint: Endpoint<IN, OUT>, input: IN) -> Single<Response<OUT>> {
        return observe { self.fetcher.request(endpoint, input: input, callback: $0) }
    }

    public func request<IN: Encodable, OUT: Deserializable & Decodable>(_ endpoint: Endpoint<IN, OUT>, input: IN) -> Single<Response<OUT>> {
        return observe { self.fetcher.request(endpoint, input: input, callback: $0) }
    }

    public func request<IN: Serializable & Encodable, OUT: Deserializable & Decodable>(_ endpoint: Endpoint<IN, OUT>, input: IN) -> Single<Response<OUT>> {
        return observe { self.fetcher.request(endpoint, input: input, callback: $0) }
    }
}
