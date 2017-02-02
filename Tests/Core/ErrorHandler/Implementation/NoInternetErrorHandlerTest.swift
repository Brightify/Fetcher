//
//  NoInternetErrorHandlerTest.swift
//  Fetcher
//
//  Created by Filip Dolnik on 26.01.17.
//  Copyright © 2017 Brightify. All rights reserved.
//

import Quick
import Nimble
import Fetcher
import DataMapper

class NoInternetErrorHandlerTest: BaseStatusCodeErrorHandlerImplementationTest {
    
    override var handlerName: String {
        return "NoInternetErrorHandler"
    }
    
    override var codes: [Int] {
        return [599]
    }
    
    override func implementationSpec() {
        describe("resolveError") { 
            it("it calls retry with parameters from init") {
                let handler = NoInternetErrorHandler(maxRepetitions: 1, delay: .seconds(2))
                
                self.testRetry(handler: handler, maxRepetitions: 1, delay: 2)
            }
        }
    }
    
    override func createInstance() -> BaseStatusCodeErrorHandler {
        return NoInternetErrorHandler()
    }
}
