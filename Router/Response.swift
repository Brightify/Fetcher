//
//  Response.swift
//  SwiftKit
//
//  Created by Tadeáš Kříž on 6/6/15.
//  Copyright © 2015 Brightify. All rights reserved.
//

import DataMapper
import Result

/**
    Response with generic type of output

    :param: T output type
*/
public struct Response<T> {
    
    public var result: RouterResult<T>
    
    /// Raw API response
    public var rawResponse: HTTPURLResponse?
    
    /// Raw data of the response
    public var rawData: Data?
    
    /// Request that was used to obtain this response
    public let request: Request
    
    public init(result: RouterResult<T>, rawResponse: HTTPURLResponse?, rawData: Data?, request: Request) {
        self.result = result
        self.rawResponse = rawResponse
        self.rawData = rawData
        self.request = request
    }
    
    public func map<U>(_ transform: (T) -> U) -> Response<U> {
        return Response<U>(result: result.map(transform), rawResponse: rawResponse, rawData: rawData, request: request)
    }
    
    public func flatMap<U>(_ transform: (T) -> RouterResult<U>) -> Response<U> {
        return Response<U>(result: result.flatMap(transform), rawResponse: rawResponse, rawData: rawData, request: request)
    }
}

extension Response {
    
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
