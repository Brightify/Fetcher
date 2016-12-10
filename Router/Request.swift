//
//  Request.swift
//  SwiftKit
//
//  Created by Tadeas Kriz on 27/07/15.
//  Copyright © 2015 Brightify. All rights reserved.
//

import DataMapper

// TODO Delegate rest?
public struct Request {
    
    public var modifiers: [RequestModifier] = []
    
    public private(set) var urlRequest: URLRequest
    
    public var retried = 0
    
    public let callback: (Response<SupportedType>) -> ()
    
    public let cancellable: Cancellable
    
    private let retryClosure: (Request, Int, DispatchTime, () -> ()) -> ()
    
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
            return SwiftKit.HTTPMethod(rawValue: urlRequest.httpMethod ?? "") ?? .unknown
        }
        set {
            urlRequest.httpMethod = newValue.rawValue
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
    
    public var httpBodyStrem: InputStream? {
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
    
    public init(url: URL, retry: @escaping (Request, Int, DispatchTime, () -> ()) -> (), callback: @escaping (Response<SupportedType>) -> (), cancellable: Cancellable) {
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
    
    public func retry(max: Int = Int.max, delay: DispatchTime = DispatchTime.now(), failCallback: () -> () = {}) {
        retryClosure(self, max, delay, failCallback)
    }
}