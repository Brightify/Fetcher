//
//  MethodsTest.swift
//  Fetcher
//
//  Created by Filip Dolnik on 27.01.17.
//  Copyright © 2017 Brightify. All rights reserved.
//

import Fetcher

class MethodsTest {
    
    func apiTest() {
        _ = CONNECT<Any, Any>("", inputEncoding: StandardInputEncoding.httpBody, modifiers: [])
        _ = CONNECT<Any, Any>("", modifiers: [])
        _ = CONNECT<Any, Any>("", inputEncoding: StandardInputEncoding.httpBody, modifiers: Headers.ContentType.textPlain, Headers.Charset.utf8)
        _ = CONNECT<Any, Any>("", modifiers: Headers.ContentType.textPlain, Headers.Charset.utf8)
        
        _ = DELETE<Any, Any>("", inputEncoding: StandardInputEncoding.httpBody, modifiers: [])
        _ = DELETE<Any, Any>("", modifiers: [])
        _ = DELETE<Any, Any>("", inputEncoding: StandardInputEncoding.httpBody, modifiers: Headers.ContentType.textPlain, Headers.Charset.utf8)
        _ = DELETE<Any, Any>("", modifiers: Headers.ContentType.textPlain, Headers.Charset.utf8)
        
        _ = GET<Any, Any>("", inputEncoding: StandardInputEncoding.httpBody, modifiers: [])
        _ = GET<Any, Any>("", modifiers: [])
        _ = GET<Any, Any>("", inputEncoding: StandardInputEncoding.httpBody, modifiers: Headers.ContentType.textPlain, Headers.Charset.utf8)
        _ = GET<Any, Any>("", modifiers: Headers.ContentType.textPlain, Headers.Charset.utf8)
        
        _ = HEAD<Any, Any>("", inputEncoding: StandardInputEncoding.httpBody, modifiers: [])
        _ = HEAD<Any, Any>("", modifiers: [])
        _ = HEAD<Any, Any>("", inputEncoding: StandardInputEncoding.httpBody, modifiers: Headers.ContentType.textPlain, Headers.Charset.utf8)
        _ = HEAD<Any, Any>("", modifiers: Headers.ContentType.textPlain, Headers.Charset.utf8)
        
        _ = OPTIONS<Any, Any>("", inputEncoding: StandardInputEncoding.httpBody, modifiers: [])
        _ = OPTIONS<Any, Any>("", modifiers: [])
        _ = OPTIONS<Any, Any>("", inputEncoding: StandardInputEncoding.httpBody, modifiers: Headers.ContentType.textPlain, Headers.Charset.utf8)
        _ = OPTIONS<Any, Any>("", modifiers: Headers.ContentType.textPlain, Headers.Charset.utf8)
        
        _ = PATCH<Any, Any>("", inputEncoding: StandardInputEncoding.httpBody, modifiers: [])
        _ = PATCH<Any, Any>("", modifiers: [])
        _ = PATCH<Any, Any>("", inputEncoding: StandardInputEncoding.httpBody, modifiers: Headers.ContentType.textPlain, Headers.Charset.utf8)
        _ = PATCH<Any, Any>("", modifiers: Headers.ContentType.textPlain, Headers.Charset.utf8)
        
        _ = POST<Any, Any>("", inputEncoding: StandardInputEncoding.httpBody, modifiers: [])
        _ = POST<Any, Any>("", modifiers: [])
        _ = POST<Any, Any>("", inputEncoding: StandardInputEncoding.httpBody, modifiers: Headers.ContentType.textPlain, Headers.Charset.utf8)
        _ = POST<Any, Any>("", modifiers: Headers.ContentType.textPlain, Headers.Charset.utf8)
        
        _ = PUT<Any, Any>("", inputEncoding: StandardInputEncoding.httpBody, modifiers: [])
        _ = PUT<Any, Any>("", modifiers: [])
        _ = PUT<Any, Any>("", inputEncoding: StandardInputEncoding.httpBody, modifiers: Headers.ContentType.textPlain, Headers.Charset.utf8)
        _ = PUT<Any, Any>("", modifiers: Headers.ContentType.textPlain, Headers.Charset.utf8)
        
        _ = TRACE<Any, Any>("", inputEncoding: StandardInputEncoding.httpBody, modifiers: [])
        _ = TRACE<Any, Any>("", modifiers: [])
        _ = TRACE<Any, Any>("", inputEncoding: StandardInputEncoding.httpBody, modifiers: Headers.ContentType.textPlain, Headers.Charset.utf8)
        _ = TRACE<Any, Any>("", modifiers: Headers.ContentType.textPlain, Headers.Charset.utf8)
    }
}
