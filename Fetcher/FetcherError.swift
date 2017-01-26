//
//  FetcherError.swift
//  Fetcher
//
//  Created by Filip Dolnik on 09.12.16.
//  Copyright © 2016 Brightify. All rights reserved.
//

import DataMapper

public enum FetcherError: Error {
    case requestError(Error)
    case invalidStatusCode
    case nilValue
    case custom(Error)
    case unknown
}
