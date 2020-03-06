//
//  Fetcher+Run.swift
//  Fetcher
//
//  Created by Filip Dolnik on 24.01.17.
//  Copyright © 2017 Brightify. All rights reserved.
//

import DataMapper
import Foundation

extension Fetcher {
    
    // Overloads have similar signiture to allow easier request generation.
    internal func run(
        endpoint: Endpoint<Data, Data>,
        inputProvider: @escaping (Request) throws -> (Data),
        outputProvider: @escaping (Response<Data>, Data) -> Data,
        callback: @escaping (Response<Data>) -> Void
    ) -> Cancellable {
        let cancellable = Cancellable()
        callQueue.async {
            let wrappedCallback = self.wrap(callback: callback)
            let request = self.prepareRequest(endpoint: endpoint, callback: wrappedCallback, embedInput: { request in
                request.httpBody = try inputProvider(request)
            })
            self.perform(request: request)
            cancellable.add(cancellable: request.cancellable)
        }
        return cancellable
    }
    
    internal func run<IN>(
        endpoint: Endpoint<IN, Data>,
        inputProvider: @escaping (Request) throws -> (SupportedType),
        outputProvider: @escaping (Response<Data>, Data) -> Data,
        callback: @escaping (Response<Data>) -> Void
    ) -> Cancellable {
        let cancellable = Cancellable()
        callQueue.async {
            let wrappedCallback = self.wrap(callback: callback)
            let request = self.prepareRequest(endpoint: endpoint, callback: wrappedCallback, embedInput: { request in
                try self.encodeInputData(to: &request, inputEncoding: endpoint.inputEncoding, input: inputProvider(request))
            })
            self.perform(request: request)
            cancellable.add(cancellable: request.cancellable)
        }
        return cancellable
    }

    internal func run<IN>(
        endpoint: Endpoint<IN, Data>,
        inputProvider: @escaping (Request) throws -> (Data),
        outputProvider: @escaping (Response<Data>, Data) -> Data,
        callback: @escaping (Response<Data>) -> Void
        ) -> Cancellable {
        let cancellable = Cancellable()
        callQueue.async {
            let wrappedCallback = self.wrap(callback: callback)
            let request = self.prepareRequest(endpoint: endpoint, callback: wrappedCallback, embedInput: { request in
                request.httpBody = try inputProvider(request)
            })
            self.perform(request: request)
            cancellable.add(cancellable: request.cancellable)
        }
        return cancellable
    }
    
    internal func run<OUT>(
        endpoint: Endpoint<Data, OUT>,
        inputProvider: @escaping (Request) throws -> (Data),
        outputProvider: @escaping (Response<SupportedType>, SupportedType) throws -> OUT,
        callback: @escaping (Response<OUT>) -> Void
    ) -> Cancellable {
        let cancellable = Cancellable()
        callQueue.async {
            let wrappedCallback = self.wrap(callback: callback, with: outputProvider)
            let request = self.prepareRequest(endpoint: endpoint, callback: wrappedCallback, embedInput: { request in
                request.httpBody = try inputProvider(request)
            })
            self.perform(request: request)
            cancellable.add(cancellable: request.cancellable)
        }
        return cancellable
    }

    internal func run<IN, OUT>(
        endpoint: Endpoint<IN, OUT>,
        inputProvider: @escaping (Request) throws -> (SupportedType),
        outputProvider: @escaping (Response<SupportedType>, SupportedType) throws -> OUT,
        callback: @escaping (Response<OUT>) -> Void
    ) -> Cancellable {
        let cancellable = Cancellable()
        callQueue.async {
            let wrappedCallback = self.wrap(callback: callback, with: outputProvider)
            let request = self.prepareRequest(endpoint: endpoint, callback: wrappedCallback, embedInput: { request in
                try self.encodeInputData(to: &request, inputEncoding: endpoint.inputEncoding, input: inputProvider(request))
            })
            self.perform(request: request)
            cancellable.add(cancellable: request.cancellable)
        }
        return cancellable
    }

