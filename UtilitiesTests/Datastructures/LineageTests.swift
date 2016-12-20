//
//  LineageTests.swift
//  Utilities
//
//  Created by Fredrik Sjöberg on 20/12/16.
//  Copyright © 2016 KnightsFee. All rights reserved.
//

import Foundation

import Nimble
import Quick
@testable import Utilities

class LineageTests: QuickSpec {
    override func spec() {
        
        describe("Link") {
            var lineage: Lineage<Int>!
            beforeEach {
                lineage = Lineage<Int>(element: 1)
            }
            
            it("should link with valid root") {
                lineage.link(parent: 1, child: 2)
                lineage.link(parent: 1, child: 3)
                lineage.link(parent: 2, child: 4)
                
                expect(lineage.contains(element: 1)).to(beTrue())
                expect(lineage.contains(element: 2)).to(beTrue())
                expect(lineage.contains(element: 3)).to(beTrue())
                expect(lineage.contains(element: 4)).to(beTrue())
                expect(lineage.contains(element: 5)).to(beFalse())
                
                expect(lineage.leaves).to(haveCount(2))
                
                expect(lineage.rootPath(from: 4)).to(equal([4, 2, 1]))
            }
            
            it("should be valid with root removed") {
                lineage.prune(element: 1)
                
                expect(lineage.contains(element: 1)).to(beFalse())
                expect(lineage.leaves).to(haveCount(0))
                
                lineage.prune(element: 2)
                expect(lineage.leaves).to(haveCount(0))
                
                lineage.link(parent: 1, child: 2)
                expect(lineage.leaves).to(haveCount(0))
                
                expect(lineage.rootPath(from: 1)).to(equal([]))
            }
            
            it("should not prune non leaf nodes ") {
                lineage.link(parent: 1, child: 2)
                
                lineage.prune(element: 1)
                expect(lineage.rootPath(from: 2)).to(equal([2, 1]))
            }
            
            it("should ignore prune invalid elements") {
                lineage.prune(element: 3)
                expect(lineage.contains(element: 1)).to(beTrue())
            }
        }
        
        var node: LineageNode<Int>!
        beforeEach {
            node = LineageNode(element: 1)
        }
        describe("Node") {
            it("should mark as origin correctly") {
                expect(node.isOrigin).to(beTrue())
            }
            
            it("should not link to nodes not found in tree") {
                node.link(parent: 2, child: 3)
                expect(node.contains(element: 2)).to(beFalse())
                expect(node.contains(element: 3)).to(beFalse())
            }
            
            it("should only prune elements present in tree") {
                expect(node.prune(element: 2)).to(beNil())
            }
            
            it("should only prune leaves") {
                node.link(parent: 1, child: 2)
                expect(node.prune(element: 1)).to(beNil())
                expect(node.rootPath(from: 2)).to(equal([2, 1]))
            }
            
            it("should only return rootPath from elements present in tree") {
                expect(node.rootPath(from: 2)).to(equal([]))
            }
            
            it("should return rootPath to origin if asked") {
                node.link(parent: 1, child: 2)
                expect(node.rootPath(from: 1)).to(equal([1]))
            }
            
            it("should equate nodes based on elements") {
                let other = LineageNode(element: 1)
                expect(node).to(equal(other))
            }
        }
    }
}
