//
//  RequestEnhancerPriority.swift
//  Fetcher
//
//  Created by Filip Dolnik on 04.12.16.
//  Copyright © 2016 Brightify. All rights reserved.
//

public enum RequestEnhancerPriority {
    
    case low
    case normal
    case high
    case fetcher
    case bodyEmbedded
    case max
    case custom(value: Int)
    
    public var value: Int {
        switch self {
        case .low:
            return -100
        case .normal:
            return 0
        case .bodyEmbedded:
            return 50
        case .high:
            return 100
        case .fetcher:
            return 200
        case .max:
            return 300
        case .custom(let value):
            return value
        }
    }
}

extension RequestEnhancerPriority {
    
    public var less: RequestEnhancerPriority {
        return .custom(value: value - 1)
    }
    
    public var more: RequestEnhancerPriority {
        return .custom(value: value + 1)
    }
}
