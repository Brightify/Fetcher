//
//  RequestEnhancerPriorityTest.swift
//  Fetcher
//
//  Created by Filip Dolnik on 27.01.17.
//  Copyright © 2017 Brightify. All rights reserved.
//

import Quick
import Nimble
import Fetcher

class RequestEnhancerPriorityTest: QuickSpec {
    
    override func spec() {
        describe("RequestEnhancerPriority") {
            let priority = RequestEnhancerPriority.custom(value: 10)
            
            describe("less") {
                it("returns priority smaller then original") {
                    expect(priority.less.value) < priority.value
                }
            }
            describe("more") {
                it("returns priority larger then original") {
                    expect(priority.more.value) > priority.value
                }
            }
        }
    }
    
    func apiTest() {
        _ = RequestEnhancerPriority.low
        _ = RequestEnhancerPriority.normal
        _ = RequestEnhancerPriority.high
        _ = RequestEnhancerPriority.fetcher
        _ = RequestEnhancerPriority.max
        _ = RequestEnhancerPriority.custom(value: 1)
    }
}
