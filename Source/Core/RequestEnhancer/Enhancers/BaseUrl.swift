//
//  BaseUrl.swift
//  Fetcher
//
//  Created by Filip Dolnik on 22.12.16.
//  Copyright © 2016 Brightify. All rights reserved.
//

import Foundation

public struct BaseUrl: RequestModifier {

    public static let Ignore = BaseUrl(url: nil, priority: .fetcher)

    internal let baseUrl: URL?
    internal let priority: RequestEnhancerPriority

    @available(*, deprecated, message: "Use `init(string:)`.")
    public init(baseUrl: String?, priority: RequestEnhancerPriority = .normal) {
        self.init(string: baseUrl, priority: priority)
    }

    public init(string: String?, priority: RequestEnhancerPriority = .normal) {
        self.baseUrl = URL(string: string ?? "")
        self.priority = priority
    }

    public init(url: URL?, priority: RequestEnhancerPriority = .normal) {
        self.baseUrl = url
        self.priority = priority
    }
}

