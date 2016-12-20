//
//  ArrayTests.swift
//  Utilities
//
//  Created by Fredrik Sjöberg on 20/12/16.
//  Copyright © 2016 KnightsFee. All rights reserved.
//

import Foundation
import Nimble
import Quick
@testable import Utilities

class ArrayTests: QuickSpec {
    override func spec() {
        let array = [1, 3, 3, 6, 1, 10]
        describe("Unique") {
            it("should create set") {
                let set:Set<Int> = [1, 3, 6, 10]
                expect(array.set()).to(equal(set))
            }
            
            it("should make contents unique") {
                let set:Set<Int> = [1, 3, 6, 10]
                expect(array.unique().set()).to(equal(set))
                
                expect(array.unique(preserveOrder: true)).to(equal([1, 3, 6, 10]))
            }
            
            it("should prefix") {
                let prefixed = array.prefix{ $0 <= 6 }
                expect(prefixed).to(equal([1, 3, 3, 6, 1]))
                
                let empty = [].prefix{ $0 < 0 }
                expect(empty).to(haveCount(0))
            }
            
            it("should take until") {
                let taken = array.take{ $0 <= 6 }
                expect(taken).to(equal([1]))
                
                let taken2 = array.take{ $0 >= 6 }
                expect(taken2).to(equal([1, 3, 3, 6]))
                
                let empty = [].take{ $0 < 0 }
                expect(empty).to(haveCount(0))
            }
        }
    }
}
