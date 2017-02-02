//
//  AcceptHeader.swift
//  Fetcher
//
//  Created by Filip Dolnik on 04.12.16.
//  Copyright © 2016 Brightify. All rights reserved.
//

extension Headers {
    
    public struct Accept: Header {
        
        public let name = "Accept"
        
        public let value: String
        
        public init(value: String) {
            self.value = value
        }
    }
}

extension Headers.Accept {
    
    public static let applicationJson = Headers.Accept(value: "application/json")
    public static let textPlain = Headers.Accept(value: "text/plain")
}