    internal func run<IN, OUT>(
        endpoint: Endpoint<IN, OUT>,
        inputProvider: @escaping (Request) throws -> (Data),
        outputProvider: @escaping (Response<SupportedType>, SupportedType) throws -> OUT,
        callback: @escaping (Response<OUT>) -> Void
        ) -> Cancellable {
        let cancellable = Cancellable()
        callQueue.async {
            let wrappedCallback = self.wrap(callback: callback, with: outputProvider)
            let request = self.prepareRequest(endpoint: endpoint, callback: wrappedCallback, embedInput: { request in
                request.httpBody = try inputProvider(request)
            })
            self.perform(request: request)
            cancellable.add(cancellable: request.cancellable)
        }
        return cancellable
    }

    internal func run<IN, OUT>(
        endpoint: Endpoint<IN, OUT>,
        inputProvider: @escaping (Request) throws -> (Data),
        outputProvider: @escaping (Response<Data>, Data) throws -> OUT,
        callback: @escaping (Response<OUT>) -> Void
    ) -> Cancellable {
        let cancellable = Cancellable()
        callQueue.async {
            let wrappedCallback = self.wrap(callback: callback, with: outputProvider)
            let request = self.prepareRequest(endpoint: endpoint, callback: wrappedCallback, embedInput: { request in
                request.httpBody = try inputProvider(request)
            })
            self.perform(request: request)
            cancellable.add(cancellable: request.cancellable)
        }
        return cancellable
    }

    internal func run<IN, OUT>(
        endpoint: Endpoint<IN, OUT>,
        inputProvider: @escaping (Request) throws -> (SupportedType),
        outputProvider: @escaping (Response<Data>, Data) throws -> OUT,
        callback: @escaping (Response<OUT>) -> Void
        ) -> Cancellable {
        let cancellable = Cancellable()
        callQueue.async {
            let wrappedCallback = self.wrap(callback: callback, with: outputProvider)
            let request = self.prepareRequest(endpoint: endpoint, callback: wrappedCallback, embedInput: { request in
                try self.encodeInputData(to: &request, inputEncoding: endpoint.inputEncoding, input: inputProvider(request))
            })
            self.perform(request: request)
            cancellable.add(cancellable: request.cancellable)
        }
        return cancellable
    }
}

extension Fetcher {
    
