//
//  URLQueryItemRequestEnhancer.swift
//  Fetcher
//
//  Created by Matyáš Kříž on 15/12/2017.
//  Copyright © 2017 Brightify. All rights reserved.
//

import Foundation

internal struct URLQueryItemRequestEnhancer: RequestEnhancer {

    internal static let priority: RequestEnhancerPriority = .fetcher

    internal func enhance(request: inout Request) {
        let queryItems = request.modifiers.flatMap { $0 as? URLQueryItemConvertible }.map { $0.urlQueryItem }
        let queries = queryItems.map { URLQueryItem(name: $0.name, value: $0.value) }

        guard let url = request.url, let enhancedUrl = url.withQueries(queries), !queries.isEmpty else { return }

        request.url = enhancedUrl
    }
}
