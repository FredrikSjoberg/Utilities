//
//  Float+Extensions.swift
//  Utilities
//
//  Created by Fredrik Sjöberg on 11/10/16.
//  Copyright © 2016 KnightsFee. All rights reserved.
//

import Foundation

extension Float {
    public func clamp(min: Float, max: Float) -> Float {
        return Swift.max(min, Swift.min(max, self))
    }
}
