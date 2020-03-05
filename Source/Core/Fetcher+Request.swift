import DataMapper
import Foundation

// Extension for output type SupportedType.
extension Fetcher {

    @discardableResult
    public func request(_ endpoint: Endpoint<SupportedType, SupportedType>, input: SupportedType, callback: @escaping (Response<SupportedType>) -> Void) -> Cancellable {
        return run(endpoint: endpoint, inputProvider: { _ in input }, outputProvider: { $1 }, callback: callback)
    }

    @discardableResult
    public func request(_ endpoint: Endpoint<Void, SupportedType>, callback: @escaping (Response<SupportedType>) -> Void) -> Cancellable {
        return run(endpoint: endpoint, inputProvider: { _ in .null }, outputProvider: { $1 }, callback: callback)
    }

    @discardableResult
    public func request(_ endpoint: Endpoint<Data, SupportedType>, input: Data, callback: @escaping (Response<SupportedType>) -> Void) -> Cancellable {
        return run(endpoint: endpoint, inputProvider: { _ in input }, outputProvider: { $1 }, callback: callback)
    }

    @discardableResult
    public func request<IN: Serializable>(_ endpoint: Endpoint<IN, SupportedType>, input: IN, callback: @escaping (Response<SupportedType>) -> Void) -> Cancellable {
        return run(endpoint: endpoint, inputProvider: { _ in self.objectMapper.serialize(input) }, outputProvider: { $1 }, callback: callback)
    }

    @discardableResult
    public func request<IN: Encodable>(_ endpoint: Endpoint<IN, SupportedType>, input: IN, callback: @escaping (Response<SupportedType>) -> Void) -> Cancellable {
        return run(endpoint: endpoint, inputProvider: { _ in try self.objectMapper.encode(input) }, outputProvider: { $1 }, callback: callback)
    }

    @discardableResult
    public func request<IN: Serializable & Encodable>(_ endpoint: Endpoint<IN, SupportedType>, input: IN, callback: @escaping (Response<SupportedType>) -> Void) -> Cancellable {
        return run(endpoint: endpoint, inputProvider: { _ in self.objectMapper.serialize(input) }, outputProvider: { $1 }, callback: callback)
    }
}

// Extension for output type Void.
extension Fetcher {

    @discardableResult
    public func request(_ endpoint: Endpoint<SupportedType, Void>, input: SupportedType, callback: @escaping (Response<Void>) -> Void) -> Cancellable {
        return run(endpoint: endpoint, inputProvider: { _ in input }, outputProvider: { (_, _: Data) in Void() }, callback: callback)
    }

    @discardableResult
    public func request(_ endpoint: Endpoint<Void, Void>, callback: @escaping (Response<Void>) -> Void) -> Cancellable {
        return run(endpoint: endpoint, inputProvider: { _ in .null }, outputProvider: { (_, _: Data) in Void() }, callback: callback)
    }

    @discardableResult
    public func request(_ endpoint: Endpoint<Data, Void>, input: Data, callback: @escaping (Response<Void>) -> Void) -> Cancellable {
        return run(endpoint: endpoint, inputProvider: { _ in input }, outputProvider: { (_, _: Data) in Void() }, callback: callback)
    }

    @discardableResult
    public func request<IN: Serializable>(_ endpoint: Endpoint<IN, Void>, input: IN, callback: @escaping (Response<Void>) -> Void) -> Cancellable {
        return run(endpoint: endpoint, inputProvider: { _ in self.objectMapper.serialize(input) }, outputProvider: { (_, _: Data) in Void() }, callback: callback)
    }

    @discardableResult
    public func request<IN: Encodable>(_ endpoint: Endpoint<IN, Void>, input: IN, callback: @escaping (Response<Void>) -> Void) -> Cancellable {
        return run(endpoint: endpoint, inputProvider: { _ in try self.objectMapper.encode(input) }, outputProvider: { (_, _: Data) in Void() }, callback: callback)
    }

    @discardableResult
    public func request<IN: Serializable & Encodable>(_ endpoint: Endpoint<IN, Void>, input: IN, callback: @escaping (Response<Void>) -> Void) -> Cancellable {
        return run(endpoint: endpoint, inputProvider: { _ in self.objectMapper.serialize(input) }, outputProvider: { (_, _: Data) in Void() }, callback: callback)
    }
}

// Extension for output type Data.
extension Fetcher {

    @discardableResult
    public func request(_ endpoint: Endpoint<SupportedType, Data>, input: SupportedType, callback: @escaping (Response<Data>) -> Void) -> Cancellable {
        return run(endpoint: endpoint, inputProvider: { _ in input }, outputProvider: { $1 }, callback: callback)
    }

