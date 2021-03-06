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
    
    public func canResolveError(response: Response<SupportedType>) -> Bool {
        return false
    }
    
    public func resolveError(response: Response<SupportedType>, callback: (Response<SupportedType>) -> Void) -> Void {
    }
}
