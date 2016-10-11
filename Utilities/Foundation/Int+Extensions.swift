//
//  Int+Extensions.swift
//  Utilities
//
//  Created by Fredrik Sjöberg on 11/10/16.
//  Copyright © 2016 KnightsFee. All rights reserved.
//

import Foundation

extension Int {
    public func clamp(min: Int, max: Int) -> Int {
        return Swift.max(min, Swift.min(max, self))
    }
}
