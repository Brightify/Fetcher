//
//  CancellableTest.swift
//  Fetcher
//
//  Created by Filip Dolnik on 26.01.17.
//  Copyright © 2017 Brightify. All rights reserved.
//

import Quick
import Nimble
import Fetcher

class CancellableTest: QuickSpec {
    
    override func spec() {
        describe("Cancellable") { 
            describe("cancel") {
                it("calls cancelAction from init") {
                    var called = false
                    let cancellable = Cancellable {
                        called = true
                    }
                    
                    cancellable.cancel()
                    
                    expect(called).to(beTrue())
                }
                it("also calls cancelAction from Cancellable added by add") {
                    var firstCalled = false
                    var secondCalled = false
                    let firstCancellable = Cancellable {
                        firstCalled = true
                    }
                    let secondCancellable = Cancellable {
                        secondCalled = true
                    }
                    secondCancellable.add(cancellable: firstCancellable)
                    
                    secondCancellable.cancel()
                    
                    expect(firstCalled).to(beTrue())
                    expect(secondCalled).to(beTrue())
                }
            }
            describe("add") {
                it("calls cancelAction of passed Cancellable if cancel was already called") {
                    var called = false
                    let firstCancellable = Cancellable {
                        called = true
                    }
                    let secondCancellable = Cancellable()
                    secondCancellable.cancel()
                    
                    secondCancellable.add(cancellable: firstCancellable)
                    
                    expect(called).to(beTrue())
                }
                it("does not call cancelAction of passed Cancellable otherwise") {
                    var called = false
                    let firstCancellable = Cancellable {
                        called = true
                    }
                    let secondCancellable = Cancellable()
                    
                    secondCancellable.add(cancellable: firstCancellable)
                    
                    expect(called).to(beFalse())
                }
            }
        }
    }
}
