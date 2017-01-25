//
//  BaseStatusCodeErrorHandler.swift
//  SwiftKit
//
//  Created by Filip Dolnik on 10.12.16.
//  Copyright © 2016 Brightify. All rights reserved.
//

import DataMapper

open class BaseStatusCodeErrorHandler: ErrorHandler {
    
    private let codes: Set<Int>
    
    public init(codes: [Int]) {
        self.codes = Set(codes)
    }
    
    public init(code: Int...) {
        self.codes = Set(code)
    }
    
    public init(range: CountableClosedRange<Int>) {
        self.codes = Set(range.map { $0 })
    }
    
    public final func canResolveError(response: Response<SupportedType>) -> Bool {
        return (response.rawResponse?.statusCode).map(codes.contains) ?? false
    }
    
    open func resolveError(response: Response<SupportedType>, callback: (Response<SupportedType>) -> Void) -> Void {
        fatalError("Not implemented.")
    }
}
