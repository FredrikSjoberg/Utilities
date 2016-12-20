//
//  QueueTests.swift
//  Utilities
//
//  Created by Fredrik Sjöberg on 20/12/16.
//  Copyright © 2016 KnightsFee. All rights reserved.
//

import Foundation
import Nimble
import Quick
@testable import Utilities

class QueueTests: QuickSpec {
    override func spec() {
        var queue: Queue<Int>!
        beforeEach {
            queue = Queue()
        }
        
        describe("Init") {
            it("should init empty") {
                expect(queue.isEmpty).to(beTrue())
            }
            
            it("should init with contents") {
                let contents = [1, 3, 2, 6]
                queue = Queue(elements: contents)
                expect(queue.count).to(equal(4))
            }
            
            it("should push to the back") {
                queue.push(element: 2)
                expect(queue.peek()).to(equal(2))
                queue.push(element: 1)
                expect(queue.peek()).to(equal(2))
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
        }
    }
}
