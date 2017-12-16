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
        if let url = request.url, var baseUrl = modifier?.baseUrl {

            URLComponents.
            var component = url.absoluteString
            if component[component.startIndex] == "/" {
                component = component.substring(from: component.index(after: component.startIndex))
            }
            
            if baseUrl[baseUrl.index(before: baseUrl.endIndex)] == "/" {
                baseUrl = baseUrl.substring(to: baseUrl.index(before: baseUrl.endIndex))
            }
            
            request.url = URL(string: baseUrl + "/" + component)
        }
    }
}
