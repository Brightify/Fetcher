//
//  URL+withQueries.swift
//  Fetcher
//
//  Created by Matyáš Kříž on 15/12/2017.
//  Copyright © 2017 Brightify. All rights reserved.
//

import Foundation

public extension URL {
    func withQueries(_ queries: [URLQueryItem]) -> URL? {
        guard var urlComponents = URLComponents(url: self, resolvingAgainstBaseURL: false) else { return nil }
        if let queryItems = urlComponents.queryItems, !queryItems.isEmpty {
            urlComponents.queryItems?.append(contentsOf: queries)
        } else {
            urlComponents.queryItems = queries
        }

        return urlComponents.url
    }

    func withQueries(_ queries: URLQueryItem...) -> URL? {
        return self.withQueries(queries)
    }

    mutating func addQueries(_ queries: URLQueryItem...) {
        guard let modifiedSelf = self.withQueries(queries) else { return }
        self = modifiedSelf
    }
}
