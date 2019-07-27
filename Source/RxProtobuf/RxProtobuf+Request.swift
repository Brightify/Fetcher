//
//  RxProtobuf+Request.swift
//  Fetcher
//
//  Created by Tadeas Kriz on 27/07/2019.
//  Copyright © 2019 Brightify. All rights reserved.
//

import DataMapper
import Foundation
import SwiftProtobuf
import RxSwift

// Extension for input and output type SwiftProtobuf.Message.
extension RxFetcher {

    @discardableResult
    public func request<IN: SwiftProtobuf.Message, OUT: SwiftProtobuf.Message>(
        _ endpoint: Endpoint<IN, OUT>,
        input: IN
    ) -> Single<Response<OUT>> {
        return observe { self.fetcher.request(endpoint, input: input, callback: $0) }
    }
}

// Extension for input type SwiftProtobuf.Message.
extension RxFetcher {

    @discardableResult
    public func request<IN: SwiftProtobuf.Message>(
        _ endpoint: Endpoint<IN, SupportedType>,
        input: IN
    ) -> Single<Response<SupportedType>> {
        return observe { self.fetcher.request(endpoint, input: input, callback: $0) }
    }

    @discardableResult
    public func request<IN: SwiftProtobuf.Message>(
        _ endpoint: Endpoint<IN, Void>,
        input: IN
    ) -> Single<Response<Void>> {
        return observe { self.fetcher.request(endpoint, input: input, callback: $0) }
    }

    @discardableResult
    public func request<IN: SwiftProtobuf.Message>(
        _ endpoint: Endpoint<IN, Data>,
        input: IN
    ) -> Single<Response<Data>> {
        return observe { self.fetcher.request(endpoint, input: input, callback: $0) }
    }

    @discardableResult
    public func request<IN: SwiftProtobuf.Message, OUT: Deserializable>(
        _ endpoint: Endpoint<IN, OUT>,
        input: IN,
        callback: @escaping (Response<OUT>) -> Void
        ) -> Single<Response<OUT>> {
        return observe { self.fetcher.request(endpoint, input: input, callback: $0) }
    }

    @discardableResult
    public func request<IN: SwiftProtobuf.Message, OUT: Decodable>(
        _ endpoint: Endpoint<IN, OUT>,
        input: IN,
        callback: @escaping (Response<OUT>) -> Void
        ) -> Single<Response<OUT>> {
        return observe { self.fetcher.request(endpoint, input: input, callback: $0) }
    }

    @discardableResult
    public func request<IN: SwiftProtobuf.Message, OUT: Deserializable & Decodable>(
        _ endpoint: Endpoint<IN, OUT>,
        input: IN,
        callback: @escaping (Response<OUT>) -> Void
        ) -> Single<Response<OUT>> {
        return observe { self.fetcher.request(endpoint, input: input, callback: $0) }
    }
}

// Extension for output type SwiftProtobuf.Message.
extension RxFetcher {

    @discardableResult
    public func request<OUT: SwiftProtobuf.Message>(
        _ endpoint: Endpoint<SupportedType, OUT>,
        input: SupportedType
    ) -> Single<Response<OUT>> {
        return observe { self.fetcher.request(endpoint, input: input, callback: $0) }
    }

    @discardableResult
    public func request<OUT: SwiftProtobuf.Message>(_ endpoint: Endpoint<Void, OUT>) -> Single<Response<OUT>> {
        return observe { self.fetcher.request(endpoint, callback: $0) }
    }

    @discardableResult
    public func request<OUT: SwiftProtobuf.Message>(
        _ endpoint: Endpoint<Data, OUT>,
        input: Data
    ) -> Single<Response<OUT>> {
        return observe { self.fetcher.request(endpoint, input: input, callback: $0) }
    }

    @discardableResult
    public func request<IN: Serializable, OUT: SwiftProtobuf.Message>(
        _ endpoint: Endpoint<IN, OUT>,
        input: IN
    ) -> Single<Response<OUT>> {
        return observe { self.fetcher.request(endpoint, input: input, callback: $0) }
    }

    @discardableResult
    public func request<IN: Encodable, OUT: SwiftProtobuf.Message>(
        _ endpoint: Endpoint<IN, OUT>,
        input: IN
    ) -> Single<Response<OUT>> {
        return observe { self.fetcher.request(endpoint, input: input, callback: $0) }
    }

    @discardableResult
    public func request<IN: Serializable & Encodable, OUT: SwiftProtobuf.Message>(
        _ endpoint: Endpoint<IN, OUT>,
        input: IN
    ) -> Single<Response<OUT>> {
        return observe { self.fetcher.request(endpoint, input: input, callback: $0) }
    }
}
