//
//  BaseUrlRequestEnhancer.swift
//  Fetcher
//
//  Created by Filip Dolnik on 21.12.16.
//  Copyright © 2016 Brightify. All rights reserved.
//

import Foundation

internal struct BaseUrlRequestEnhancer: RequestEnhancer {
    
    internal static let priority: RequestEnhancerPriority = .fetcher
    
    internal func enhance(request: inout Request) {
        let modifier = request.modifiers.flatMap { $0 as? BaseUrl }.max { $0.priority.value < $1.priority.value }
        guard let url = request.url, let baseUrl = modifier?.baseUrl else { return }
        request.url = baseUrl.appendingPathComponent(url.absoluteString)
    }
}
