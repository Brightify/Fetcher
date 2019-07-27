//
//  AlamofireJsonDataEncoderTest.swift
//  Fetcher
//
//  Created by Filip Dolnik on 26.01.17.
//  Copyright © 2017 Brightify. All rights reserved.
//

import Quick
import Nimble
import Fetcher
import DataMapper

class AlamofireJsonDataEncoderTest: QuickSpec {
    
    override func spec() {
        describe("AlamofireJsonDataEncoder") {
            let encoder = AlamofireJsonDataEncoder()
            let input = SupportedType.dictionary(["text": .string("a"), "number": .double(1.1)])
            
            describe("encodeToQueryString") {
                it("encodes input into url of request") {
                    var request = TestData.request(url: "path")
                    
                    encoder.encodeToQueryString(input: input, to: &request)
                    
                    expect(request.url?.absoluteString) == "path?number=1.1&text=a"
                }
                it("does nothing if type is .null") {
                    var request = TestData.request(url: "path")
                    
                    encoder.encodeToQueryString(input: .null, to: &request)
                    
                    expect(request.url?.absoluteString) == "path"
                }
            }
            describe("encodeToHttpBody") {
                it("encodes input to httpBody") {
                    var request = TestData.request(url: "path")
                    
                    encoder.encodeToHttpBody(input: input, to: &request)
                    
                    expect(request.httpBody).toNot(beNil())
                    if let data = request.httpBody, let text = String(data: data, encoding: .utf8) {
                        expect(text).to(equal("{\"text\":\"a\",\"number\":1.1}") || equal("{\"number\":1.1,\"text\":\"a\"}"))
                    }
                }
                it("adds correct modifiers") {
                    var request = TestData.request(url: "path")
                    
                    encoder.encodeToHttpBody(input: input, to: &request)
                    
                    TestData.expect(modifiers: request.modifiers, toContains: Headers.ContentType.applicationJson, Headers.Charset.utf8)
                }
            }
            describe("encodeCustom - FormInputEncoding") {
                it("encodes input to httpBody in correct format") {
                    var request = TestData.request(url: "path")
                    
                    encoder.encodeCustom(input: input, to: &request, inputEncoding: FormInputEncoding())
                    
                    expect(request.httpBody).toNot(beNil())
                    if let data = request.httpBody, let text = String(data: data, encoding: .utf8) {
                        expect(text) == "number=1.1&text=a"
                    }
                }
                it("does nothing if type is .null") {
                    var request = TestData.request(url: "path")
                    
                    encoder.encodeCustom(input: .null, to: &request, inputEncoding: FormInputEncoding())
                    
                    expect(request.httpBody).to(beNil())
                }
                it("adds correct modifiers") {
                    var request = TestData.request(url: "path")
                    
                    encoder.encodeCustom(input: input, to: &request, inputEncoding: FormInputEncoding())
                    
                    TestData.expect(modifiers: request.modifiers, toContains: Headers.ContentType.applicationFormUrlencoded, Headers.Charset.utf8)
                }
            }
            describe("decode") {
                it("decodes JSON to SupportedType") {
                    let data = "{\"text\":\"a\",\"number\":1.1}".data(using: .utf8)!
                    let response = TestData.response(url: "path", result: .success(data))
                    
                    let decodedResponse = encoder.decode(response: response)
                    
                    expect(decodedResponse.result.value) == input
                }
            }
        }
    }
}
