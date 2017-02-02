//
//  Header.swift
//  Fetcher
//
//  Created by Filip Dolnik on 04.12.16.
//  Copyright © 2016 Brightify. All rights reserved.
//

import Foundation

public protocol Header: RequestModifier {
    
    var name: String { get }
    var value: String { get }
}
