//
//  ApiTest.swift
//  Fetcher
//
//  Created by Filip Dolnik on 26.01.17.
//  Copyright © 2017 Brightify. All rights reserved.
//

import DataMapper
import Fetcher
import Foundation

private struct EndpointProviderStub: EndpointProvider {
}

private struct ErrorHandlerStub: ErrorHandler {
    
    func canResolveError(response: Response<Data>) -> Bool {
        return false
    }
    
    func resolveError(response: Response<Data>, callback: (Response<Data>) -> Void) {
    }
}

private struct HeaderStub: Header {
    
    let name: String
    let value: String
}

private struct InputEncodingStub: InputEncoding {
}

private struct InputEncodingWithEncoderStub: InputEncodingWithEncoder {
    
    func encode(input: SupportedType, to request: inout Request) {
    }
}

private struct RequestEnhancerStub: RequestEnhancer {
}

private struct RequestModifierStub: RequestModifier {
}

private struct ResponseVerifierStub: ResponseVerifier {
    
    func verify(response: Response<Data>) -> FetcherError? {
        return nil
    }
}

private struct DataEncoderStub: DataEncoder {
    
    func encodeToQueryString(input: SupportedType, to request: inout Request) {
    }
    
    func encodeToHttpBody(input: SupportedType, to request: inout Request) {
    }
    
    func decode(response: Response<Data>) -> Response<SupportedType> {
        return response.map { _ in .null }
    }
}

private struct RequestPerformerStub: RequestPerformer {
    
    let dataEncoder: DataEncoder
    
    func perform(request: Request, callback: @escaping (Response<Data>) -> Cancellable) -> Cancellable {
        return Cancellable()
    }
}
