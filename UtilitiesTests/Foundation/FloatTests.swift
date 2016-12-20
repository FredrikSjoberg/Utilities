//
//  FloatTests.swift
//  Utilities
//
//  Created by Fredrik Sjöberg on 20/12/16.
//  Copyright © 2016 KnightsFee. All rights reserved.
//

import Foundation
import Nimble
import Quick
@testable import Utilities

class FloatTests: QuickSpec {
    override func spec() {
        describe("Float") {
            it("should calculate") {
                let value: Float = 5
                expect(value.clamp(min: 0, max: 4)).to(equal(4))
                expect(value.clamp(min: 10, max: 100)).to(equal(10))
                
                let negative: Float = -5
                expect(negative.clamp(min: -10, max: -8)).to(equal(-8))
                expect(negative.clamp(min: 0, max: 10)).to(equal(0))
                
//                expect(negative.clamp(min: -8, max: -10)).to(equal(-8))
//                expect(value.clamp(min: 10, max: 7)).to(equal(7))
            }
        }
    }
}
