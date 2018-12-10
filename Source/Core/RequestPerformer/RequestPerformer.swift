//
//  RequestPerformer.swift
//  Fetcher
//
//  Created by Tadeas Kriz on 28/07/15.
//  Copyright © 2015 Brightify. All rights reserved.
//

import DataMapper
import Foundation

public protocol RequestPerformer {
    
    var dataEncoder: DataEncoder { get }
    
    func perform(request: Request, callback: @escaping (Response<Data>) -> Void) -> Cancellable
}
