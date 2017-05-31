//
//  BaseStatusCodeErrorHandlerTest.swift
//  Fetcher
//
//  Created by Filip Dolnik on 26.01.17.
//  Copyright © 2017 Brightify. All rights reserved.
//

import Quick
import Nimble
import Fetcher
import DataMapper

class BaseStatusCodeErrorHandlerTest {
    
    func apiTest() {
        _ = BaseStatusCodeErrorHandler(codes: [1, 2, 3])
        _ = BaseStatusCodeErrorHandler(codes: 1, 2, 3)
        _ = BaseStatusCodeErrorHandler(codes: 1...3)
        _ = BaseStatusCodeErrorHandler(code: 1)
    }
}

class BaseStatusCodeErrorHandlerImplementationTest: QuickSpec {
    
    var handlerName: String {
        return "BaseStatusCodeErrorHandler"
    }
    
    var codes: [Int] {
        return [1, 2, 3]
    }
    
    override func spec() {
        describe(handlerName) {
            describe("canResolveError") {
                let handler = self.createInstance()
                
                it("returns true if response has statusCode set in init") {
                    for code in self.codes {
                        let response: Response<SupportedType> = TestData.response(url: "a", statusCode: code)
                        
                        expect(handler.canResolveError(response: response)).to(beTrue())
                    }
                }
                it("returns false otherwise") {
                    let code = (self.codes.sorted().last ?? 0) + 1
                    
                    let response: Response<SupportedType> = TestData.response(url: "a", statusCode: code)
                        
                    expect(handler.canResolveError(response: response)).to(beFalse())
                }
            }
            self.implementationSpec()
        }
    }
    
    func implementationSpec() {
    }
    
    func createInstance() -> BaseStatusCodeErrorHandler {
        return BaseStatusCodeErrorHandler(codes: codes)
    }
    
    func testRetry(handler: ErrorHandler, maxRepetitions: Int, delay: Int, file: String = #file, line: UInt = #line) {
        var requestFromClosure: Request?
        var responseFromCallback: Response<SupportedType>?
        var actualMaxRepetitions: Int?
        var actualDelay: DispatchTimeInterval?
        
        let request = TestData.request(url: "a") {
            requestFromClosure = $0
            actualMaxRepetitions = $1
            actualDelay = $2
            $3()
        }
        let response: Response<SupportedType> = TestData.response(request: request)
        
        handler.resolveError(response: response, callback: { responseFromCallback = $0 })
        
        expect(requestFromClosure?.url, file: file, line: line) == request.url
        expect(responseFromCallback?.request.url, file: file, line: line) == response.request.url
        expect(actualMaxRepetitions, file: file, line: line) == maxRepetitions
        if let actualDelay = actualDelay, case .seconds(let value) = actualDelay {
            expect(value, file: file, line: line) == delay
        } else {
            fail("expected \(DispatchTimeInterval.seconds(2)) got \(delay)", file: file, line: line)
        }
    }
}
