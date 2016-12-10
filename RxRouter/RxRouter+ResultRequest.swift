// This file is generated by RxResultRequestGenerator script.

import RxSwift
import DataMapper

// Extension for output type SupportedType.
extension RxRouter {

    public func request(_ endpoint: Endpoint<SupportedType, SupportedType>, input: SupportedType) -> Observable<RouterResult<SupportedType>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request(_ endpoint: Endpoint<Void, SupportedType>) -> Observable<RouterResult<SupportedType>> {
        return observe { callback in router.request(endpoint, callback: callback) }
    }

    public func request<IN: Serializable>(_ endpoint: Endpoint<IN, SupportedType>, input: IN) -> Observable<RouterResult<SupportedType>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request<IN: Serializable>(_ endpoint: Endpoint<IN?, SupportedType>, input: IN?) -> Observable<RouterResult<SupportedType>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request<IN: Serializable>(_ endpoint: Endpoint<[IN], SupportedType>, input: [IN]) -> Observable<RouterResult<SupportedType>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request<IN: Serializable>(_ endpoint: Endpoint<[IN]?, SupportedType>, input: [IN]?) -> Observable<RouterResult<SupportedType>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request<IN: Serializable>(_ endpoint: Endpoint<[IN?], SupportedType>, input: [IN?]) -> Observable<RouterResult<SupportedType>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request<IN: Serializable>(_ endpoint: Endpoint<[IN?]?, SupportedType>, input: [IN?]?) -> Observable<RouterResult<SupportedType>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request<IN: Serializable>(_ endpoint: Endpoint<[String: IN], SupportedType>, input: [String: IN]) -> Observable<RouterResult<SupportedType>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request<IN: Serializable>(_ endpoint: Endpoint<[String: IN]?, SupportedType>, input: [String: IN]?) -> Observable<RouterResult<SupportedType>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request<IN: Serializable>(_ endpoint: Endpoint<[String: IN?], SupportedType>, input: [String: IN?]) -> Observable<RouterResult<SupportedType>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request<IN: Serializable>(_ endpoint: Endpoint<[String: IN?]?, SupportedType>, input: [String: IN?]?) -> Observable<RouterResult<SupportedType>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }
}

// Extension for output type Void.
extension RxRouter {

    public func request(_ endpoint: Endpoint<SupportedType, Void>, input: SupportedType) -> Observable<RouterResult<Void>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request(_ endpoint: Endpoint<Void, Void>) -> Observable<RouterResult<Void>> {
        return observe { callback in router.request(endpoint, callback: callback) }
    }

    public func request<IN: Serializable>(_ endpoint: Endpoint<IN, Void>, input: IN) -> Observable<RouterResult<Void>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request<IN: Serializable>(_ endpoint: Endpoint<IN?, Void>, input: IN?) -> Observable<RouterResult<Void>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request<IN: Serializable>(_ endpoint: Endpoint<[IN], Void>, input: [IN]) -> Observable<RouterResult<Void>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request<IN: Serializable>(_ endpoint: Endpoint<[IN]?, Void>, input: [IN]?) -> Observable<RouterResult<Void>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request<IN: Serializable>(_ endpoint: Endpoint<[IN?], Void>, input: [IN?]) -> Observable<RouterResult<Void>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request<IN: Serializable>(_ endpoint: Endpoint<[IN?]?, Void>, input: [IN?]?) -> Observable<RouterResult<Void>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request<IN: Serializable>(_ endpoint: Endpoint<[String: IN], Void>, input: [String: IN]) -> Observable<RouterResult<Void>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request<IN: Serializable>(_ endpoint: Endpoint<[String: IN]?, Void>, input: [String: IN]?) -> Observable<RouterResult<Void>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request<IN: Serializable>(_ endpoint: Endpoint<[String: IN?], Void>, input: [String: IN?]) -> Observable<RouterResult<Void>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request<IN: Serializable>(_ endpoint: Endpoint<[String: IN?]?, Void>, input: [String: IN?]?) -> Observable<RouterResult<Void>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }
}

