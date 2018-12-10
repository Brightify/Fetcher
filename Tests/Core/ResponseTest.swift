//
//  ResponseTest.swift
//  Fetcher
//
//  Created by Filip Dolnik on 28.01.17.
//  Copyright © 2017 Brightify. All rights reserved.
//

import Quick
import Nimble
import Fetcher
import Foundation

class ResponseTest: QuickSpec {
    
    override func spec() {
        describe("Response") { 
            describe("rawString") {
                it("returns nil if rawResponse is nil") {
                    let response = Response(result: .success(1), rawResponse: nil, rawData: nil, request: TestData.request(url: "a"))
                    
                    expect(response.rawString).to(beNil())
                }
                it("returns nil if rawData is nil") {
                    let response = TestData.response(url: "a", result: .success(1), data: nil)
                    
                    expect(response.rawString).to(beNil())
                }
                it("returns data decoded using Latin1 if no coding is specified") {
                    let response = TestData.response(url: "a", result: .success(1), data: "abc".data(using: .isoLatin1))
                    
                    expect(response.rawString) == "abc"
                }
                it("returns data decoded using specified coding") {
                    let request = TestData.request(url: "a")
                    let rawResponse = HTTPURLResponse(url: request.url!, mimeType: "", expectedContentLength: 3, textEncodingName: "utf-8")
                    let data = "ěšč".data(using: .utf8)
                    let response = Response(result: .success(1), rawResponse: rawResponse, rawData: data, request: request)
                    
                    expect(response.rawString) == "ěšč"
                }
            }
        }
    }
}
    
