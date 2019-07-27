//
//  Protobuf+Request.swift
//  Fetcher
//
//  Created by Tadeas Kriz on 27/07/2019.
//  Copyright © 2019 Brightify. All rights reserved.
//

import DataMapper
import Foundation
import SwiftProtobuf

// Extension for input and output type SwiftProtobuf.Message.
extension Fetcher {

    @discardableResult
    public func request<IN: SwiftProtobuf.Message, OUT: SwiftProtobuf.Message>(
        _ endpoint: Endpoint<IN, OUT>,
        input: IN,
        callback: @escaping (Response<OUT>) -> Void
    ) -> Cancellable {
        return run(
            endpoint: endpoint,
            inputProvider: { try input.serializedData() },
            outputProvider: { try OUT(serializedData: $0) },
            callback: callback)
    }
}

// Extension for input type SwiftProtobuf.Message.
extension Fetcher {

    @discardableResult
    public func request<IN: SwiftProtobuf.Message>(
        _ endpoint: Endpoint<IN, SupportedType>,
        input: IN,
        callback: @escaping (Response<SupportedType>) -> Void
    ) -> Cancellable {
        return run(endpoint: endpoint, inputProvider: { try input.serializedData() }, outputProvider: { $0 }, callback: callback)
    }

    @discardableResult
    public func request<IN: SwiftProtobuf.Message>(
        _ endpoint: Endpoint<IN, Void>,
        input: IN,
        callback: @escaping (Response<Void>) -> Void
    ) -> Cancellable {
        return run(endpoint: endpoint, inputProvider: { try input.serializedData() }, outputProvider: { (_: Data) in Void() }, callback: callback)
    }

    @discardableResult
    public func request<IN: SwiftProtobuf.Message>(
        _ endpoint: Endpoint<IN, Data>,
        input: IN,
        callback: @escaping (Response<Data>) -> Void
    ) -> Cancellable {
        return run(endpoint: endpoint, inputProvider: { try input.serializedData() }, outputProvider: { $0 }, callback: callback)
    }

    @discardableResult
    public func request<IN: SwiftProtobuf.Message, OUT: Deserializable>(
        _ endpoint: Endpoint<IN, OUT>,
        input: IN,
        callback: @escaping (Response<OUT>) -> Void
    ) -> Cancellable {
        return run(
            endpoint: endpoint,
            inputProvider: { try input.serializedData() },
            outputProvider: { try self.objectMapper.deserialize(OUT.self, from: $0) },
            callback: callback)
    }

    @discardableResult
    public func request<IN: SwiftProtobuf.Message, OUT: Decodable>(
        _ endpoint: Endpoint<IN, OUT>,
        input: IN,
        callback: @escaping (Response<OUT>) -> Void
    ) -> Cancellable {
        return run(
            endpoint: endpoint,
            inputProvider: { try input.serializedData() },
            outputProvider: { try self.objectMapper.decode(OUT.self, from: $0) },
            callback: callback)
    }

    @discardableResult
    public func request<IN: SwiftProtobuf.Message, OUT: Deserializable & Decodable>(
        _ endpoint: Endpoint<IN, OUT>,
        input: IN,
        callback: @escaping (Response<OUT>) -> Void
    ) -> Cancellable {
        return run(
            endpoint: endpoint,
            inputProvider: { try input.serializedData() },
            outputProvider: { try self.objectMapper.deserialize(OUT.self, from: $0) },
            callback: callback)
    }
}

// Extension for output type SwiftProtobuf.Message.
extension Fetcher {

    @discardableResult
    public func request<OUT: SwiftProtobuf.Message>(
        _ endpoint: Endpoint<SupportedType, OUT>,
        input: SupportedType,
        callback: @escaping (Response<OUT>) -> Void
    ) -> Cancellable {
        return run(endpoint: endpoint, inputProvider: { input }, outputProvider: { try OUT(serializedData: $0) }, callback: callback)
    }

    @discardableResult
    public func request<OUT: SwiftProtobuf.Message>(
        _ endpoint: Endpoint<Void, OUT>,
        callback: @escaping (Response<OUT>) -> Void
    ) -> Cancellable {
        return run(endpoint: endpoint, inputProvider: { .null }, outputProvider: { try OUT(serializedData: $0) }, callback: callback)
    }

    @discardableResult
    public func request<OUT: SwiftProtobuf.Message>(
        _ endpoint: Endpoint<Data, OUT>,
        input: Data,
        callback: @escaping (Response<OUT>) -> Void
    ) -> Cancellable {
        return run(endpoint: endpoint, inputProvider: { input }, outputProvider: { try OUT(serializedData: $0) }, callback: callback)
    }

    @discardableResult
    public func request<IN: Serializable, OUT: SwiftProtobuf.Message>(
        _ endpoint: Endpoint<IN, OUT>,
        input: IN,
        callback: @escaping (Response<OUT>) -> Void
    ) -> Cancellable {
        return run(
            endpoint: endpoint,
            inputProvider: { self.objectMapper.serialize(input) },
            outputProvider: { try OUT(serializedData: $0) },
            callback: callback)
    }

    @discardableResult
    public func request<IN: Encodable, OUT: SwiftProtobuf.Message>(
        _ endpoint: Endpoint<IN, OUT>,
        input: IN,
        callback: @escaping (Response<OUT>) -> Void
    ) -> Cancellable {
        return run(
            endpoint: endpoint,
            inputProvider: { try self.objectMapper.encode(input) },
            outputProvider: { try OUT(serializedData: $0) },
            callback: callback)
    }

    @discardableResult
    public func request<IN: Serializable & Encodable, OUT: SwiftProtobuf.Message>(
        _ endpoint: Endpoint<IN, OUT>,
        input: IN,
        callback: @escaping (Response<OUT>) -> Void
    ) -> Cancellable {
        return run(
            endpoint: endpoint,
            inputProvider: { self.objectMapper.serialize(input) },
            outputProvider: { try OUT(serializedData: $0) },
            callback: callback)
    }
}