// Extension for output type OUT.
extension RxRouter {

    public func request<OUT: Deserializable>(_ endpoint: Endpoint<SupportedType, OUT>, input: SupportedType) -> Observable<RouterResult<OUT>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request<OUT: Deserializable>(_ endpoint: Endpoint<Void, OUT>) -> Observable<RouterResult<OUT>> {
        return observe { callback in router.request(endpoint, callback: callback) }
    }

    public func request<IN: Serializable, OUT: Deserializable>(_ endpoint: Endpoint<IN, OUT>, input: IN) -> Observable<RouterResult<OUT>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request<IN: Serializable, OUT: Deserializable>(_ endpoint: Endpoint<IN?, OUT>, input: IN?) -> Observable<RouterResult<OUT>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request<IN: Serializable, OUT: Deserializable>(_ endpoint: Endpoint<[IN], OUT>, input: [IN]) -> Observable<RouterResult<OUT>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request<IN: Serializable, OUT: Deserializable>(_ endpoint: Endpoint<[IN]?, OUT>, input: [IN]?) -> Observable<RouterResult<OUT>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request<IN: Serializable, OUT: Deserializable>(_ endpoint: Endpoint<[IN?], OUT>, input: [IN?]) -> Observable<RouterResult<OUT>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request<IN: Serializable, OUT: Deserializable>(_ endpoint: Endpoint<[IN?]?, OUT>, input: [IN?]?) -> Observable<RouterResult<OUT>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request<IN: Serializable, OUT: Deserializable>(_ endpoint: Endpoint<[String: IN], OUT>, input: [String: IN]) -> Observable<RouterResult<OUT>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request<IN: Serializable, OUT: Deserializable>(_ endpoint: Endpoint<[String: IN]?, OUT>, input: [String: IN]?) -> Observable<RouterResult<OUT>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request<IN: Serializable, OUT: Deserializable>(_ endpoint: Endpoint<[String: IN?], OUT>, input: [String: IN?]) -> Observable<RouterResult<OUT>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request<IN: Serializable, OUT: Deserializable>(_ endpoint: Endpoint<[String: IN?]?, OUT>, input: [String: IN?]?) -> Observable<RouterResult<OUT>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }
}

// Extension for output type [OUT].
extension RxRouter {

    public func request<OUT: Deserializable>(_ endpoint: Endpoint<SupportedType, [OUT]>, input: SupportedType) -> Observable<RouterResult<[OUT]>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request<OUT: Deserializable>(_ endpoint: Endpoint<Void, [OUT]>) -> Observable<RouterResult<[OUT]>> {
        return observe { callback in router.request(endpoint, callback: callback) }
    }

    public func request<IN: Serializable, OUT: Deserializable>(_ endpoint: Endpoint<IN, [OUT]>, input: IN) -> Observable<RouterResult<[OUT]>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request<IN: Serializable, OUT: Deserializable>(_ endpoint: Endpoint<IN?, [OUT]>, input: IN?) -> Observable<RouterResult<[OUT]>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request<IN: Serializable, OUT: Deserializable>(_ endpoint: Endpoint<[IN], [OUT]>, input: [IN]) -> Observable<RouterResult<[OUT]>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request<IN: Serializable, OUT: Deserializable>(_ endpoint: Endpoint<[IN]?, [OUT]>, input: [IN]?) -> Observable<RouterResult<[OUT]>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request<IN: Serializable, OUT: Deserializable>(_ endpoint: Endpoint<[IN?], [OUT]>, input: [IN?]) -> Observable<RouterResult<[OUT]>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request<IN: Serializable, OUT: Deserializable>(_ endpoint: Endpoint<[IN?]?, [OUT]>, input: [IN?]?) -> Observable<RouterResult<[OUT]>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request<IN: Serializable, OUT: Deserializable>(_ endpoint: Endpoint<[String: IN], [OUT]>, input: [String: IN]) -> Observable<RouterResult<[OUT]>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request<IN: Serializable, OUT: Deserializable>(_ endpoint: Endpoint<[String: IN]?, [OUT]>, input: [String: IN]?) -> Observable<RouterResult<[OUT]>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request<IN: Serializable, OUT: Deserializable>(_ endpoint: Endpoint<[String: IN?], [OUT]>, input: [String: IN?]) -> Observable<RouterResult<[OUT]>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request<IN: Serializable, OUT: Deserializable>(_ endpoint: Endpoint<[String: IN?]?, [OUT]>, input: [String: IN?]?) -> Observable<RouterResult<[OUT]>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }
}

