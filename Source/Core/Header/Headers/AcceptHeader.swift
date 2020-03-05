//
//  AcceptHeader.swift
//  Fetcher
//
//  Created by Filip Dolnik on 04.12.16.
//  Copyright © 2016 Brightify. All rights reserved.
//

import Foundation

extension Headers {
    
    public struct Accept: Header {
        public static let name = "Accept"

        public let name: String = Accept.name
        
        public var value: String {
            return types.joined(separator: ", ")
        }
        public let types: [String]
        
        public init(value: String) {
            self.types = value.split(separator: ",").map { $0.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) }
        }

        public init(types: Headers.ContentType...) {
            self.types = types.map { $0.value }
        }

        public init(types: String...) {
            self.types = types
        }
    }
}

extension Headers.Accept {
    
    public static let applicationJson = Headers.Accept(value: "application/json")
    public static let textPlain = Headers.Accept(value: "text/plain")
}
