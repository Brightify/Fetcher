//
//  SupportedType+Equatable.swift
//  FetcherTests
//
//  Created by Tadeáš Kříž on 10/24/17.
//  Copyright © 2017 Brightify. All rights reserved.
//

import DataMapper

extension SupportedType: Equatable {
}

public func ==(lhs: SupportedType, rhs: SupportedType) -> Bool {
    if let lhsDictionary = lhs.dictionary, let rhsDictionary = rhs.dictionary {
        return lhsDictionary == rhsDictionary
    } else {
        return String(describing: lhs.raw) == String(describing: rhs.raw)
    }
}