// Extension for output type [OUT?].
extension RxRouter {

    public func request<OUT: Deserializable>(_ endpoint: Endpoint<SupportedType, [OUT?]>, input: SupportedType) -> Observable<RouterResult<[OUT?]>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request<OUT: Deserializable>(_ endpoint: Endpoint<Void, [OUT?]>) -> Observable<RouterResult<[OUT?]>> {
        return observe { callback in router.request(endpoint, callback: callback) }
    }

    public func request<IN: Serializable, OUT: Deserializable>(_ endpoint: Endpoint<IN, [OUT?]>, input: IN) -> Observable<RouterResult<[OUT?]>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request<IN: Serializable, OUT: Deserializable>(_ endpoint: Endpoint<IN?, [OUT?]>, input: IN?) -> Observable<RouterResult<[OUT?]>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request<IN: Serializable, OUT: Deserializable>(_ endpoint: Endpoint<[IN], [OUT?]>, input: [IN]) -> Observable<RouterResult<[OUT?]>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request<IN: Serializable, OUT: Deserializable>(_ endpoint: Endpoint<[IN]?, [OUT?]>, input: [IN]?) -> Observable<RouterResult<[OUT?]>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request<IN: Serializable, OUT: Deserializable>(_ endpoint: Endpoint<[IN?], [OUT?]>, input: [IN?]) -> Observable<RouterResult<[OUT?]>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request<IN: Serializable, OUT: Deserializable>(_ endpoint: Endpoint<[IN?]?, [OUT?]>, input: [IN?]?) -> Observable<RouterResult<[OUT?]>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request<IN: Serializable, OUT: Deserializable>(_ endpoint: Endpoint<[String: IN], [OUT?]>, input: [String: IN]) -> Observable<RouterResult<[OUT?]>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request<IN: Serializable, OUT: Deserializable>(_ endpoint: Endpoint<[String: IN]?, [OUT?]>, input: [String: IN]?) -> Observable<RouterResult<[OUT?]>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request<IN: Serializable, OUT: Deserializable>(_ endpoint: Endpoint<[String: IN?], [OUT?]>, input: [String: IN?]) -> Observable<RouterResult<[OUT?]>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request<IN: Serializable, OUT: Deserializable>(_ endpoint: Endpoint<[String: IN?]?, [OUT?]>, input: [String: IN?]?) -> Observable<RouterResult<[OUT?]>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }
}

// Extension for output type [String: OUT].
extension RxRouter {

    public func request<OUT: Deserializable>(_ endpoint: Endpoint<SupportedType, [String: OUT]>, input: SupportedType) -> Observable<RouterResult<[String: OUT]>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request<OUT: Deserializable>(_ endpoint: Endpoint<Void, [String: OUT]>) -> Observable<RouterResult<[String: OUT]>> {
        return observe { callback in router.request(endpoint, callback: callback) }
    }

