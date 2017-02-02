//
//  NoErrorHandlerTest.swift
//  Fetcher
//
//  Created by Filip Dolnik on 27.01.17.
//  Copyright © 2017 Brightify. All rights reserved.
//

import Quick
import Nimble
import Fetcher
import DataMapper

class NoErrorHandlerTest: QuickSpec {
    
    override func spec() {
        describe("NoErrorHandlerTest") {
            describe("canResolveError") {
                it("returns always false") {
                    expect(NoErrorHandler().canResolveError(response: TestData.response(url: "a"))).to(beFalse())
                }
            }
            describe("resolveError") {
                it("does nothing") {
                    var retryCalled = false
                    let request = TestData.request(url: "a") { _ in
                        retryCalled = true
                    }
                    let response: Response<SupportedType> = TestData.response(request: request)
                    
                    NoErrorHandler().resolveError(response: response, callback: { _ in })
                    
                    expect(retryCalled).to(beFalse())
                }
            }
        }
    }
}
