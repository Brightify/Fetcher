//
//  Fetcher+RxFetcher.swift
//  Fetcher
//
//  Created by Filip Dolnik on 09.12.16.
//  Copyright © 2016 Brightify. All rights reserved.
//

extension Fetcher {
    
    public var rx: RxFetcher {
        return RxFetcher(fetcher: self)
    }
}
