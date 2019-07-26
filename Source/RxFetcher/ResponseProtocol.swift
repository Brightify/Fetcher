//
//  ResponseProtocol.swift
//  Fetcher
//
//  Created by Filip Dolnik on 10.12.16.
//  Copyright © 2016 Brightify. All rights reserved.
//

/// Protocol used as a generic constraint in extensions. It is not part of public API may change between mayor versions.
public protocol ResponseProtocol {
    associatedtype BodyType

    var result: FetcherResult<BodyType> { get }

    var request: Request  { get }
}

extension Response: ResponseProtocol {
}
