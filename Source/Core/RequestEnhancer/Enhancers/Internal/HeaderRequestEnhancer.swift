//
//  HeaderRequestEnhancer.swift
//  Fetcher
//
//  Created by Filip Dolnik on 04.12.16.
//  Copyright © 2016 Brightify. All rights reserved.
//

internal struct HeaderRequestEnhancer: RequestEnhancer {
    
    internal static let priority: RequestEnhancerPriority = .fetcher
    
    internal func enhance(request: inout Request) {
        request.modifiers.compactMap { $0 as? Header }.forEach { request.setHeader($0) }
    }
}
