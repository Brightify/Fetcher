//
//  URLQueryItemTest.swift
//  Fetcher
//
//  Created by Matyáš Kříž on 15/12/2017.
//  Copyright © 2017 Brightify. All rights reserved.
//

import Quick
import Nimble
import Fetcher
import Foundation

final class URLQueryItemTest: QuickSpec {
    override func spec() {
        describe("QueryParam") {
            let fetcher = Fetcher(requestPerformer: TestData.RequestPerformerStub())

            context("when only using one query modifier") {
                let endpoint: GET<Void, Void> = GET("xyz", modifiers: URLQueryItem(name: "name", value: "hallo warld"))
                it("appends the query") {
                    var url: String?

                    fetcher.request(endpoint) {
                        url = $0.request.url?.absoluteString
                    }

                    expect(url).toEventually(equal("xyz?name=hallo%20warld"))
                }
            }
            context("when using a query modifier without value") {
                let endpoint: GET<Void, Void> = GET("xyz", modifiers: URLQueryItem(name: "name", value: nil))
                it("appends the query") {
                    var url: String?

                    fetcher.request(endpoint) {
                        url = $0.request.url?.absoluteString
                    }

                    expect(url).toEventually(equal("xyz?name"))
                }
            }
            context("when using multiple queries with values") {
                let endpoint: GET<Void, Void> = GET("xyz", modifiers: URLQueryItem(name: "name", value: "testing"), URLQueryItem(name: "nametu", value: "valu ta"))
                it("appends all the queries") {
                    var url: String?

                    fetcher.request(endpoint) {
                        url = $0.request.url?.absoluteString
                    }

                    expect(url).toEventually(equal("xyz?name=testing&nametu=valu%20ta"))
                }
            }
            context("when using multiple queries without values") {
                let endpoint: GET<Void, Void> = GET("xyz", modifiers: URLQueryItem(name: "name", value: nil), URLQueryItem(name: "nametu", value: nil))
                it("appends all the queries") {
                    var url: String?

                    fetcher.request(endpoint) {
                        url = $0.request.url?.absoluteString
                    }

                    expect(url).toEventually(equal("xyz?name&nametu"))
                }
            }
            context("when mixing queries with values with queries without values") {
                let endpoint: GET<Void, Void> = GET("xyz", modifiers: URLQueryItem(name: "name", value: nil), URLQueryItem(name: "nametu", value: "valu ta"))
                it("appends all the queries") {
                    var url: String?

                    fetcher.request(endpoint) {
                        url = $0.request.url?.absoluteString
                    }

                    expect(url).toEventually(equal("xyz?name&nametu=valu%20ta"))
                }
            }
            context("when duplicating queries with values") {
                let endpoint: GET<Void, Void> = GET("xyz", modifiers: URLQueryItem(name: "name", value: "value"), URLQueryItem(name: "name", value: "valu ta"))
                it("appends all the queries") {
                    var url: String?

                    fetcher.request(endpoint) {
                        url = $0.request.url?.absoluteString
                    }

                    expect(url).toEventually(equal("xyz?name=value&name=valu%20ta"))
                }
            }
            context("when duplicating queries with no values") {
                let endpoint: GET<Void, Void> = GET("xyz", modifiers: URLQueryItem(name: "name", value: nil), URLQueryItem(name: "name", value: nil))
                it("appends all the queries") {
                    var url: String?

                    fetcher.request(endpoint) {
                        url = $0.request.url?.absoluteString
                    }

                    expect(url).toEventually(equal("xyz?name&name"))
                }
            }
            context("when duplicating queries with values and no values") {
                let endpoint: GET<Void, Void> = GET("xyz", modifiers: URLQueryItem(name: "name", value: nil), URLQueryItem(name: "name", value: "valu ta"))
                it("appends all the queries") {
                    var url: String?

                    fetcher.request(endpoint) {
                        url = $0.request.url?.absoluteString
                    }

                    expect(url).toEventually(equal("xyz?name&name=valu%20ta"))
                }
            }
        }
    }
}
