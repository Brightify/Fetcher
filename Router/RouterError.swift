//
//  RouterError.swift
//  SwiftKit
//
//  Created by Filip Dolnik on 09.12.16.
//  Copyright © 2016 Brightify. All rights reserved.
//

import DataMapper

// TODO Review + better names.
public enum RouterError: Error {
    case requestError(Error)
    case invalidStatusCode
    case nilValue
}
