//
//  EndpointProviderTest.swift
//  Fetcher
//
//  Created by Filip Dolnik on 27.01.17.
//  Copyright © 2017 Brightify. All rights reserved.
//

import Quick
import Nimble
import Fetcher

class EndpointProviderTest: QuickSpec {
    
    override func spec() {
        describe("EndpointProvider") {
            describe("create") {
                it("creates Endpoint with implicit modifiers") {
                    let endpoint1: Endpoint<Int, String> = EndpointProviderStub.create("a", modifiers: [Headers.Accept.applicationJson])
                    let endpoint2: Endpoint<Int, String> = EndpointProviderStub.create("a", inputEncoding: StandardInputEncoding.httpBody,
                                                                                       modifiers: [Headers.Accept.applicationJson])
                    let endpoint3: Endpoint<Int, String> = EndpointProviderStub.create("a", modifiers: Headers.Accept.applicationJson, Headers.ContentType.applicationJson)
                    let endpoint4: Endpoint<Int, String> = EndpointProviderStub.create("a", inputEncoding: StandardInputEncoding.httpBody,
                                                                                       modifiers: Headers.Accept.applicationJson, Headers.ContentType.applicationJson)
                    
                    self.assert(endpoint: endpoint1, inputEncoding: StandardInputEncoding.queryString, headers: Headers.Charset.utf8, Headers.Accept.applicationJson)
                    self.assert(endpoint: endpoint2, inputEncoding: StandardInputEncoding.httpBody, headers: Headers.Charset.utf8, Headers.Accept.applicationJson)
                    self.assert(endpoint: endpoint3, inputEncoding: StandardInputEncoding.queryString, headers: Headers.Charset.utf8,
                           Headers.Accept.applicationJson, Headers.ContentType.applicationJson)
                    self.assert(endpoint: endpoint4, inputEncoding: StandardInputEncoding.httpBody, headers: Headers.Charset.utf8,
                           Headers.Accept.applicationJson, Headers.ContentType.applicationJson)
                }
            }
        }
    }
    
    private func assert<IN, OUT>(endpoint: Endpoint<IN, OUT>, inputEncoding: StandardInputEncoding, file: FileString = #file, line: UInt = #line, headers: Header...) {
        expect(endpoint.path, file: file, line: line) == "a"
        expect(endpoint.method, file: file, line: line) == HTTPMethod.get
        if let actualInputEncoding = endpoint.inputEncoding as? StandardInputEncoding {
            switch (actualInputEncoding, inputEncoding) {
            case (.queryString, .queryString):
                break
            case (.httpBody, .httpBody):
                break
            default:
                fail("expected \(inputEncoding) got \(actualInputEncoding)", file: file, line: line)
            }
        } else {
            Nimble.fail("expected \(inputEncoding) got \(endpoint.inputEncoding)", file: file, line: line)
        }
        TestData.expect(modifiers: endpoint.modifiers, file: file, line: line, toContains: headers)
    }
    
    private struct EndpointProviderStub: EndpointProvider {
        
        static var implicitModifiers: [RequestModifier] = [Headers.Charset.utf8]
    }
}
