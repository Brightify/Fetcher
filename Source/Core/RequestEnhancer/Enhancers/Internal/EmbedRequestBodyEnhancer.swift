//
//  EmbedRequestBodyEnhancer.swift
//  Fetcher
//
//  Created by Tadeas Kriz on 05/03/2020.
//  Copyright © 2020 Brightify. All rights reserved.
//

import Foundation

internal struct EmbedRequestBodyModifier: RequestModifier {
    private let _embedInput: (inout Request) throws -> Void

    init(embedInput: @escaping (inout Request) throws -> Void) {
        self._embedInput = embedInput
    }

    func embedInput(in request: inout Request) throws {
        try _embedInput(&request)
    }
}

internal struct EmbedRequestBodyEnhancer: RequestEnhancer {

    internal static let priority: RequestEnhancerPriority = .bodyEmbedded

    internal func enhance(request: inout Request) throws {
        let inputs = request.modifiers.compactMap { $0 as? EmbedRequestBodyModifier }

        for input in inputs {
            try input.embedInput(in: &request)
        }
    }
}