    fileprivate func prepareRequest<IN, OUT>(
        endpoint: Endpoint<IN, OUT>,
        callback: @escaping (Response<Data>) -> Cancellable,
        embedInput: ((inout Request) throws -> Void)?
    ) -> Request {
        guard let url = URL(string: endpoint.path) else {
            fatalError("Path \(endpoint.path) from endpoint doesn`t resolve to valid url.")
        }
        
        var request = Request(url: url, retry: retry, callback: callback, cancellable: Cancellable())
        request.httpMethod = endpoint.method
        request.modifiers = [
            endpoint.modifiers,
            requestModifiers
        ].flatMap { $0 }
        if let embedInput = embedInput {
            request.modifiers.append(EmbedRequestBodyModifier(embedInput: embedInput))
        }

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
    
    fileprivate func wrap(callback: @escaping (Response<Data>) -> Void) -> (Response<Data>) -> Cancellable {
        return wrapData(callback: callback) { response in
            return response.flatMap { _ in
                if let data = response.rawData {
                    return .success(data)
                } else if case .failure(let error) = response.result {
                    return .failure(error)
                } else {
                    return .failure(FetcherError.unknown)
                }
            }
        }
    }
    
    fileprivate func wrap<OUT>(
        callback: @escaping (Response<OUT>) -> Void,
        with outputProvider: @escaping (Response<SupportedType>, SupportedType) throws -> OUT
    ) -> (Response<Data>) -> Cancellable {
        return wrapSupportedType(callback: callback) { response in
            return response.flatMap {
                do {
                    return .success(try outputProvider(response, $0))
                } catch {
                    return .failure(FetcherError.custom(error))
                }
            }
        }
    }

    fileprivate func wrap<OUT>(callback: @escaping (Response<OUT>) -> Void,
                               with outputProvider: @escaping (Response<Data>, Data) throws -> OUT) -> (Response<Data>) -> Cancellable {
        return wrapData(callback: callback) { response in
            return response.flatMap {
                do {
                    return .success(try outputProvider(response, $0))
                } catch {
                    return .failure(FetcherError.custom(error))
                }
            }
        }
    }

    fileprivate func rollback(request: Request, error: Error) -> Cancellable {
        return request.callback(Response<Data>(result: .failure(error), rawResponse: nil, rawData: nil, request: request))
    }
    
    fileprivate func perform(request: Request) {
        request.cancellable.add(cancellable:
            self.chain(request: request, enhancers: requestEnhancers) { result in
                switch result {
                case .success(let finalRequest):
                    return self.requestPerformer.perform(request: finalRequest, callback: request.callback)
                case .failure(let error):
                    return self.rollback(request: request, error: error)
                }
            })
    }

    private func wrapSupportedType<OUT>(
        callback: @escaping (Response<OUT>) -> Void,
        mapResponse: @escaping (Response<SupportedType>) -> Response<OUT>
    ) -> (Response<Data>) -> Cancellable {
        return wrapData(callback: callback) {
            mapResponse(self.requestPerformer.dataEncoder.decode(response: $0))
        }
    }
    
    private func wrapData<OUT>(
        callback: @escaping (Response<OUT>) -> Void,
        mapResponse: @escaping (Response<Data>) -> Response<OUT>
    ) -> (Response<Data>) -> Cancellable {
        return { response in
            let parentCancellable = Cancellable()
            self.callQueue.async {
                let cancellable = self.chain(response: response, enhancers: self.requestEnhancers) { newResponse in
                    let mappedResponse = mapResponse(newResponse)

                    // Used if mappedResponse contains error. So this is only cast of generic type.
                    // Allows ErrorHandler to respond to .nilValue.
                    let mappedResponseForErrorHandler = mappedResponse.map { _ in newResponse.rawData ?? Data() }
                    if case .failure = mappedResponse.result, self.errorHandler.canResolveError(response: mappedResponseForErrorHandler) {
                        self.errorHandler.resolveError(response: mappedResponseForErrorHandler) {
                            // ErrorHandler can change response, so its neccesary to remap it again.
                            let mappedResponse = mapResponse($0)
                            self.callbackQueue.async { callback(mappedResponse) }
                        }
                    } else {
                        self.callbackQueue.async { callback(mappedResponse) }
                    }

                    return Cancellable()
                }
                parentCancellable.add(cancellable: cancellable)
            }
            return parentCancellable
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

    private func chain<C: Collection>(request: Request, enhancers: C, done: @escaping (Result<Request, Error>) -> Cancellable) -> Cancellable where C.Element == ChainingRequestEnhancer {
        guard let nextEnhancer = enhancers.first else {
            return done(.success(request))
        }

        let parentCancellable = Cancellable()
        let childCancellable = nextEnhancer.enhance(request: request) { result in
            guard !parentCancellable.isCancelled else { return }

            switch result {
            case .success(let newRequest):
                let grandchildCancellable = self.chain(request: newRequest, enhancers: enhancers.dropFirst(), done: done)
                parentCancellable.add(cancellable: grandchildCancellable)
            case .failure(let error):
                parentCancellable.add(cancellable: done(.failure(error)))
            }
        }
        parentCancellable.add(cancellable: childCancellable)
        return parentCancellable
    }

    private func chain<C: Collection>(response: Response<Data>, enhancers: C, done: @escaping (Response<Data>) -> Cancellable) -> Cancellable where C.Element == ChainingRequestEnhancer {
        guard let nextEnhancer = enhancers.first else {
            return done(response)
        }

        let parentCancellable = Cancellable()
        let childCancellable = nextEnhancer.deenhance(response: response) { newResponse in
            guard !parentCancellable.isCancelled else { return }

            let grandchildCancellable = self.chain(response: newResponse, enhancers: enhancers.dropFirst(), done: done)
            parentCancellable.add(cancellable: grandchildCancellable)
        }
        parentCancellable.add(cancellable: childCancellable)
        return parentCancellable
    }
}
