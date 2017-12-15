//
//  BaseUrl.swift
//  Fetcher
//
//  Created by Filip Dolnik on 22.12.16.
//  Copyright © 2016 Brightify. All rights reserved.
//

import Foundation

public struct BaseUrl: RequestModifier {

    public static let Ignore = BaseUrl(baseUrl: nil as String?, priority: .fetcher)

    internal let baseUrl: String?
    internal let priority: RequestEnhancerPriority

    @available(*, deprecated, message: "Use `init(string:)`.")
    public init(baseUrl: String?, priority: RequestEnhancerPriority = .normal) {
        self.baseUrl = baseUrl
        self.priority = priority
    }

    public init(string: String?, priority: RequestEnhancerPriority = .normal) {
        self.baseUrl = string
        self.priority = priority
    }

    public init(url: URL?, priority: RequestEnhancerPriority = .normal) {
        self.baseUrl = url?.absoluteString
        self.priority = priority
    }
}