    @discardableResult
    public func request(_ endpoint: Endpoint<Void, Data>, callback: @escaping (Response<Data>) -> Void) -> Cancellable {
        return run(endpoint: endpoint, inputProvider: { _ in .null }, outputProvider: { $1 }, callback: callback)
    }

    @discardableResult
    public func request(_ endpoint: Endpoint<Data, Data>, input: Data, callback: @escaping (Response<Data>) -> Void) -> Cancellable {
        return run(endpoint: endpoint, inputProvider: { _ in input }, outputProvider: { $1 }, callback: callback)
    }

    @discardableResult
    public func request<IN: Serializable>(_ endpoint: Endpoint<IN, Data>, input: IN, callback: @escaping (Response<Data>) -> Void) -> Cancellable {
        return run(endpoint: endpoint, inputProvider: { _ in self.objectMapper.serialize(input) }, outputProvider: { $1 }, callback: callback)
    }

    @discardableResult
    public func request<IN: Encodable>(_ endpoint: Endpoint<IN, Data>, input: IN, callback: @escaping (Response<Data>) -> Void) -> Cancellable {
        return run(endpoint: endpoint, inputProvider: { _ in try self.objectMapper.encode(input) }, outputProvider: { $1 }, callback: callback)
    }

    @discardableResult
    public func request<IN: Serializable & Encodable>(_ endpoint: Endpoint<IN, Data>, input: IN, callback: @escaping (Response<Data>) -> Void) -> Cancellable {
        return run(endpoint: endpoint, inputProvider: { _ in self.objectMapper.serialize(input) }, outputProvider: { $1 }, callback: callback)
    }
}

// Extension for output type Deserializable.
extension Fetcher {

    @discardableResult
    public func request<OUT: Deserializable>(_ endpoint: Endpoint<SupportedType, OUT>, input: SupportedType, callback: @escaping (Response<OUT>) -> Void) -> Cancellable {
        return run(
            endpoint: endpoint,
            inputProvider: { _ in input },
            outputProvider: { try self.objectMapper.deserialize(OUT.self, from: $1) },
            callback: callback)
    }

    @discardableResult
    public func request<OUT: Deserializable>(_ endpoint: Endpoint<Void, OUT>, callback: @escaping (Response<OUT>) -> Void) -> Cancellable {
        return run(
            endpoint: endpoint,
            inputProvider: { _ in .null },
            outputProvider: { try self.objectMapper.deserialize(OUT.self, from: $1) },
            callback: callback)
    }

    @discardableResult
    public func request<OUT: Deserializable>(_ endpoint: Endpoint<Data, OUT>, input: Data, callback: @escaping (Response<OUT>) -> Void) -> Cancellable {
        return run(
            endpoint: endpoint,
            inputProvider: { _ in input },
            outputProvider: { try self.objectMapper.deserialize(OUT.self, from: $1) },
            callback: callback)
    }

    @discardableResult
    public func request<IN: Serializable, OUT: Deserializable>(_ endpoint: Endpoint<IN, OUT>, input: IN, callback: @escaping (Response<OUT>) -> Void) -> Cancellable {
        return run(
            endpoint: endpoint,
            inputProvider: { _ in self.objectMapper.serialize(input) },
            outputProvider: { try self.objectMapper.deserialize(OUT.self, from: $1) },
            callback: callback)
    }

    @discardableResult
    public func request<IN: Encodable, OUT: Deserializable>(_ endpoint: Endpoint<IN, OUT>, input: IN, callback: @escaping (Response<OUT>) -> Void) -> Cancellable {
        return run(
            endpoint: endpoint,
            inputProvider: { _ in try self.objectMapper.encode(input) },
            outputProvider: { try self.objectMapper.deserialize(OUT.self, from: $1) },
            callback: callback)
    }

    @discardableResult
    public func request<IN: Serializable & Encodable, OUT: Deserializable>(_ endpoint: Endpoint<IN, OUT>, input: IN, callback: @escaping (Response<OUT>) -> Void) -> Cancellable {
        return run(
            endpoint: endpoint,
            inputProvider: { _ in self.objectMapper.serialize(input) },
            outputProvider: { try self.objectMapper.deserialize(OUT.self, from: $1) },
            callback: callback)
    }
}

// Extension for output type Decodable.
extension Fetcher {

    @discardableResult
    public func request<OUT: Decodable>(_ endpoint: Endpoint<SupportedType, OUT>, input: SupportedType, callback: @escaping (Response<OUT>) -> Void) -> Cancellable {
        return run(
            endpoint: endpoint,
            inputProvider: { _ in input },
            outputProvider: { try self.objectMapper.decode(OUT.self, from: $1) },
            callback: callback)
    }

