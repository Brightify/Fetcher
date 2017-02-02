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
                let endpoint: GET<Void, Void> = GET("xyz", modifiers: BaseUrl(baseUrl: "abc"))
                var url: String?
                
                fetcher.request(endpoint) {
                    url = $0.request.url?.absoluteString
                }
                
                expect(url).toEventually(equal("abc/xyz"))
            }
            it("solve conflicts by priority") {
                let endpoint: GET<Void, Void> = GET("xyz", modifiers: BaseUrl(baseUrl: "abc"),
                                                    BaseUrl(baseUrl: "qwe", priority: .high), BaseUrl(baseUrl: "asd", priority: .low))
                var url: String?
                
                fetcher.request(endpoint) {
                    url = $0.request.url?.absoluteString
                }
                
                expect(url).toEventually(equal("qwe/xyz"))
            }
            it("does nothing if baseUrl is nil") {
                let endpoint: GET<Void, Void> = GET("xyz", modifiers: BaseUrl(baseUrl: nil))
                var url: String?
                
                fetcher.request(endpoint) {
                    url = $0.request.url?.absoluteString
                }
                
                expect(url).toEventually(equal("xyz"))
            }
        }
    }
}
