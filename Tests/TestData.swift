//
//  TestData.swift
//  Fetcher
//
//  Created by Filip Dolnik on 28.01.17.
//  Copyright © 2017 Brightify. All rights reserved.
//

import Fetcher
import DataMapper
import Nimble
import Foundation

struct TestData {
    
    static func request(url: String, retry: @escaping (Request, Int, DispatchTimeInterval, () -> Void) -> Void = { _, _, _, _ in }) -> Request {
        return Request(url: URL(string: url)!, retry: retry, callback: { _ in }, cancellable: Cancellable())
    }
    
    static func response<T>(url: String, result: FetcherResult<T> = .failure(.unknown), statusCode: Int = 500, data: Data? = nil) -> Response<T> {
        return response(request: request(url: url), result: result, statusCode: statusCode, data: data)
    }
    
    static func response<T>(request: Request, result: FetcherResult<T> = .failure(.unknown), statusCode: Int = 500, data: Data? = nil) -> Response<T> {
        let response = HTTPURLResponse(url: request.url!, statusCode: statusCode, httpVersion: "1.2", headerFields: nil)
        return Response(result: result, rawResponse: response, rawData: data, request: request)
    }
    
    static func expect(modifiers: [RequestModifier], file: FileString = #file, line: UInt = #line, toContains headers: [Header]) {
        Nimble.expect(modifiers, file: file, line: line).to(contain(headers) { $0.name == $1.name && $0.value == $1.value })
    }
    
    static func expect(modifiers: [RequestModifier], file: FileString = #file, line: UInt = #line, toContains headers: Header...) {
        expect(modifiers: modifiers, file: file, line: line, toContains: headers)
    }
    
    struct RequestPerformerStub: RequestPerformer {
        
        let dataEncoder: DataEncoder = AlamofireJsonDataEncoder()
        
        var result: FetcherResult<Data> = .success(Data())
        var data: Data = Data()
        
        func perform(request: Request, callback: @escaping (Response<Data>) -> Void) -> Cancellable {
            callback(TestData.response(request: request, result: result, data: data))
            return Cancellable()
        }
    }
}

func contain<T, R>(_ items: [R], compareFunction: @escaping (R, R) -> Bool) -> NonNilMatcherFunc<[T]> {
    return NonNilMatcherFunc { actualExpression, failureMessage in
        failureMessage.postfixMessage = "contain <\(items)>"
        guard let actual = try actualExpression.evaluate() else {
            return false
        }
        
        for item in items {
            if !(actual.flatMap { $0 as? R }.contains(where: { compareFunction($0, item) })) {
                return false
            }
        }
        return true
    }
}
