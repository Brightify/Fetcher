//
//  ObservableConvertibleType+Response.swift
//  Fetcher
//
//  Created by Filip Dolnik on 10.12.16.
//  Copyright © 2016 Brightify. All rights reserved.
//

import RxSwift
import Foundation

extension PrimitiveSequenceType where TraitType == SingleTrait, ElementType: ResponseProtocol {
    public func asResult() -> Single<FetcherResult<ElementType.BodyType>> {
        return map { $0.result }
    }

    public func asBody() -> Single<ElementType.BodyType> {
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

extension PrimitiveSequenceType where TraitType == SingleTrait, ElementType: ResponseProtocol, ElementType.BodyType == Void {
    public func asCompleted() -> Completable {
        return asBody().asCompletable()
    }
}

