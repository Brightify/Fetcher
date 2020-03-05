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
    public struct UnsupportedProtobufContentTypeError: Error {
        public let contentType: String?

        init(contentType: String?) {
            self.contentType = contentType
        }
    }

    internal func inputProvider<IN: Message>(input: IN) -> (Request) throws -> Data {
        return { request in
            switch request.contentType {
            case Headers.ContentType.applicationJson?:
                return try input.jsonUTF8Data()

            // If no contentType hasn't been set (= nil), we'll always send binary
            case Headers.ContentType.protocolBuffers?, nil:
                return try input.serializedData()

            // If the content type is not supported by ProtoBuf, we error out
            default:
                throw UnsupportedProtobufContentTypeError(contentType: request.contentType?.value)
            }
        }
    }

    internal func outputProvider<OUT: Message>(response: Response<Data>, data: Data) throws -> OUT {
        let possibleContentType = response.contentType?.value ?? response.request.accepts?.types.first

        switch possibleContentType {
        case Headers.ContentType.applicationJson.value?:
            return try OUT(jsonUTF8Data: data)
        // If no contentType hasn't been set (= nil), we'll always assume it's binary
        case Headers.ContentType.protocolBuffers.value?, nil:
            return try OUT(serializedData: data)
        default:
            throw UnsupportedProtobufContentTypeError(contentType: possibleContentType)
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
