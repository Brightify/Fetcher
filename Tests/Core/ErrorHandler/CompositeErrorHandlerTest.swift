//
//  CompositeErrorHandlerTest.swift
//  Fetcher
//
//  Created by Filip Dolnik on 26.01.17.
//  Copyright © 2017 Brightify. All rights reserved.
//

import Quick
import Nimble
import Fetcher
import DataMapper

class CompositeErrorHandlerTest: QuickSpec {
    
    override func spec() {
        describe("CompositeErrorHandler") {
            describe("canResolveError") {
                let handler = CompositeErrorHandler(handlers: ErrorHandlerStub(canResolve: { $0 == 1 }, resolve: {}),
                                                    ErrorHandlerStub(canResolve: { $0 >= 1 }, resolve: {}))
                it("returns true if at least one of handlers can resolve error") {
                    let response1: Response<SupportedType> = TestData.response(url: "a", statusCode: 1)
                    let response2: Response<SupportedType> = TestData.response(url: "a", statusCode: 2)
                    
                    expect(handler.canResolveError(response: response1)).to(beTrue())
                    expect(handler.canResolveError(response: response2)).to(beTrue())
                }
                it("returns false otherwise") {
                    let response: Response<SupportedType> = TestData.response(url: "a", statusCode: 0)
                    
                    expect(handler.canResolveError(response: response)).to(beFalse())
                }
            }
            describe("resolveError") {
                it("calls resolveError on the first handler that can resolve error") {
                    let response: Response<SupportedType> = TestData.response(url: "a", statusCode: 1)
                    var calledFirst = false
                    var calledSecond = false
                    var calledThird = false
                    
                    let handler = CompositeErrorHandler(handlers: [
                        ErrorHandlerStub(canResolve: { $0 == 0 }, resolve: { calledFirst = true }),
                        ErrorHandlerStub(canResolve: { $0 == 1 }, resolve: { calledSecond = true }),
                        ErrorHandlerStub(canResolve: { $0 >= 1 }, resolve: { calledThird = true })
                        ])
                    
                    handler.resolveError(response: response, callback: { _ in })
                    
                    expect(calledFirst).to(beFalse())
                    expect(calledSecond).to(beTrue())
                    expect(calledThird).to(beFalse())
                }
            }
        }
    }
    
    private struct ErrorHandlerStub: ErrorHandler {
        
        var canResolve: (Int) -> Bool
        var resolve: () -> Void
        
        func canResolveError(response: Response<SupportedType>) -> Bool {
            return canResolve(response.rawResponse?.statusCode ?? 0)
        }
        
        func resolveError(response: Response<SupportedType>, callback: (Response<SupportedType>) -> Void) {
            resolve()
        }
    }
}
