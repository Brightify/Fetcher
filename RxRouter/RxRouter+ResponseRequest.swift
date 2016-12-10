// This file is generated by RxResponseRequestGenerator script.

import RxSwift
import DataMapper

// Extension for output type SupportedType.
extension RxRouter {

    public func request(_ endpoint: Endpoint<SupportedType, SupportedType>, input: SupportedType) -> Observable<Response<SupportedType>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request(_ endpoint: Endpoint<Void, SupportedType>) -> Observable<Response<SupportedType>> {
        return observe { callback in router.request(endpoint, callback: callback) }
    }

    public func request<IN: Serializable>(_ endpoint: Endpoint<IN, SupportedType>, input: IN) -> Observable<Response<SupportedType>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request<IN: Serializable>(_ endpoint: Endpoint<IN?, SupportedType>, input: IN?) -> Observable<Response<SupportedType>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request<IN: Serializable>(_ endpoint: Endpoint<[IN], SupportedType>, input: [IN]) -> Observable<Response<SupportedType>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request<IN: Serializable>(_ endpoint: Endpoint<[IN]?, SupportedType>, input: [IN]?) -> Observable<Response<SupportedType>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request<IN: Serializable>(_ endpoint: Endpoint<[IN?], SupportedType>, input: [IN?]) -> Observable<Response<SupportedType>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request<IN: Serializable>(_ endpoint: Endpoint<[IN?]?, SupportedType>, input: [IN?]?) -> Observable<Response<SupportedType>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request<IN: Serializable>(_ endpoint: Endpoint<[String: IN], SupportedType>, input: [String: IN]) -> Observable<Response<SupportedType>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request<IN: Serializable>(_ endpoint: Endpoint<[String: IN]?, SupportedType>, input: [String: IN]?) -> Observable<Response<SupportedType>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request<IN: Serializable>(_ endpoint: Endpoint<[String: IN?], SupportedType>, input: [String: IN?]) -> Observable<Response<SupportedType>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request<IN: Serializable>(_ endpoint: Endpoint<[String: IN?]?, SupportedType>, input: [String: IN?]?) -> Observable<Response<SupportedType>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }
}

// Extension for output type Void.
extension RxRouter {

    public func request(_ endpoint: Endpoint<SupportedType, Void>, input: SupportedType) -> Observable<Response<Void>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request(_ endpoint: Endpoint<Void, Void>) -> Observable<Response<Void>> {
        return observe { callback in router.request(endpoint, callback: callback) }
    }

    public func request<IN: Serializable>(_ endpoint: Endpoint<IN, Void>, input: IN) -> Observable<Response<Void>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request<IN: Serializable>(_ endpoint: Endpoint<IN?, Void>, input: IN?) -> Observable<Response<Void>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request<IN: Serializable>(_ endpoint: Endpoint<[IN], Void>, input: [IN]) -> Observable<Response<Void>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request<IN: Serializable>(_ endpoint: Endpoint<[IN]?, Void>, input: [IN]?) -> Observable<Response<Void>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request<IN: Serializable>(_ endpoint: Endpoint<[IN?], Void>, input: [IN?]) -> Observable<Response<Void>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request<IN: Serializable>(_ endpoint: Endpoint<[IN?]?, Void>, input: [IN?]?) -> Observable<Response<Void>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request<IN: Serializable>(_ endpoint: Endpoint<[String: IN], Void>, input: [String: IN]) -> Observable<Response<Void>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request<IN: Serializable>(_ endpoint: Endpoint<[String: IN]?, Void>, input: [String: IN]?) -> Observable<Response<Void>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request<IN: Serializable>(_ endpoint: Endpoint<[String: IN?], Void>, input: [String: IN?]) -> Observable<Response<Void>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request<IN: Serializable>(_ endpoint: Endpoint<[String: IN?]?, Void>, input: [String: IN?]?) -> Observable<Response<Void>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }
}

// Extension for output type OUT.
extension RxRouter {

    public func request<OUT: Deserializable>(_ endpoint: Endpoint<SupportedType, OUT>, input: SupportedType) -> Observable<Response<OUT?>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request<OUT: Deserializable>(_ endpoint: Endpoint<Void, OUT>) -> Observable<Response<OUT?>> {
        return observe { callback in router.request(endpoint, callback: callback) }
    }

