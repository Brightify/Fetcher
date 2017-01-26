//
//  CharsetHeader.swift
//  Fetcher
//
//  Created by Filip Dolnik on 24.01.17.
//  Copyright © 2017 Brightify. All rights reserved.
//

extension Headers {
    
    public struct Charset: Header {
        
        public let name = "charset"
        
        public let value: String
        
        public init(value: String) {
            self.value = value
        }
    }
}

extension Headers.Charset {
    
    public static let utf8 = Headers.Charset(value: "utf-8")
}
