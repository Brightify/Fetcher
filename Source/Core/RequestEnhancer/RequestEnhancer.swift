//
//  RequestEnhancer.swift
//  Fetcher
//
//  Created by Tadeas Kriz on 27/07/15.
//  Copyright © 2015 Brightify. All rights reserved.
//

import DataMapper

public struct RequestEnhancementError: Error {
    public let request: Request
    public let error: Error

    public init(request: Request, error: Error) {
        self.request = request
        self.error = error
    }

    public var localizedDescription: String {
        return error.localizedDescription + " @ \(request)"
    }
}

public protocol ChainingRequestEnhancer {

    static var priority: RequestEnhancerPriority { get }
    
    var instancePriority: RequestEnhancerPriority? { get }
    
    func enhance(request: Request, next: @escaping (Result<Request, Error>) -> Void) -> Cancellable
    
    func deenhance(response: Response<Data>, next: @escaping (Response<Data>) -> Void) -> Cancellable
}

extension ChainingRequestEnhancer {
    
    public static var priority: RequestEnhancerPriority {
        return .normal
    }
    
    public var instancePriority: RequestEnhancerPriority? {
        return nil
    }
    
    public func enhance(request: Request, next: @escaping (Result<Request, Error>) -> Void) -> Cancellable {
        next(.success(request))
        return Cancellable()
    }
    
    public func deenhance(response: Response<Data>, next: @escaping (Response<Data>) -> Void) -> Cancellable {
        next(response)
        return Cancellable()
    }
}

public protocol RequestEnhancer: ChainingRequestEnhancer {
    func enhance(request: inout Request) throws

    func deenhance(response: inout Response<Data>)
}

extension RequestEnhancer {

    public func enhance(request: inout Request) throws {
    }

    public func deenhance(response: inout Response<Data>) {
    }

    public func enhance(request: Request, next: @escaping (Result<Request, Error>) -> Void) -> Cancellable {
        do {
            var mutableRequest = request
            try enhance(request: &mutableRequest)
            next(.success(mutableRequest))
        } catch {
            next(.failure(error))
        }
        return Cancellable()
    }

    public func deenhance(response: Response<Data>, next: @escaping (Response<Data>) -> Void) -> Cancellable {
        var mutableResponse = response
        deenhance(response: &mutableResponse)
        next(mutableResponse)
        return Cancellable()
    }
}
