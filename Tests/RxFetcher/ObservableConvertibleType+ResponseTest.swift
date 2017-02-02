//
//  ObservableConvertibleType+ResponseTest.swift
//  Fetcher
//
//  Created by Filip Dolnik on 26.01.17.
//  Copyright © 2017 Brightify. All rights reserved.
//

import Quick
import Nimble
import Fetcher
import RxSwift

class ObservableConvertibleType_ResponseTest: QuickSpec {
    
    override func spec() {
        describe("ObservableConvertibleType+Response") {
            describe("retry") {
                var called = false
                let request = TestData.request(url: "xyz") { _ in
                    called = true
                }
                beforeEach {
                    called = false
                }
                
                it("calls retry of response.request if result is failure") {
                    let response: Response<Int> = TestData.response(request: request)
                    let observable: Observable<Response<Int>> = Observable.create {
                        $0.onNext(response)
                        return Disposables.create()
                    }
                    
                    observable.retryRequest().subscribe { _ in }.dispose()
                    
                    expect(called).to(beTrue())
                }
                it("does nothing if result if success") {
                    let response: Response<Int> = TestData.response(request: request, result: .success(1))
                    let observable: Observable<Response<Int>> = Observable.create {
                        $0.onNext(response)
                        return Disposables.create()
                    }
                    
                    observable.retryRequest().subscribe { _ in }.dispose()
                    
                    expect(called).to(beFalse())
                }
            }
            describe("asResult") {
                it("returns Observable with result") {
                    let response = TestData.response(url: "a", result: .success(1))
                    let observable: Observable<Response<Int>> = Observable.create {
                        $0.onNext(response)
                        return Disposables.create()
                    }
                    var called = false
                    
                    observable.asResult().subscribe {
                        expect($0.element?.value) == 1
                        called = true
                    }.dispose()
                    
                    expect(called).toEventually(beTrue())
                }
            }
        }
    }
}
