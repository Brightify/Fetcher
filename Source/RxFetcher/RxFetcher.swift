//
//  RxFetcher.swift
//  Fetcher
//
//  Created by Filip Dolnik on 09.12.16.
//  Copyright © 2016 Brightify. All rights reserved.
//

import RxSwift

public struct RxFetcher {
    
    public let fetcher: Fetcher
    
    internal init(fetcher: Fetcher) {
        self.fetcher = fetcher
    }

    internal func observe<T>(request: @escaping (@escaping (Response<T>) -> Void) -> Cancellable) -> Single<Response<T>> {
        return Single<Response<T>>.create { emitter in
            let cancellable = request { response in
                emitter(.success(response))
            }
            return Disposables.create {
                cancellable.cancel()
            }
        }
    }
}
