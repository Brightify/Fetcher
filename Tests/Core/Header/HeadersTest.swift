//
//  HeadersTest.swift
//  Fetcher
//
//  Created by Filip Dolnik on 27.01.17.
//  Copyright © 2017 Brightify. All rights reserved.
//

import Fetcher

class HeadersTest {
    
    func apiTest() {
        _ = Headers.Accept.applicationJson
        _ = Headers.Accept.textPlain
        _ = Headers.Accept(value: "a")
        
        _ = Headers.ContentType.applicationJson
        _ = Headers.ContentType.applicationFormUrlencoded
        _ = Headers.ContentType.textPlain
        _ = Headers.ContentType(value: "a")
        
        _ = Headers.Custom(name: "a", value: "b")
        
        _ = Headers.Charset.utf8
        _ = Headers.Charset(value: "a")
    }
}
