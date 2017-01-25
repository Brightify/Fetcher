//
//  Router.swift
//  SwiftKit
//
//  Created by Filip Dolnik on 06.12.16.
//  Copyright © 2016 Brightify. All rights reserved.
//

import DataMapper

public final class Router {
    
    private static let syncQueue = DispatchQueue(label: "Router_syncQueue")
    
    public let requestPerformer: RequestPerformer
    public let objectMapper: ObjectMapper
    public let errorHandler: ErrorHandler
    
    public let callQueue: DispatchQueue
    public let callbackQueue: DispatchQueue
    
    public private(set) var requestEnhancers: [RequestEnhancer] = []
    public private(set) var requestModifiers: [RequestModifier] = []
    
    public init(requestPerformer: RequestPerformer, objectMapperPolymorph: Polymorph? = nil, errorHandler: ErrorHandler = NoErrorHandler(),
                callQueue: DispatchQueue = DispatchQueue.global(qos: .background), callbackQueue: DispatchQueue = DispatchQueue.main) {
        self.requestPerformer = requestPerformer
        objectMapper = ObjectMapper(polymorph: objectMapperPolymorph)
        self.errorHandler = errorHandler
        
        self.callQueue = callQueue
        self.callbackQueue = callbackQueue
        
        register(requestEnhancers: HeaderRequestEnhancer(), BaseUrlRequestEnhancer(), ResponseVerifierEnhancer())
        register(requestEnhancers: requestPerformer.implicitEnchancers)
    }
    
    public init(copy router: Router) {
        requestPerformer = router.requestPerformer
        objectMapper = router.objectMapper
        errorHandler = router.errorHandler
        
        callQueue = router.callQueue
        callbackQueue = router.callbackQueue
        
        requestEnhancers = router.requestEnhancers
        requestModifiers = router.requestModifiers
    }
    
    public func register(requestEnhancers: [RequestEnhancer]) {
        Router.syncQueue.sync {
            self.requestEnhancers.append(contentsOf: requestEnhancers)
            self.requestEnhancers.sort {
                let priority0 = $0.instancePriority ?? type(of: $0).priority
                let priority1 = $1.instancePriority ?? type(of: $1).priority
                return priority0.value > priority1.value
            }
        }
    }
    
    public func register(requestEnhancers: RequestEnhancer...) {
        register(requestEnhancers: requestEnhancers)
    }
    
    public func register(requestModifiers: [RequestModifier]) {
        Router.syncQueue.sync {
            self.requestModifiers.append(contentsOf: requestModifiers)
        }
    }
    
    public func register(requestModifiers: RequestModifier...) {
        register(requestModifiers: requestModifiers)
    }
}