    public func request<IN: Serializable, OUT: Deserializable>(_ endpoint: Endpoint<IN, OUT>, input: IN) -> Observable<Response<OUT?>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request<IN: Serializable, OUT: Deserializable>(_ endpoint: Endpoint<IN?, OUT>, input: IN?) -> Observable<Response<OUT?>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request<IN: Serializable, OUT: Deserializable>(_ endpoint: Endpoint<[IN], OUT>, input: [IN]) -> Observable<Response<OUT?>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request<IN: Serializable, OUT: Deserializable>(_ endpoint: Endpoint<[IN]?, OUT>, input: [IN]?) -> Observable<Response<OUT?>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request<IN: Serializable, OUT: Deserializable>(_ endpoint: Endpoint<[IN?], OUT>, input: [IN?]) -> Observable<Response<OUT?>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request<IN: Serializable, OUT: Deserializable>(_ endpoint: Endpoint<[IN?]?, OUT>, input: [IN?]?) -> Observable<Response<OUT?>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request<IN: Serializable, OUT: Deserializable>(_ endpoint: Endpoint<[String: IN], OUT>, input: [String: IN]) -> Observable<Response<OUT?>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request<IN: Serializable, OUT: Deserializable>(_ endpoint: Endpoint<[String: IN]?, OUT>, input: [String: IN]?) -> Observable<Response<OUT?>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request<IN: Serializable, OUT: Deserializable>(_ endpoint: Endpoint<[String: IN?], OUT>, input: [String: IN?]) -> Observable<Response<OUT?>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request<IN: Serializable, OUT: Deserializable>(_ endpoint: Endpoint<[String: IN?]?, OUT>, input: [String: IN?]?) -> Observable<Response<OUT?>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }
}

// Extension for output type [OUT].
extension RxRouter {

    public func request<OUT: Deserializable>(_ endpoint: Endpoint<SupportedType, [OUT]>, input: SupportedType) -> Observable<Response<[OUT]>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request<OUT: Deserializable>(_ endpoint: Endpoint<Void, [OUT]>) -> Observable<Response<[OUT]>> {
        return observe { callback in router.request(endpoint, callback: callback) }
    }

    public func request<IN: Serializable, OUT: Deserializable>(_ endpoint: Endpoint<IN, [OUT]>, input: IN) -> Observable<Response<[OUT]>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request<IN: Serializable, OUT: Deserializable>(_ endpoint: Endpoint<IN?, [OUT]>, input: IN?) -> Observable<Response<[OUT]>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request<IN: Serializable, OUT: Deserializable>(_ endpoint: Endpoint<[IN], [OUT]>, input: [IN]) -> Observable<Response<[OUT]>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request<IN: Serializable, OUT: Deserializable>(_ endpoint: Endpoint<[IN]?, [OUT]>, input: [IN]?) -> Observable<Response<[OUT]>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request<IN: Serializable, OUT: Deserializable>(_ endpoint: Endpoint<[IN?], [OUT]>, input: [IN?]) -> Observable<Response<[OUT]>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request<IN: Serializable, OUT: Deserializable>(_ endpoint: Endpoint<[IN?]?, [OUT]>, input: [IN?]?) -> Observable<Response<[OUT]>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request<IN: Serializable, OUT: Deserializable>(_ endpoint: Endpoint<[String: IN], [OUT]>, input: [String: IN]) -> Observable<Response<[OUT]>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request<IN: Serializable, OUT: Deserializable>(_ endpoint: Endpoint<[String: IN]?, [OUT]>, input: [String: IN]?) -> Observable<Response<[OUT]>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request<IN: Serializable, OUT: Deserializable>(_ endpoint: Endpoint<[String: IN?], [OUT]>, input: [String: IN?]) -> Observable<Response<[OUT]>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request<IN: Serializable, OUT: Deserializable>(_ endpoint: Endpoint<[String: IN?]?, [OUT]>, input: [String: IN?]?) -> Observable<Response<[OUT]>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }
}

// Extension for output type [OUT?].
extension RxRouter {

    public func request<OUT: Deserializable>(_ endpoint: Endpoint<SupportedType, [OUT?]>, input: SupportedType) -> Observable<Response<[OUT?]>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request<OUT: Deserializable>(_ endpoint: Endpoint<Void, [OUT?]>) -> Observable<Response<[OUT?]>> {
        return observe { callback in router.request(endpoint, callback: callback) }
    }

    public func request<IN: Serializable, OUT: Deserializable>(_ endpoint: Endpoint<IN, [OUT?]>, input: IN) -> Observable<Response<[OUT?]>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request<IN: Serializable, OUT: Deserializable>(_ endpoint: Endpoint<IN?, [OUT?]>, input: IN?) -> Observable<Response<[OUT?]>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request<IN: Serializable, OUT: Deserializable>(_ endpoint: Endpoint<[IN], [OUT?]>, input: [IN]) -> Observable<Response<[OUT?]>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request<IN: Serializable, OUT: Deserializable>(_ endpoint: Endpoint<[IN]?, [OUT?]>, input: [IN]?) -> Observable<Response<[OUT?]>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request<IN: Serializable, OUT: Deserializable>(_ endpoint: Endpoint<[IN?], [OUT?]>, input: [IN?]) -> Observable<Response<[OUT?]>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request<IN: Serializable, OUT: Deserializable>(_ endpoint: Endpoint<[IN?]?, [OUT?]>, input: [IN?]?) -> Observable<Response<[OUT?]>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request<IN: Serializable, OUT: Deserializable>(_ endpoint: Endpoint<[String: IN], [OUT?]>, input: [String: IN]) -> Observable<Response<[OUT?]>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request<IN: Serializable, OUT: Deserializable>(_ endpoint: Endpoint<[String: IN]?, [OUT?]>, input: [String: IN]?) -> Observable<Response<[OUT?]>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request<IN: Serializable, OUT: Deserializable>(_ endpoint: Endpoint<[String: IN?], [OUT?]>, input: [String: IN?]) -> Observable<Response<[OUT?]>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request<IN: Serializable, OUT: Deserializable>(_ endpoint: Endpoint<[String: IN?]?, [OUT?]>, input: [String: IN?]?) -> Observable<Response<[OUT?]>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }
}

