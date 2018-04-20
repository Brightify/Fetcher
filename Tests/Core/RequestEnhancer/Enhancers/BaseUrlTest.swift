//
//  BaseUrlTest.swift
//  Fetcher
//
//  Created by Filip Dolnik on 26.01.17.
//  Copyright © 2017 Brightify. All rights reserved.
//

import Quick
import Nimble
import Fetcher

class BaseUrlTest: QuickSpec {
    
    override func spec() {
        describe("BaseUrl") {
            let fetcher = Fetcher(requestPerformer: TestData.RequestPerformerStub())
            
            it("appends prefix to url (RequestEnhancer)") {
                let endpoint: GET<Void, Void> = GET("xyz", modifiers: BaseUrl(string: "abc"))
                var url: String?
                
                fetcher.request(endpoint) {
                    url = $0.request.url?.absoluteString
                }
                
                expect(url).toEventually(equal("abc/xyz"))
            }
            it("solves conflicts by priority") {
                let endpoint: GET<Void, Void> = GET("xyz", modifiers: BaseUrl(string: "abc"),
                                                    BaseUrl(string: "qwe", priority: .high), BaseUrl(string: "asd", priority: .low))
                var url: String?
                
                fetcher.request(endpoint) {
                    url = $0.request.url?.absoluteString
                }
                
                expect(url).toEventually(equal("qwe/xyz"))
            }
            it("does nothing if baseUrl is nil") {
                let endpoint: GET<Void, Void> = GET("xyz", modifiers: BaseUrl(string: nil))
                var url: String?
                
                fetcher.request(endpoint) {
                    url = $0.request.url?.absoluteString
                }
                
                expect(url).toEventually(equal("xyz"))
            }
            it("constructs successfully using URL") {
                let endpoint: GET<Void, Void> = GET("xyz", modifiers: BaseUrl(url: URL(string: "abc")))
                var url: String?

                fetcher.request(endpoint) {
                    url = $0.request.url?.absoluteString
                }

                expect(url).toEventually(equal("abc/xyz"))
            }
        }
    }
}
