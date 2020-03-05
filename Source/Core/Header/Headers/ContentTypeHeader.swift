//
//  ContentTypeHeader.swift
//  Fetcher
//
//  Created by Filip Dolnik on 04.12.16.
//  Copyright © 2016 Brightify. All rights reserved.
//

extension Headers {
    
    public struct ContentType: Header, Equatable {
        public static let name = "Content-Type"

        public let name: String = Headers.ContentType.name
        
        public let value: String
        
        public init(value: String) {
            self.value = value
        }
    }
}

extension Headers.ContentType {
    public static let applicationJson = Headers.ContentType(value: "application/json")
    public static let applicationFormUrlencoded = Headers.ContentType(value: "application/x-www-form-urlencoded")
    public static let textPlain = Headers.ContentType(value: "text/plain")
}
