//
//  Response.swift
//  Fetcher
//
//  Created by Tadeáš Kříž on 6/6/15.
//  Copyright © 2015 Brightify. All rights reserved.
//

import DataMapper
import Foundation

public struct Response<T> {
    
    public var result: FetcherResult<T>
    public var rawResponse: HTTPURLResponse?
    public var rawData: Data?
    public var request: Request
    public var contentType: Headers.ContentType?
    
    public init(result: FetcherResult<T>, rawResponse: HTTPURLResponse?, rawData: Data?, request: Request) {
        self.result = result
        self.rawResponse = rawResponse
        self.rawData = rawData
        self.request = request

        contentType = rawResponse.flatMap { $0.allHeaderFields[Headers.ContentType.name] as? String }.map(Headers.ContentType.init(value:))
    }
}

extension Response {
    
    public func map<U>(_ transform: (T) -> U) -> Response<U> {
        return Response<U>(result: result.map(transform), rawResponse: rawResponse, rawData: rawData, request: request)
    }
    
    public func flatMap<U>(_ transform: (T) -> FetcherResult<U>) -> Response<U> {
        return Response<U>(result: result.flatMap(transform), rawResponse: rawResponse, rawData: rawData, request: request)
    }
    
    public var rawString: String? {
        guard let response = rawResponse, let data = rawData else {
            return nil
        }
        
        let encoding: String.Encoding
        if let encodingName = response.textEncodingName {
            // Swift cannot convert String directly to CFString.
            let cfEncoding = CFStringConvertIANACharSetNameToEncoding(encodingName as NSString as CFString)
            let rawValue = CFStringConvertEncodingToNSStringEncoding(cfEncoding)
            encoding = String.Encoding(rawValue: rawValue)
        } else {
            encoding = .isoLatin1
        }
        
        return String(data: data, encoding: encoding)
    }
}
