//
//  HeaderTest.swift
//  Fetcher
//
//  Created by Filip Dolnik on 26.01.17.
//  Copyright © 2017 Brightify. All rights reserved.
//

import Quick
import Nimble
import Fetcher

class HeaderTest: QuickSpec {
    
    override func spec() {
        describe("Header") {
            it("sets header to Request (RequestEnhancer)") {
                let fetcher = Fetcher(requestPerformer: TestData.RequestPerformerStub())
                let endpoint: GET<Void, Void> = GET("xyz", modifiers: Headers.Charset.utf8)
                var called = false
                
                fetcher.request(endpoint) {
                    TestData.expect(modifiers: $0.request.modifiers, toContains: Headers.Charset.utf8)
                    
                    called = true
                }
                
                expect(called).toEventually(beTrue())
            }
        }
    }
}