// Extension for output type [String: OUT].
extension RxRouter {

    public func request<OUT: Deserializable>(_ endpoint: Endpoint<SupportedType, [String: OUT]>, input: SupportedType) -> Observable<Response<[String: OUT]>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request<OUT: Deserializable>(_ endpoint: Endpoint<Void, [String: OUT]>) -> Observable<Response<[String: OUT]>> {
        return observe { callback in router.request(endpoint, callback: callback) }
    }

    public func request<IN: Serializable, OUT: Deserializable>(_ endpoint: Endpoint<IN, [String: OUT]>, input: IN) -> Observable<Response<[String: OUT]>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request<IN: Serializable, OUT: Deserializable>(_ endpoint: Endpoint<IN?, [String: OUT]>, input: IN?) -> Observable<Response<[String: OUT]>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request<IN: Serializable, OUT: Deserializable>(_ endpoint: Endpoint<[IN], [String: OUT]>, input: [IN]) -> Observable<Response<[String: OUT]>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request<IN: Serializable, OUT: Deserializable>(_ endpoint: Endpoint<[IN]?, [String: OUT]>, input: [IN]?) -> Observable<Response<[String: OUT]>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request<IN: Serializable, OUT: Deserializable>(_ endpoint: Endpoint<[IN?], [String: OUT]>, input: [IN?]) -> Observable<Response<[String: OUT]>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request<IN: Serializable, OUT: Deserializable>(_ endpoint: Endpoint<[IN?]?, [String: OUT]>, input: [IN?]?) -> Observable<Response<[String: OUT]>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request<IN: Serializable, OUT: Deserializable>(_ endpoint: Endpoint<[String: IN], [String: OUT]>, input: [String: IN]) -> Observable<Response<[String: OUT]>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request<IN: Serializable, OUT: Deserializable>(_ endpoint: Endpoint<[String: IN]?, [String: OUT]>, input: [String: IN]?) -> Observable<Response<[String: OUT]>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request<IN: Serializable, OUT: Deserializable>(_ endpoint: Endpoint<[String: IN?], [String: OUT]>, input: [String: IN?]) -> Observable<Response<[String: OUT]>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request<IN: Serializable, OUT: Deserializable>(_ endpoint: Endpoint<[String: IN?]?, [String: OUT]>, input: [String: IN?]?) -> Observable<Response<[String: OUT]>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }
}

// Extension for output type [String: OUT?].
extension RxRouter {

    public func request<OUT: Deserializable>(_ endpoint: Endpoint<SupportedType, [String: OUT?]>, input: SupportedType) -> Observable<Response<[String: OUT?]>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request<OUT: Deserializable>(_ endpoint: Endpoint<Void, [String: OUT?]>) -> Observable<Response<[String: OUT?]>> {
        return observe { callback in router.request(endpoint, callback: callback) }
    }

    public func request<IN: Serializable, OUT: Deserializable>(_ endpoint: Endpoint<IN, [String: OUT?]>, input: IN) -> Observable<Response<[String: OUT?]>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request<IN: Serializable, OUT: Deserializable>(_ endpoint: Endpoint<IN?, [String: OUT?]>, input: IN?) -> Observable<Response<[String: OUT?]>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request<IN: Serializable, OUT: Deserializable>(_ endpoint: Endpoint<[IN], [String: OUT?]>, input: [IN]) -> Observable<Response<[String: OUT?]>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request<IN: Serializable, OUT: Deserializable>(_ endpoint: Endpoint<[IN]?, [String: OUT?]>, input: [IN]?) -> Observable<Response<[String: OUT?]>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request<IN: Serializable, OUT: Deserializable>(_ endpoint: Endpoint<[IN?], [String: OUT?]>, input: [IN?]) -> Observable<Response<[String: OUT?]>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request<IN: Serializable, OUT: Deserializable>(_ endpoint: Endpoint<[IN?]?, [String: OUT?]>, input: [IN?]?) -> Observable<Response<[String: OUT?]>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request<IN: Serializable, OUT: Deserializable>(_ endpoint: Endpoint<[String: IN], [String: OUT?]>, input: [String: IN]) -> Observable<Response<[String: OUT?]>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request<IN: Serializable, OUT: Deserializable>(_ endpoint: Endpoint<[String: IN]?, [String: OUT?]>, input: [String: IN]?) -> Observable<Response<[String: OUT?]>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request<IN: Serializable, OUT: Deserializable>(_ endpoint: Endpoint<[String: IN?], [String: OUT?]>, input: [String: IN?]) -> Observable<Response<[String: OUT?]>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request<IN: Serializable, OUT: Deserializable>(_ endpoint: Endpoint<[String: IN?]?, [String: OUT?]>, input: [String: IN?]?) -> Observable<Response<[String: OUT?]>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }
}