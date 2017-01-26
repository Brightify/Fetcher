//
//  BaseUrl.swift
//  Fetcher
//
//  Created by Filip Dolnik on 22.12.16.
//  Copyright © 2016 Brightify. All rights reserved.
//

import Foundation

public struct BaseUrl: RequestModifier {

    public static let Ignore = BaseUrl(baseUrl: nil, priority: .max)
    
    internal let baseUrl: String?
    internal let priority: RequestEnhancerPriority
    
    public init(baseUrl: String?, priority: RequestEnhancerPriority = .normal) {
        self.baseUrl = baseUrl
        self.priority = priority
    }
}

