//
//  Fetcher.swift
//  Fetcher
//
//  Created by Filip Dolnik on 06.12.16.
//  Copyright © 2016 Brightify. All rights reserved.
//

import DataMapper
import Foundation

public final class Fetcher {
    
    private let syncQueue = DispatchQueue(label: "Fetcher_syncQueue")
    
    public let requestPerformer: RequestPerformer
    public let objectMapper: ObjectMapper
    public let errorHandler: ErrorHandler
    
    public let callQueue: DispatchQueue
    public let callbackQueue: DispatchQueue
    
    public private(set) var requestEnhancers: [ChainingRequestEnhancer] = []
    public private(set) var requestModifiers: [RequestModifier] = []
    
    public init(requestPerformer: RequestPerformer, objectMapperPolymorph: Polymorph? = nil, errorHandler: ErrorHandler = NoErrorHandler(),
                callQueue: DispatchQueue = DispatchQueue.global(qos: .background), callbackQueue: DispatchQueue = DispatchQueue.main) {
        self.requestPerformer = requestPerformer
        objectMapper = ObjectMapper(polymorph: objectMapperPolymorph)
        self.errorHandler = errorHandler
        
        self.callQueue = callQueue
        self.callbackQueue = callbackQueue
        
        register(requestEnhancers: HeaderRequestEnhancer(), BaseUrlRequestEnhancer(), ResponseVerifierEnhancer(), URLQueryItemRequestEnhancer())
    }
    
    public init(copy fetcher: Fetcher) {
        requestPerformer = fetcher.requestPerformer
        objectMapper = fetcher.objectMapper
        errorHandler = fetcher.errorHandler
        
        callQueue = fetcher.callQueue
        callbackQueue = fetcher.callbackQueue
        
        requestEnhancers = fetcher.requestEnhancers
        requestModifiers = fetcher.requestModifiers
    }
    
    public func register(requestEnhancers: [ChainingRequestEnhancer]) {
        syncQueue.sync {
            self.requestEnhancers.append(contentsOf: requestEnhancers)
            self.requestEnhancers.sort {
                let priority0 = $0.instancePriority ?? type(of: $0).priority
                let priority1 = $1.instancePriority ?? type(of: $1).priority
                return priority0.value > priority1.value
            }
        }
    }
    
    public func register(requestEnhancers: ChainingRequestEnhancer...) {
        register(requestEnhancers: requestEnhancers)
    }
    
    public func register(requestModifiers: [RequestModifier]) {
        syncQueue.sync {
            self.requestModifiers.append(contentsOf: requestModifiers)
        }
    }
    
    public func register(requestModifiers: RequestModifier...) {
        register(requestModifiers: requestModifiers)
    }
}
