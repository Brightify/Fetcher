//
//  ResponseVerifier.swift
//  Fetcher
//
//  Created by Tadeas Kriz on 14/07/15.
//  Copyright © 2015 Brightify. All rights reserved.
//

import DataMapper

public protocol ResponseVerifier: RequestModifier {

    func verify(response: Response<Data>) -> FetcherError?
}
