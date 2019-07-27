//
//  NoErrorHandler.swift
//  Fetcher
//
//  Created by Filip Dolnik on 10.12.16.
//  Copyright © 2016 Brightify. All rights reserved.
//

import DataMapper

public struct NoErrorHandler: ErrorHandler {

    public init() {
    }
    
    public func canResolveError(response: Response<Data>) -> Bool {
        return false
    }
    
    public func resolveError(response: Response<Data>, callback: (Response<Data>) -> Void) -> Void {
    }
}
