//
//  Router+Run.swift
//  SwiftKit
//
//  Created by Filip Dolnik on 24.01.17.
//  Copyright © 2017 Brightify. All rights reserved.
//

import DataMapper

extension Router {
    
    // Overloads have simmilar signiture to allow easier request generation.
    internal func run(endpoint: Endpoint<Data, Data>, inputProvider: @escaping () -> (Data),
                      outputProvider: @escaping (Data) -> Data, callback: @escaping (Response<Data>) -> Void) -> Cancellable {
        let cancellable = Cancellable()
        callQueue.async {
            let wrappedCallback = self.wrap(callback: callback)
            var request = self.prepareRequest(endpoint: endpoint, callback: wrappedCallback)
            request.httpBody = inputProvider()
            self.requestEnhancers.forEach { $0.enhance(request: &request) }
            self.perform(request: request)
            cancellable.add(cancellable: request.cancellable)
        }
        return cancellable
    }
    
    internal func run<IN>(endpoint: Endpoint<IN, Data>, inputProvider: @escaping () -> (SupportedType),
                      outputProvider: @escaping (Data) -> Data, callback: @escaping (Response<Data>) -> Void) -> Cancellable {
        let cancellable = Cancellable()
        callQueue.async {
            let wrappedCallback = self.wrap(callback: callback)
            var request = self.prepareRequest(endpoint: endpoint, callback: wrappedCallback)
            self.encodeInputData(to: &request, inputEncoding: endpoint.inputEncoding, input: inputProvider())
            self.requestEnhancers.forEach { $0.enhance(request: &request) }
            self.perform(request: request)
            cancellable.add(cancellable: request.cancellable)
        }
        return cancellable
    }
    
    internal func run<OUT>(endpoint: Endpoint<Data, OUT>, inputProvider: @escaping () -> (Data),
                      outputProvider: @escaping (SupportedType) -> OUT?, callback: @escaping (Response<OUT>) -> Void) -> Cancellable {
        let cancellable = Cancellable()
        callQueue.async {
            let wrappedCallback = self.wrap(callback: callback, with: outputProvider)
            var request = self.prepareRequest(endpoint: endpoint, callback: wrappedCallback)
            request.httpBody = inputProvider()
            self.requestEnhancers.forEach { $0.enhance(request: &request) }
            self.perform(request: request)
            cancellable.add(cancellable: request.cancellable)
        }
        return cancellable
    }
    
    internal func run<IN, OUT>(endpoint: Endpoint<IN, OUT>, inputProvider: @escaping () -> (SupportedType),
                      outputProvider: @escaping (SupportedType) -> OUT?, callback: @escaping (Response<OUT>) -> Void) -> Cancellable {
        let cancellable = Cancellable()
        callQueue.async {
            let wrappedCallback = self.wrap(callback: callback, with: outputProvider)
            var request = self.prepareRequest(endpoint: endpoint, callback: wrappedCallback)
            self.encodeInputData(to: &request, inputEncoding: endpoint.inputEncoding, input: inputProvider())
            self.requestEnhancers.forEach { $0.enhance(request: &request) }
            self.perform(request: request)
            cancellable.add(cancellable: request.cancellable)
        }
        return cancellable
    }
}

extension Router {
    
    fileprivate func prepareRequest<IN, OUT>(endpoint: Endpoint<IN, OUT>, callback: @escaping (Response<Data>) -> Void) -> Request {
        guard let url = URL(string: endpoint.path) else {
            fatalError("Path \(endpoint.path) from endpoint doesn`t resolve to valid url.")
        }
        
        var request = Request(url: url, retry: retry, callback: callback, cancellable: Cancellable())
        request.httpMethod = endpoint.method
        request.modifiers = [endpoint.modifiers, requestPerformer.implicitModifiers, requestModifiers].flatMap { $0 }
        
        return request
    }
    
    fileprivate func encodeInputData(to request: inout Request, inputEncoding: InputEncoding, input: SupportedType) {
        switch inputEncoding {
        case let inputEncoding as StandardInputEncoding:
            switch inputEncoding {
            case .httpBody:
                requestPerformer.dataEncoder.encodeToHttpBody(input: input, to: &request)
            case .queryString:
                requestPerformer.dataEncoder.encodeToQueryString(input: input, to: &request)
            }
        case let inputEncoding as InputEncodingWithEncoder:
            inputEncoding.encode(input: input, to: &request)
        default:
            requestPerformer.dataEncoder.encodeCustom(input: input, to: &request, inputEncoding: inputEncoding)
        }
    }
    
    fileprivate func wrap(callback: @escaping (Response<Data>) -> Void) -> (Response<Data>) -> Void {
        return wrap(callback: callback) { response in
            return response.flatMap { _ in
                if let data = response.rawData {
                    return .success(data)
                } else if let error = response.result.error {
                    return .failure(error)
                } else {
                    return .failure(.unknown)
                }
            }
        }
    }
    
    fileprivate func wrap<OUT>(callback: @escaping (Response<OUT>) -> Void,
                          with outputProvider: @escaping (SupportedType) -> OUT?) -> (Response<Data>) -> Void {
        return wrap(callback: callback) { response in
            return response.flatMap { outputProvider($0).map { .success($0) } ?? .failure(.nilValue) }
        }
    }
    
    fileprivate func perform(request: Request) {
        request.cancellable.add(cancellable: self.requestPerformer.perform(request: request, callback: request.callback))
    }
    
    private func wrap<OUT>(callback: @escaping (Response<OUT>) -> Void,
                      mapResponse: @escaping (Response<SupportedType>) -> Response<OUT>) -> (Response<Data>) -> Void {
        return { response in
            self.callQueue.async {
                var decodedResponse = self.requestPerformer.dataEncoder.decode(response: response)
                self.requestEnhancers.forEach { $0.deenhance(response: &decodedResponse) }
                let mappedResponse = mapResponse(decodedResponse)
                
                // Used if mappedResponse contains error. So this is only cast of generic type.
                // Allows ErrorHandler to respond to .nilValue.
                let mappedResponseForErrorHandler = mappedResponse.map { _ in SupportedType.null }
                if case .failure = mappedResponse.result, self.errorHandler.canResolveError(response: mappedResponseForErrorHandler) {
                    self.errorHandler.resolveError(response: mappedResponseForErrorHandler) {
                        // ErrorHandler can change response, so its neccesary to remap it again.
                        let mappedResponse = mapResponse($0)
                        self.callbackQueue.async { callback(mappedResponse) }
                    }
                } else {
                    self.callbackQueue.async { callback(mappedResponse) }
                }
            }
        }
    }
    
    private func retry(request: Request, max: Int, delay: DispatchTimeInterval, failCallback: () -> Void) {
        guard request.retried < max else {
            return failCallback()
        }
        
        callQueue.asyncAfter(deadline: DispatchTime.now() + delay) {
            var requestCopy = request
            requestCopy.retried += 1
            self.perform(request: requestCopy)
        }
    }
}
