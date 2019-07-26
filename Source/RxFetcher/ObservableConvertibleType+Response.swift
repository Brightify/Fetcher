//
//  ObservableConvertibleType+Response.swift
//  Fetcher
//
//  Created by Filip Dolnik on 10.12.16.
//  Copyright © 2016 Brightify. All rights reserved.
//

import RxSwift
import Foundation

extension PrimitiveSequenceType where Trait == SingleTrait, Element: ResponseProtocol {
    public func asResult() -> Single<FetcherResult<Element.BodyType>> {
        return map { $0.result }
    }

    public func asBody() -> Single<Element.BodyType> {
        return flatMap { response in
            switch response.result {
            case .success(let body):
                return .just(body)
            case .failure(let error):
                return .error(error)
            }
        }
    }
}

extension PrimitiveSequenceType where Trait == SingleTrait, Element: ResponseProtocol, Element.BodyType == Void {
    public func asCompleted() -> Completable {
        return asBody().asCompletable()
    }
}

