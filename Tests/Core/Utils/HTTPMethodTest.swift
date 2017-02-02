//
//  HTTPMethodTest.swift
//  Fetcher
//
//  Created by Filip Dolnik on 27.01.17.
//  Copyright © 2017 Brightify. All rights reserved.
//

import Quick
import Nimble
import Fetcher

class HTTPMethodTest: QuickSpec {
    
    func apiTest() {
        _ = HTTPMethod.connect
        _ = HTTPMethod.delete
        _ = HTTPMethod.get
        _ = HTTPMethod.head
        _ = HTTPMethod.options
        _ = HTTPMethod.patch
        _ = HTTPMethod.post
        _ = HTTPMethod.put
        _ = HTTPMethod.trace
        _ = HTTPMethod.unknown
    }
}
