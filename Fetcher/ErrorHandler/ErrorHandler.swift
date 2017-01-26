//
//  ErrorHandler.swift
//  Fetcher
//
//  Created by Filip Dolnik on 08.12.16.
//  Copyright © 2016 Brightify. All rights reserved.
//

import DataMapper

public protocol ErrorHandler {
    
    func canResolveError(response: Response<SupportedType>) -> Bool
    
    func resolveError(response: Response<SupportedType>, callback: (Response<SupportedType>) -> Void) -> Void
}
