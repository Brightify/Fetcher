//
//  Response.swift
//  SwiftKit
//
//  Created by Tadeáš Kříž on 6/6/15.
//  Copyright © 2015 Brightify. All rights reserved.
//

import DataMapper
import HTTPStatusCodes
import Result

/**
    Response with generic type of output

    :param: T output type
*/
public struct Response<T> {
    
    public var result: RouterResult<T>
    
    /// Status code of the API request
    public var statusCode: HTTPStatusCode?
    
    /// Raw API response
    public var rawResponse: URLResponse?
    
    /// Raw data of the response
    public var rawData: Data?
    
    /// Request that was used to obtain this response
    public let request: Request
    
    public init(result: RouterResult<T>, statusCode: HTTPStatusCode?, rawResponse: URLResponse?, rawData: Data?, request: Request) {
        self.result = result
        self.statusCode = statusCode
        self.rawResponse = rawResponse
        self.rawData = rawData
        self.request = request
    }
    
    public func map<U>(_ transform: (T) -> U) -> Response<U> {
        return Response<U>(result: result.map(transform), statusCode: statusCode, rawResponse: rawResponse, rawData: rawData, request: request)
    }
    
    public func flatMap<U>(_ transform: (T) -> RouterResult<U>) -> Response<U> {
        return Response<U>(result: result.flatMap(transform), statusCode: statusCode, rawResponse: rawResponse, rawData: rawData, request: request)
    }
}
