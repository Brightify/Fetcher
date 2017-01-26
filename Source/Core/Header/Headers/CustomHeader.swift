//
//  CustomHeader.swift
//  Fetcher
//
//  Created by Filip Dolnik on 04.12.16.
//  Copyright © 2016 Brightify. All rights reserved.
//

extension Headers {
    
    public struct Custom: Header {
        
        public let name: String
        public let value: String
        
        public init(_ name: String, _ value: String) {
            self.name = name
            self.value = value
        }
    }
}
