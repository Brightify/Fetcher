//
//  AlamofireRequestPerformer.swift
//  Fetcher
//
//  Created by Tadeas Kriz on 28/07/15.
//  Copyright © 2015 Brightify. All rights reserved.
//

import Alamofire
import Foundation

public struct AlamofireRequestPerformer: RequestPerformer {
    
    public let dataEncoder: DataEncoder
    
    public init(dataEncoder: DataEncoder = AlamofireJsonDataEncoder()) {
        self.dataEncoder = dataEncoder
    }
    
    public func perform(request: Request, callback: @escaping (Response<Data>) -> Cancellable) -> Cancellable {
        let parentCancellable = Cancellable()
        let alamofireRequest = Alamofire.request(request.urlRequest).responseData {
            parentCancellable.add(cancellable: self.handleResponse(data: $0, request: request, callback: callback))
        }
        parentCancellable.add(cancellable: Cancellable {
            alamofireRequest.cancel()
        })

        return parentCancellable
    }
    
    private func handleResponse(data: DataResponse<Data>, request: Request, callback: (Response<Data>) -> Cancellable) -> Cancellable {
        let result: FetcherResult<Data>
        // Alamofire uses different type of Result.
        switch data.result {
        case .success(let value):
            result = .success(value)
        case .failure(let error):
            result = .failure(FetcherError.requestError(error))
        }
        
        let response = Response<Data>(
            result: result,
            rawResponse: data.response,
            rawData: data.data,
            request: request)
        
        return callback(response)
    }
}
