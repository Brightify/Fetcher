//
//  shim-Collection+compactMap.swift
//  Fetcher
//
//  Created by Tadeas Kriz on 6/14/18.
//  Copyright © 2018 Brightify. All rights reserved.
//

import Foundation

#if swift(>=4.1)
#else
internal extension Collection {
    func compactMap<ElementOfResult>(_ transform: (Element) throws -> ElementOfResult?) rethrows -> [ElementOfResult] {
        return try flatMap(transform)
    }
}
#endif
