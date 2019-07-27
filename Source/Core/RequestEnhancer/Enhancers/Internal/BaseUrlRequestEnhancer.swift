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
        let modifier = request.modifiers.compactMap { $0 as? BaseUrl }.max { $0.priority.value < $1.priority.value }
        guard let url = request.url, let baseUrl = modifier?.baseUrl else { return }
        guard url.host == nil || url.scheme == nil else { return }
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else { return }

        if urlComponents.scheme == nil {
            urlComponents.scheme = baseUrl.scheme
        }

        if urlComponents.host == nil {
            urlComponents.host = baseUrl.host
        }

        if urlComponents.port == nil {
            urlComponents.port = baseUrl.port
        }

        urlComponents.path = baseUrl.appendingPathComponent(urlComponents.path.removingFirst(ifEqualTo: "/")).path
        
        guard let newUrl = urlComponents.url else { return }

        request.url = newUrl
    }
}

private extension String {
    func removingFirst(ifEqualTo firstCharacter: Character) -> String {
        guard hasPrefix(String(firstCharacter)) else { return self }

        return String(self[index(after: startIndex)...])
    }
}
