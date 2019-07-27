//
//  StatusCodeResponseVerifier.swift
//  Fetcher
//
//  Created by Filip Dolnik on 04.12.16.
//  Copyright © 2016 Brightify. All rights reserved.
//

import DataMapper

public struct StatusCodeResponseVerifier: ResponseVerifier {
    
    private let codes: Set<Int>
    
    public init(codes: [Int]) {
        self.codes = Set(codes)
    }
    
    public init(codes: Int...) {
        self.init(codes: codes)
    }
    
    public init(codes: CountableClosedRange<Int>) {
        self.init(codes: codes.map { $0 })
    }
    
    public init(code: Int) {
        self.init(codes: [code])
    }
    
    public func verify(response: Response<Data>) -> FetcherError? {
        return (response.rawResponse?.statusCode).map(codes.contains) == false ? .invalidStatusCode : nil
    }
}
