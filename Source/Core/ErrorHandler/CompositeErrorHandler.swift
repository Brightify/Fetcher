//
//  CompositeErrorHandler.swift
//  Fetcher
//
//  Created by Filip Dolnik on 10.12.16.
//  Copyright © 2016 Brightify. All rights reserved.
//

import DataMapper

public struct CompositeErrorHandler: ErrorHandler {
    
    private let handlers: [ErrorHandler]
    
    public init(handlers: [ErrorHandler]) {
        self.handlers = handlers
    }
    
    public init(handlers: ErrorHandler...) {
        self.init(handlers: handlers)
    }
    
    public func canResolveError(response: Response<Data>) -> Bool {
        return handlers.reduce(false) { $0 || $1.canResolveError(response: response) }
    }
    
    public func resolveError(response: Response<Data>, callback: (Response<Data>) -> Void) {
        for handler in handlers {
            if handler.canResolveError(response: response) {
                handler.resolveError(response: response, callback: callback)
                return
            }
        }
    }
}
