//
//  MockRequestPerformer.swift
//  Fetcher
//
//  Created by Tadeas Kriz on 28/07/15.
//  Copyright (c) 2015 Tadeas Kriz. All rights reserved.
//

import Foundation
import Fetcher

public typealias MockEndpoint = (method: String, url: String, response: String, statusCode: Int)

public class MockRequestPerformer: RequestPerformer {
    
    private static let syncQueue = DispatchQueue(label: "MockRequestPerformer_syncQueue")
    
    public private(set) var endpoints: [MockEndpoint] = []
    
    public let dataEncoder: DataEncoder = AlamofireJsonDataEncoder()
    
    public init() {
    }
    
    public func register(endpoint: MockEndpoint) {
        MockRequestPerformer.syncQueue.sync {
            endpoints.append(endpoint)
        }
    }
    
    public func perform(request: Request, callback: @escaping (Response<Data>) -> Void) -> Cancellable {
        let endpoint = endpoints.first (where: { $0.method == request.httpMethod.rawValue && $0.url == request.url?.absoluteString })
        
        print(request.url as Any)
        let response: Response<Data>
        if let endpoint = endpoint {
            let responseData = endpoint.response.data(using: String.Encoding.utf8) ?? Data()
            response = Response(
                result: .success(responseData),
                rawResponse: nil,
                rawData: responseData,
                request: request)
        } else {
            response = Response(
                result: .failure(.invalidStatusCode),
                rawResponse: nil,
                rawData: nil,
                request: request)
        }
        
        callback(response)
        return Cancellable()
    }
}

