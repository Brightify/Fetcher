//
//  ObservableConvertibleType+Response.swift
//  Fetcher
//
//  Created by Filip Dolnik on 10.12.16.
//  Copyright © 2016 Brightify. All rights reserved.
//

import RxSwift
import Result

extension ObservableConvertibleType where E: ResponseProtocol {

    public func retryRequest(max: Int = Int.max, delay: DispatchTimeInterval = .seconds(0)) -> Observable<E> {
        return asObservable().flatMap { response in
            return Observable.create { observer in
                switch response.result {
                case .success:
                    observer.onNext(response)
                case .failure:
                    response.request.retry(max: max, delay: delay) {
                        observer.onNext(response)
                    }
                }
                observer.onCompleted()
                
                return Disposables.create()
            }
        }
    }
    
    public func asResult() -> Observable<FetcherResult<E.T>> {
        return asObservable().map { $0.result }
    }
}