    public func request<IN: Serializable, OUT: Deserializable>(_ endpoint: Endpoint<IN, [String: OUT]>, input: IN) -> Observable<RouterResult<[String: OUT]>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request<IN: Serializable, OUT: Deserializable>(_ endpoint: Endpoint<IN?, [String: OUT]>, input: IN?) -> Observable<RouterResult<[String: OUT]>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request<IN: Serializable, OUT: Deserializable>(_ endpoint: Endpoint<[IN], [String: OUT]>, input: [IN]) -> Observable<RouterResult<[String: OUT]>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request<IN: Serializable, OUT: Deserializable>(_ endpoint: Endpoint<[IN]?, [String: OUT]>, input: [IN]?) -> Observable<RouterResult<[String: OUT]>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request<IN: Serializable, OUT: Deserializable>(_ endpoint: Endpoint<[IN?], [String: OUT]>, input: [IN?]) -> Observable<RouterResult<[String: OUT]>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request<IN: Serializable, OUT: Deserializable>(_ endpoint: Endpoint<[IN?]?, [String: OUT]>, input: [IN?]?) -> Observable<RouterResult<[String: OUT]>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request<IN: Serializable, OUT: Deserializable>(_ endpoint: Endpoint<[String: IN], [String: OUT]>, input: [String: IN]) -> Observable<RouterResult<[String: OUT]>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request<IN: Serializable, OUT: Deserializable>(_ endpoint: Endpoint<[String: IN]?, [String: OUT]>, input: [String: IN]?) -> Observable<RouterResult<[String: OUT]>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request<IN: Serializable, OUT: Deserializable>(_ endpoint: Endpoint<[String: IN?], [String: OUT]>, input: [String: IN?]) -> Observable<RouterResult<[String: OUT]>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request<IN: Serializable, OUT: Deserializable>(_ endpoint: Endpoint<[String: IN?]?, [String: OUT]>, input: [String: IN?]?) -> Observable<RouterResult<[String: OUT]>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }
}

// Extension for output type [String: OUT?].
extension RxRouter {

    public func request<OUT: Deserializable>(_ endpoint: Endpoint<SupportedType, [String: OUT?]>, input: SupportedType) -> Observable<RouterResult<[String: OUT?]>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request<OUT: Deserializable>(_ endpoint: Endpoint<Void, [String: OUT?]>) -> Observable<RouterResult<[String: OUT?]>> {
        return observe { callback in router.request(endpoint, callback: callback) }
    }

    public func request<IN: Serializable, OUT: Deserializable>(_ endpoint: Endpoint<IN, [String: OUT?]>, input: IN) -> Observable<RouterResult<[String: OUT?]>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request<IN: Serializable, OUT: Deserializable>(_ endpoint: Endpoint<IN?, [String: OUT?]>, input: IN?) -> Observable<RouterResult<[String: OUT?]>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request<IN: Serializable, OUT: Deserializable>(_ endpoint: Endpoint<[IN], [String: OUT?]>, input: [IN]) -> Observable<RouterResult<[String: OUT?]>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request<IN: Serializable, OUT: Deserializable>(_ endpoint: Endpoint<[IN]?, [String: OUT?]>, input: [IN]?) -> Observable<RouterResult<[String: OUT?]>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request<IN: Serializable, OUT: Deserializable>(_ endpoint: Endpoint<[IN?], [String: OUT?]>, input: [IN?]) -> Observable<RouterResult<[String: OUT?]>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request<IN: Serializable, OUT: Deserializable>(_ endpoint: Endpoint<[IN?]?, [String: OUT?]>, input: [IN?]?) -> Observable<RouterResult<[String: OUT?]>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request<IN: Serializable, OUT: Deserializable>(_ endpoint: Endpoint<[String: IN], [String: OUT?]>, input: [String: IN]) -> Observable<RouterResult<[String: OUT?]>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request<IN: Serializable, OUT: Deserializable>(_ endpoint: Endpoint<[String: IN]?, [String: OUT?]>, input: [String: IN]?) -> Observable<RouterResult<[String: OUT?]>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request<IN: Serializable, OUT: Deserializable>(_ endpoint: Endpoint<[String: IN?], [String: OUT?]>, input: [String: IN?]) -> Observable<RouterResult<[String: OUT?]>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }

    public func request<IN: Serializable, OUT: Deserializable>(_ endpoint: Endpoint<[String: IN?]?, [String: OUT?]>, input: [String: IN?]?) -> Observable<RouterResult<[String: OUT?]>> {
        return observe { callback in router.request(endpoint, input: input, callback: callback) }
    }
}