//
//  RequestLoggerTest.swift
//  Fetcher
//
//  Created by Filip Dolnik on 26.01.17.
//  Copyright © 2017 Brightify. All rights reserved.
//

import Quick
import Nimble
import Fetcher

class RequestLoggerTest: QuickSpec {
    
    override func spec() {
        describe("RequestLogger") {
            describe("deenhance") {
                it("logs info about response based on RequestLogging") {
                    self.logTest(expected: "----- Begin of request log -----\n\nResponse status code: 500\n\n----- End of request log -----\n",
                                 log: RequestLogging.responseCode)
                }
                it("uses defaultOptions if no RequestLogging is found") {
                    self.logTest(expected: "----- Begin of request log -----\n\nRequest url: GET xyz\n\n----- End of request log -----\n",
                                 log: nil, defaultLogging: RequestLogging.requestUrl)
                }
                it("does nothing if logging is disabled") {
                    self.logTest(expected: "", log: RequestLogging.disabled)
                }
            }
        }
    }
    
    private func logTest(expected: String, log: RequestLogging?, defaultLogging: RequestLogging? = nil, file: String = #file, line: UInt = #line) {
        let fetcher = Fetcher(requestPerformer: TestData.RequestPerformerStub())
        let endpoint: GET<Void, Void>
        if let log = log {
            endpoint = GET("xyz", modifiers: log)
        } else {
            endpoint = GET("xyz")
        }
        var result = ""
        
        if let defaultLogging = defaultLogging {
            fetcher.register(requestEnhancers: RequestLogger(defaultOptions: defaultLogging) { result = $0 })
        } else {
            fetcher.register(requestEnhancers: RequestLogger() { result = $0 })
        }
        
        fetcher.request(endpoint) { _ in
        }
        
        expect(result, file: file, line: line).toEventually(equal(expected))
    }
}