    @discardableResult
    public func request<OUT: Decodable>(_ endpoint: Endpoint<Void, OUT>, callback: @escaping (Response<OUT>) -> Void) -> Cancellable {
        return run(
            endpoint: endpoint,
            inputProvider: { _ in .null },
            outputProvider: { try self.objectMapper.decode(OUT.self, from: $1) },
            callback: callback)
    }

    @discardableResult
    public func request<OUT: Decodable>(_ endpoint: Endpoint<Data, OUT>, input: Data, callback: @escaping (Response<OUT>) -> Void) -> Cancellable {
        return run(
            endpoint: endpoint,
            inputProvider: { _ in input },
            outputProvider: { try self.objectMapper.decode(OUT.self, from: $1) },
            callback: callback)
    }

    @discardableResult
    public func request<IN: Serializable, OUT: Decodable>(_ endpoint: Endpoint<IN, OUT>, input: IN, callback: @escaping (Response<OUT>) -> Void) -> Cancellable {
        return run(
            endpoint: endpoint,
            inputProvider: { _ in self.objectMapper.serialize(input) },
            outputProvider: { try self.objectMapper.decode(OUT.self, from: $1) },
            callback: callback)
    }

    @discardableResult
    public func request<IN: Encodable, OUT: Decodable>(_ endpoint: Endpoint<IN, OUT>, input: IN, callback: @escaping (Response<OUT>) -> Void) -> Cancellable {
        return run(
            endpoint: endpoint,
            inputProvider: { _ in try self.objectMapper.encode(input) },
            outputProvider: { try self.objectMapper.decode(OUT.self, from: $1) },
            callback: callback)
    }

    @discardableResult
    public func request<IN: Serializable & Encodable, OUT: Decodable>(_ endpoint: Endpoint<IN, OUT>, input: IN, callback: @escaping (Response<OUT>) -> Void) -> Cancellable {
        return run(
            endpoint: endpoint,
            inputProvider: { _ in self.objectMapper.serialize(input) },
            outputProvider: { try self.objectMapper.decode(OUT.self, from: $1) },
            callback: callback)
    }
}


// Extension for output type Deserializable & Decodable.
extension Fetcher {

    @discardableResult
    public func request<OUT: Deserializable & Decodable>(_ endpoint: Endpoint<SupportedType, OUT>, input: SupportedType, callback: @escaping (Response<OUT>) -> Void) -> Cancellable {
        return run(
            endpoint: endpoint,
            inputProvider: { _ in input },
            outputProvider: { try self.objectMapper.deserialize(OUT.self, from: $1) },
            callback: callback)
    }

    @discardableResult
    public func request<OUT: Deserializable & Decodable>(_ endpoint: Endpoint<Void, OUT>, callback: @escaping (Response<OUT>) -> Void) -> Cancellable {
        return run(
            endpoint: endpoint,
            inputProvider: { _ in .null },
            outputProvider: { try self.objectMapper.deserialize(OUT.self, from: $1) },
            callback: callback)
    }

    @discardableResult
    public func request<OUT: Deserializable & Decodable>(_ endpoint: Endpoint<Data, OUT>, input: Data, callback: @escaping (Response<OUT>) -> Void) -> Cancellable {
        return run(
            endpoint: endpoint,
            inputProvider: { _ in input },
            outputProvider: { try self.objectMapper.deserialize(OUT.self, from: $1) },
            callback: callback)
    }

    @discardableResult
    public func request<IN: Serializable, OUT: Deserializable & Decodable>(_ endpoint: Endpoint<IN, OUT>, input: IN, callback: @escaping (Response<OUT>) -> Void) -> Cancellable {
        return run(
            endpoint: endpoint,
            inputProvider: { _ in self.objectMapper.serialize(input) },
            outputProvider: { try self.objectMapper.deserialize(OUT.self, from: $1) },
            callback: callback)
    }

    @discardableResult
    public func request<IN: Encodable, OUT: Deserializable & Decodable>(_ endpoint: Endpoint<IN, OUT>, input: IN, callback: @escaping (Response<OUT>) -> Void) -> Cancellable {
        return run(
            endpoint: endpoint,
            inputProvider: { _ in try self.objectMapper.encode(input) },
            outputProvider: { try self.objectMapper.deserialize(OUT.self, from: $1) },
            callback: callback)
    }

    @discardableResult
    public func request<IN: Serializable & Encodable, OUT: Deserializable & Decodable>(_ endpoint: Endpoint<IN, OUT>, input: IN, callback: @escaping (Response<OUT>) -> Void) -> Cancellable {
        return run(
            endpoint: endpoint,
            inputProvider: { _ in self.objectMapper.serialize(input) },
            outputProvider: { try self.objectMapper.deserialize(OUT.self, from: $1) },
            callback: callback)
    }
}
