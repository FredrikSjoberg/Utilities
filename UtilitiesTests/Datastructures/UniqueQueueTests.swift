//
//  UniqueQueueTests.swift
//  Utilities
//
//  Created by Fredrik Sjöberg on 20/12/16.
//  Copyright © 2016 KnightsFee. All rights reserved.
//

import Foundation
import Nimble
import Quick
@testable import Utilities

class UniqueQueueTests: QuickSpec {
    override func spec() {
        var queue: UniqueQueue<Int>!
        beforeEach {
            queue = UniqueQueue()
        }
        
        describe("UniqueQueue") {
            it("should init with array litterals") {
                queue = [1, 2, 3, 2]
                expect(queue.count).to(equal(3))
                expect(queue.peek()).to(equal(1))
            }
            
            it("Should push to the front") {
                queue.push(element: 1)
                expect(queue.peek()).to(equal(1))
                queue.push(element: 2)
                expect(queue.peek()).to(equal(1))
            }
            
            it("should enforce uniqueness on push") {
                queue.push(element: 1)
                queue.push(element: 3)
                expect(queue.count).to(equal(2))
                queue.push(element: 1)
                expect(queue.count).to(equal(2))
            }
            it("should pop from the front") {
                queue.push(element: 2)
                queue.push(element: 1)
                expect(queue.pop()).to(equal(2))
                expect(queue.pop()).to(equal(1))
            }
            
            it("should return nil when popping an empty queue") {
                expect(queue.pop()).to(beNil())
            }
            
            it("should invalidate elements") {
                queue.invalidate(element: 1)
                expect(queue.isEmpty).to(beTrue())
                
                queue.push(element: 1)
                queue.push(element: 3)
                queue.push(element: 2)
                queue.invalidate(element: 1)
                expect(queue.peek()).to(equal(3))
                
                queue.invalidate(element: 5)
                expect(queue.count).to(equal(2))
                
                var empty = Queue<Int>()
                empty.invalidate(element: 1)
                expect(empty.count).to(equal(0))
            }
            
            it("Collection") {
                expect(queue.startIndex).to(equal(0))
                expect(queue.endIndex).to(equal(0))
                queue.push(element: 1)
                expect(queue.startIndex).to(equal(0))
                expect(queue.endIndex).to(equal(1))
                expect(queue.index(after: 0)).to(equal(1))
                queue.push(element: 3)
                expect(queue[1]).to(equal(3))
            }
            
            it("CustomStringConvertible, CustomDebugStringConvertible") {
                queue.push(element: 2)
                queue.push(element: 1)
                expect(queue.description).to(equal([2,1].description))
                expect(queue.debugDescription).to(equal([2,1].debugDescription))
            }
        }
    }
}
