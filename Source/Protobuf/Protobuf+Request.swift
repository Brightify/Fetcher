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
    internal func inputProvider<IN: Message>(input: IN) -> (Headers.ContentType?) throws -> Data {
        return { contentType in
            switch contentType {
            case Headers.ContentType.protocolBuffers:
                return try input.serializedData()
            default:
                return try input.jsonUTF8Data()
            }
        }
    }

    internal func outputProvider<OUT: Message>(contentType: Headers.ContentType?, data: Data) throws -> OUT {
        switch contentType {
        case Headers.ContentType.protocolBuffers:
            return try OUT(serializedData: data)
        default:
            return try OUT(jsonUTF8Data: data)
        }
    }

    @discardableResult
    public func request<IN: SwiftProtobuf.Message, OUT: SwiftProtobuf.Message>(
        _ endpoint: Endpoint<IN, OUT>,
        input: IN,
        callback: @escaping (Response<OUT>) -> Void
    ) -> Cancellable {
        return run(
            endpoint: endpoint,
            inputProvider: inputProvider(input: input),
            outputProvider: outputProvider,
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
        return run(endpoint: endpoint, inputProvider: inputProvider(input: input), outputProvider: { $1 }, callback: callback)
    }

    @discardableResult
    public func request<IN: SwiftProtobuf.Message>(
        _ endpoint: Endpoint<IN, Void>,
        input: IN,
        callback: @escaping (Response<Void>) -> Void
    ) -> Cancellable {
        return run(endpoint: endpoint, inputProvider: inputProvider(input: input), outputProvider: { (_, _: Data) in Void() }, callback: callback)
    }

    @discardableResult
    public func request<IN: SwiftProtobuf.Message>(
        _ endpoint: Endpoint<IN, Data>,
        input: IN,
        callback: @escaping (Response<Data>) -> Void
    ) -> Cancellable {
        return run(endpoint: endpoint, inputProvider: inputProvider(input: input), outputProvider: { $1 }, callback: callback)
    }

    @discardableResult
    public func request<IN: SwiftProtobuf.Message, OUT: Deserializable>(
        _ endpoint: Endpoint<IN, OUT>,
        input: IN,
        callback: @escaping (Response<OUT>) -> Void
    ) -> Cancellable {
        return run(
            endpoint: endpoint,
            inputProvider: inputProvider(input: input),
            outputProvider: { try self.objectMapper.deserialize(OUT.self, from: $1) },
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
            inputProvider: inputProvider(input: input),
            outputProvider: { try self.objectMapper.decode(OUT.self, from: $1) },
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
            inputProvider: inputProvider(input: input),
            outputProvider: { try self.objectMapper.deserialize(OUT.self, from: $1) },
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
        return run(endpoint: endpoint, inputProvider: { _ in input }, outputProvider: outputProvider, callback: callback)
    }

    @discardableResult
    public func request<OUT: SwiftProtobuf.Message>(
        _ endpoint: Endpoint<Void, OUT>,
        callback: @escaping (Response<OUT>) -> Void
    ) -> Cancellable {
        return run(endpoint: endpoint, inputProvider: { _ in .null }, outputProvider: outputProvider, callback: callback)
    }

    @discardableResult
    public func request<OUT: SwiftProtobuf.Message>(
        _ endpoint: Endpoint<Data, OUT>,
        input: Data,
        callback: @escaping (Response<OUT>) -> Void
    ) -> Cancellable {
        return run(endpoint: endpoint, inputProvider: { _ in input }, outputProvider: outputProvider, callback: callback)
    }

    @discardableResult
    public func request<IN: Serializable, OUT: SwiftProtobuf.Message>(
        _ endpoint: Endpoint<IN, OUT>,
        input: IN,
        callback: @escaping (Response<OUT>) -> Void
    ) -> Cancellable {
        return run(
            endpoint: endpoint,
            inputProvider: { _ in self.objectMapper.serialize(input) },
            outputProvider: outputProvider,
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
            inputProvider: { _ in try self.objectMapper.encode(input) },
            outputProvider: outputProvider,
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
            inputProvider: { _ in self.objectMapper.serialize(input) },
            outputProvider: outputProvider,
            callback: callback)
    }
}
