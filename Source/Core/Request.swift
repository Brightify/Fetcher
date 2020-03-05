//
//  Request.swift
//  Fetcher
//
//  Created by Tadeas Kriz on 27/07/15.
//  Copyright © 2015 Brightify. All rights reserved.
//

import DataMapper
import Foundation

public struct Request {
    
    public var modifiers: [RequestModifier] = []
    
    public var urlRequest: URLRequest
    
    public var callback: (Response<Data>) -> Cancellable
    
    public var cancellable: Cancellable
    
    public var retried = 0
    
    public var retryClosure: (Request, Int, DispatchTimeInterval, () -> Void) -> Void
    
    public var url: URL? {
        get {
            return urlRequest.url
        }
        set {
            urlRequest.url = newValue
        }
    }
    
    public var cachePolicy: URLRequest.CachePolicy {
        get {
            return urlRequest.cachePolicy
        }
        set {
            urlRequest.cachePolicy = newValue
        }
    }
    
    public var timeoutInterval: TimeInterval {
        get {
            return urlRequest.timeoutInterval
        }
        set {
            urlRequest.timeoutInterval = newValue
        }
    }
    
    public var mainDocumentURL: URL? {
        get {
            return urlRequest.mainDocumentURL
        }
        set {
            urlRequest.mainDocumentURL = newValue
        }
    }
    
    public var networkServiceType: URLRequest.NetworkServiceType {
        get {
            return urlRequest.networkServiceType
        }
        set {
            urlRequest.networkServiceType = newValue
        }
    }
    
    public var allowsCellularAccess: Bool {
        get {
            return urlRequest.allowsCellularAccess
        }
        set {
            urlRequest.allowsCellularAccess = newValue
        }
    }
    
    public var httpMethod: HTTPMethod {
        get {
            return HTTPMethod(rawValue: urlRequest.httpMethod ?? "") ?? .unknown
        }
        set {
            urlRequest.httpMethod = newValue.rawValue
        }
    }

    public var contentType: Headers.ContentType? {
        get {
            return urlRequest.allHTTPHeaderFields.flatMap { $0[Headers.ContentType.name] }.map(Headers.ContentType.init(value:))
        }
        set {
            if let contentType = newValue {
                setHeader(contentType)
            } else {
                removeHeader(named: Headers.ContentType.name)
            }
        }
    }

    public var accepts: Headers.Accept? {
        get {
            return urlRequest.allHTTPHeaderFields.flatMap { $0[Headers.Accept.name] }.map(Headers.Accept.init(value:))
        }
        set {
            if let accepts = newValue {
                setHeader(accepts)
            } else {
                removeHeader(named: Headers.Accept.name)
            }
        }
    }
    
    public var allHTTPHeaderFields: [String: String]? {
        get {
            return urlRequest.allHTTPHeaderFields
        }
        set {
            urlRequest.allHTTPHeaderFields = newValue
        }
    }
    
    public var httpBody: Data? {
        get {
            return urlRequest.httpBody
        }
        set {
            urlRequest.httpBody = newValue
        }
    }
    
    public var httpBodyStream: InputStream? {
        get {
            return urlRequest.httpBodyStream
        }
        set {
            urlRequest.httpBodyStream = newValue
        }
    }
    
    public var httpShouldHandleCookies: Bool {
        get {
            return urlRequest.httpShouldHandleCookies
        }
        set {
            urlRequest.httpShouldHandleCookies = newValue
        }
    }
    
    public var httpShouldUsePipelining: Bool {
        get {
            return urlRequest.httpShouldUsePipelining
        }
        set {
            urlRequest.httpShouldUsePipelining = newValue
        }
    }
    
    public init(url: URL, retry: @escaping (Request, Int, DispatchTimeInterval, () -> Void) -> Void, callback: @escaping (Response<Data>) -> Cancellable, cancellable: Cancellable) {
        urlRequest = URLRequest(url: url)
        retryClosure = retry
        self.callback = callback
        self.cancellable = cancellable
    }
    
    public mutating func addHeader(_ header: Header) {
        urlRequest.addValue(header.value, forHTTPHeaderField: header.name)
    }
    
    public mutating func setHeader(_ header: Header) {
        urlRequest.setValue(header.value, forHTTPHeaderField: header.name)
    }

    public mutating func removeHeader(named name: String) {
        urlRequest.setValue(nil, forHTTPHeaderField: name)
    }
    
    public func retry(max: Int = Int.max, delay: DispatchTimeInterval = .seconds(0), failCallback: () -> Void = {}) {
        retryClosure(self, max, delay, failCallback)
    }
}
