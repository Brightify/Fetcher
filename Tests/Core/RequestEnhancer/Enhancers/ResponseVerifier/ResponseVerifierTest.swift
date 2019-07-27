//
//  ResponseVerifierTest.swift
//  Fetcher
//
//  Created by Filip Dolnik on 26.01.17.
//  Copyright © 2017 Brightify. All rights reserved.
//

import Quick
import Nimble
import Fetcher
import DataMapper

extension Result {
    var value: Success? {
        switch self {
        case .success(let value):
            return value
        case .failure:
            return nil
        }
    }

    var error: Failure? {
        switch self {
        case .success:
            return nil
        case .failure(let error):
            return error
        }
    }
}

class ResponseVerifierTest: QuickSpec {
    
    override func spec() {
        describe("ResponseVerifier") {
            let fetcher = Fetcher(requestPerformer: TestData.RequestPerformerStub())
            
            it("changes result of response to failure if error is returned by verify") {
                let endpoint: GET<Void, Void> = GET("xyz", modifiers: ResponseVerifierStub(error: .invalidStatusCode))
                var called = false
                
                fetcher.request(endpoint) {
                    if let error = $0.result.error, case FetcherError.invalidStatusCode = error {
                    } else {
                        fail()
                    }
                    
                    called = true
                }
                
                expect(called).toEventually(beTrue(), timeout: 5)
            }
            it("does nothing if nil is returned by verify") {
                let endpoint: GET<Void, Void> = GET("xyz", modifiers: ResponseVerifierStub(error: nil))
                var called = false
                
                fetcher.request(endpoint) {
                    expect($0.result.value).toNot(beNil())
                    
                    called = true
                }
                
                expect(called).toEventually(beTrue())
            }
        }
    }
    
    private struct ResponseVerifierStub: ResponseVerifier {
        
        let error: FetcherError?
        
        func verify(response: Response<Data>) -> FetcherError? {
            return error
        }
    }
}
