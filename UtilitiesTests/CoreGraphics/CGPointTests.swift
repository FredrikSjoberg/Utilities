//
//  CGPointTests.swift
//  Utilities
//
//  Created by Fredrik Sjöberg on 20/12/16.
//  Copyright © 2016 KnightsFee. All rights reserved.
//

import Foundation
import Nimble
import Quick
import GameplayKit
@testable import Utilities

class CGPointTests: QuickSpec {
    override func spec() {
        let point = CGPoint(x: 10, y: 10)
        let other = CGPoint(x: 2, y: 2)
        
        describe("CGPoint") {
            it("should init") {
                let float: Float = 5
                let floatPoint = CGPoint(x: float, y: float)
                expect(floatPoint.x).to(equal(5))
                expect(floatPoint.y).to(equal(5))
            }
            
            it("calculations") {
                let lengthsq: CGFloat = 200
                expect(point.length).to(equal(sqrt(lengthsq)))
                expect(point.lengthSQ).to(equal(lengthsq))
                
                let normalized = point.normalized
                expect(normalized.x).to(equal(point.x/sqrt(lengthsq)))
                expect(normalized.y).to(equal(point.y/sqrt(lengthsq)))
                
                let zeroNorm = CGPoint.zero.normalized
                expect(zeroNorm.x).to(equal(0))
                expect(zeroNorm.y).to(equal(0))
                
                let midpoint = point.midpoint(CGPoint(x: 10, y: 0))
                expect(midpoint.x).to(equal(10))
                expect(midpoint.y).to(equal(5))
                
                expect(point.dot(other)).to(equal(40))
                let cross = CGPoint(x: point.x*other.y, y: point.y*other.x)
                expect(point.cross(other).x).to(equal(cross.x))
                expect(point.cross(other).y).to(equal(cross.y))
                
                
                let points: Set<CGPoint> = [
                    CGPoint.zero,
                    CGPoint(x: 0, y: 10),
                    CGPoint(x: 10, y: 0),
                ]
                let centeroid = point.centeroid(points)
                expect(centeroid.x).to(equal(5))
                expect(centeroid.y).to(equal(5))
                
                let distance:CGFloat = sqrt(8*8 + 8*8)
                expect(point.distance(other)).to(equal(distance))
                
                
//                expect(point == CGPoint(x: 10, y: 10)).to(beTrue())
                
                let rect = CGRect(x: 0, y: 0, width: 10, height: 10)
                expect(point.onBorder(rect: rect)).to(beTrue())
                expect(other.onBorder(rect: rect)).to(beFalse())
                expect(CGPoint.zero.onBorder(rect: rect)).to(beTrue())
                
                var multi = point * CGFloat(2)
                expect(multi.x).to(equal(20))
                expect(multi.y).to(equal(20))
                    
                multi = point * Float(3)
                expect(multi.x).to(equal(30))
                expect(multi.y).to(equal(30))
            }
            
            it("should be deterministic") {
                let variance = 0.0001
                let random = GKMersenneTwisterRandomSource(seed: 1)
                let randomPoint = CGPoint(random: random, interval: (0...10))
                expect(randomPoint.x).to(beCloseTo(1.3387, within: variance))
                expect(randomPoint.y).to(beCloseTo(1.3640, within: variance))
            }
        }
    }
}
