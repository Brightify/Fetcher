//
//  RequestEnhancer.swift
//  Fetcher
//
//  Created by Tadeas Kriz on 27/07/15.
//  Copyright © 2015 Brightify. All rights reserved.
//

import DataMapper

public protocol RequestEnhancer {

    static var priority: RequestEnhancerPriority { get }
    
    var instancePriority: RequestEnhancerPriority? { get }
    
    func enhance(request: inout Request)
    
    func deenhance(response: inout Response<Data>)
}

extension RequestEnhancer {
    
    public static var priority: RequestEnhancerPriority {
        return .normal
    }
    
    public var instancePriority: RequestEnhancerPriority? {
        return nil
    }
    
    public func enhance(request: inout Request) {
    }
    
    public func deenhance(response: inout Response<Data>) {
    }
}
