//
//  SCNVectorTests.swift
//  Utilities
//
//  Created by Fredrik Sjöberg on 20/12/16.
//  Copyright © 2016 KnightsFee. All rights reserved.
//

import Foundation
import Nimble
import Quick
import SceneKit
@testable import Utilities

class SCNVectorTests: QuickSpec {
    override func spec() {
        describe("SCNVector3") {
            it("should init") {
                let value: CGFloat = 5
                let v = SCNVector3(x: value, y: value, z: value)
                
                let float: Float = 5
                expect(v.x).to(equal(float))
                expect(v.x).to(equal(float))
                expect(v.x).to(equal(float))
            }
            
            it("should calculate") {
                let vector = SCNVector3(1,1,1)
                
                let lengthsq: Float = 3
                expect(vector.length).to(equal(sqrt(lengthsq)))
                expect(vector.lengthSQ).to(equal(lengthsq))
                
                let normalized = vector.normalized
                expect(normalized.x).to(equal(1/sqrt(lengthsq)))
                expect(normalized.y).to(equal(1/sqrt(lengthsq)))
                expect(normalized.z).to(equal(1/sqrt(lengthsq)))
                
                let zeroNorm = SCNVector3Zero.normalized
                expect(zeroNorm.x).to(equal(0))
                expect(zeroNorm.y).to(equal(0))
                expect(zeroNorm.z).to(equal(0))
                
                let other = SCNVector3(3,2,1)
                let cross = vector.cross(other)
                let expected = SCNVector3(-1, 2, -1)
                expect(cross.x).to(equal(expected.x))
                expect(cross.y).to(equal(expected.y))
                expect(cross.z).to(equal(expected.z))
                
                let other2 = SCNVector3(3,4,3)
                let planeNormal = vector.planeNormal(v0: other, v1: other2)
                let expectedPlane = SCNVector3(1.0/3.0, -2.0/3.0, 2.0/3.0)
                expect(planeNormal.x).to(equal(expectedPlane.x))
                expect(planeNormal.y).to(equal(expectedPlane.y))
                expect(planeNormal.z).to(equal(expectedPlane.z))
                
                let plus = vector + other
                let expectedPlus = SCNVector3(4,3,2)
                expect(plus.x).to(equal(expectedPlus.x))
                expect(plus.y).to(equal(expectedPlus.y))
                expect(plus.z).to(equal(expectedPlus.z))
                
                let multi = vector * other
                let expectedMulti = SCNVector3(3,2,1)
                expect(multi.x).to(equal(expectedMulti.x))
                expect(multi.y).to(equal(expectedMulti.y))
                expect(multi.z).to(equal(expectedMulti.z))
                
                let multiScalar = vector * 3
                let expectedMultiScalar = SCNVector3(3,3,3)
                expect(multiScalar.x).to(equal(expectedMultiScalar.x))
                expect(multiScalar.y).to(equal(expectedMultiScalar.y))
                expect(multiScalar.z).to(equal(expectedMultiScalar.z))
                
                let div = vector / other
                let expectedDiv = SCNVector3(1.0/3.0, 1.0/2.0, 1.0)
                expect(div.x).to(equal(expectedDiv.x))
                expect(div.y).to(equal(expectedDiv.y))
                expect(div.z).to(equal(expectedDiv.z))
            }
        }
    }
}
