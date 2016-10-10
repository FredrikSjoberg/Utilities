//
//  GKRandom+Extensions.swift
//  Utilities
//
//  Created by Fredrik Sjöberg on 10/10/16.
//  Copyright © 2016 KnightsFee. All rights reserved.
//

import GameplayKit

extension GKRandom {
    public func nextUniform(interval: ClosedRange<Float>) -> Float {
        return (interval.lowerBound + (interval.upperBound - interval.lowerBound))*self.nextUniform()
    }
}
