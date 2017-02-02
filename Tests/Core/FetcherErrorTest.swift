//
//  FetcherErrorTest.swift
//  Fetcher
//
//  Created by Filip Dolnik on 27.01.17.
//  Copyright © 2017 Brightify. All rights reserved.
//

import Fetcher

class FetcherErrorTest {
    
    func apiTest() {
        _ = FetcherError.requestError(FetcherError.unknown)
        _ = FetcherError.invalidStatusCode
        _ = FetcherError.nilValue
        _ = FetcherError.custom(FetcherError.unknown)
        _ = FetcherError.unknown
    }
}
