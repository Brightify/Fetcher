//
//  StatusCodeResponseVerifierTest.swift
//  Fetcher
//
//  Created by Filip Dolnik on 26.01.17.
//  Copyright © 2017 Brightify. All rights reserved.
//

import Quick
import Nimble
import Fetcher
import DataMapper

class StatusCodeResponseVerifierTest: QuickSpec {
    
    override func spec() {
        describe("StatusCodeResponseVerifier") {
            let verifier = StatusCodeResponseVerifier(code: 1)
            
            describe("verify") {
                it("returns invalidStatusCode error if response does not have statusCode set in init") {
                    let response: Response<SupportedType> = TestData.response(url: "a", result: .success(.int(1)), statusCode: 2)
                    
                    if let error = verifier.verify(response: response) {
                        switch error {
                        case .invalidStatusCode:
                            break
                        default:
                            fail()
                        }
                    } else {
                        fail()
                    }
                }
                it("returns nil otherwise") {
                    let response: Response<SupportedType> = TestData.response(url: "a", result: .success(.int(1)), statusCode: 1)
                    
                    expect(verifier.verify(response: response)).to(beNil())
                }
            }
        }
    }
    
    func apiTest() {
        _ = StatusCodeResponseVerifier(codes: [1, 2, 3])
        _ = StatusCodeResponseVerifier(codes: 1, 2, 3)
        _ = StatusCodeResponseVerifier(codes: 1...3)
        _ = StatusCodeResponseVerifier(code: 1)
    }
}
