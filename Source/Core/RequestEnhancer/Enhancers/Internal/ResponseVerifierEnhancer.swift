//
//  ResponseVerifierEnhancer.swift
//  Fetcher
//
//  Created by Filip Dolnik on 25.01.17.
//  Copyright © 2017 Brightify. All rights reserved.
//

import DataMapper

internal struct ResponseVerifierEnhancer: RequestEnhancer {
    
    internal static let priority: RequestEnhancerPriority = .fetcher
    
    internal func deenhance(response: inout Response<SupportedType>) {
        if let error = (response.request.modifiers.flatMap { $0 as? ResponseVerifier }.flatMap { $0.verify(response: response) }.first) {
            response = response.flatMap { _ in .failure(error) }
        }
    }
}
