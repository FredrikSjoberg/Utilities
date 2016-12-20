//
//  GKRandomTests.swift
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

class GKRandomTests: QuickSpec {
    override func spec() {
        describe("Interval") {
            it("should be deterministic") {
                let random = GKMersenneTwisterRandomSource(seed: 1)
                let variance = 0.0001
                expect(random.nextUniform(interval: (0...10))).to(beCloseTo(1.3388, within: variance))
            }
        }
    }
}
