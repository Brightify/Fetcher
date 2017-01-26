//
//  RequestPerformer.swift
//  Fetcher
//
//  Created by Tadeas Kriz on 28/07/15.
//  Copyright © 2015 Brightify. All rights reserved.
//

import DataMapper

public protocol RequestPerformer {
    
    var implicitEnchancers: [RequestEnhancer] { get }
    
    var implicitModifiers: [RequestModifier] { get }
    
    var dataEncoder: DataEncoder { get }
    
    func perform(request: Request, callback: @escaping (Response<Data>) -> Void) -> Cancellable
}

extension RequestPerformer {
    
    public var implicitEnchancers: [RequestEnhancer] {
        return []
    }
    
    public var implicitModifiers: [RequestModifier] {
        return []
    }
}
