//
//  URLQueryItem.swift
//  Fetcher
//
//  Created by Matyáš Kříž on 15/12/2017.
//  Copyright © 2017 Brightify. All rights reserved.
//

import Foundation

public protocol URLQueryItemConvertible: RequestModifier {
    var urlQueryItem: URLQueryItem { get }
}

extension URLQueryItem: URLQueryItemConvertible {
    public var urlQueryItem: URLQueryItem {
        return self
    }
}
