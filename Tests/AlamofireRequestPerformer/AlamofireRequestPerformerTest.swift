//
//  AlamofireRequestPerformerTest.swift
//  Fetcher
//
//  Created by Filip Dolnik on 26.01.17.
//  Copyright © 2017 Brightify. All rights reserved.
//

import Quick
import Nimble
import Fetcher

class AlamofireRequestPerformerTest: QuickSpec {
    
    override func spec() {
        describe("AlamofireRequestPerformer") {
            describe("perform") {
                let requestPerformer = AlamofireRequestPerformer()
                
                it("calls callback with successful response if Request is valid") {
                    let request = TestData.request(url: "https://api.github.com/zen")
                    var called = false
                    
                    _ = requestPerformer.perform(request: request) { response in
                        called = true
                        expect(response.result.value).toNot(beNil())
                    }
                    
                    expect(called).toEventually(beTrue(), timeout: 10)
                }
                it("calls callback with failure response if Request is not valid") {
                    let request = TestData.request(url: "https://xxx")
                    var called = false
                    
                    _ = requestPerformer.perform(request: request) { response in
                        called = true
                        expect(response.result.value).to(beNil())
                    }
                    
                    expect(called).toEventually(beTrue(), timeout: 10)
                }
            }
        }
    }
}
