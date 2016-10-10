//
//  CGRect+Extensions.swift
//  Utilities
//
//  Created by Fredrik Sjöberg on 10/10/16.
//  Copyright © 2016 KnightsFee. All rights reserved.
//

import CoreGraphics

extension CGRect {
    public var topLeft: CGPoint {
        return CGPoint(x: origin.x, y: origin.y+size.height)
    }
    
    public var topRight: CGPoint {
        return CGPoint(x: origin.x+size.width, y: origin.y+size.height)
    }
    
    public var bottomRight: CGPoint {
        return CGPoint(x: origin.x+size.width, y: origin.y)
    }
}
