//
//  CGPoint+Extensions.swift
//  Utilities
//
//  Created by Fredrik Sjöberg on 10/10/16.
//  Copyright © 2016 KnightsFee. All rights reserved.
//

import CoreGraphics
extension CGPoint {
    public init(x: Float, y: Float) {
        self.x = CGFloat(x)
        self.y = CGFloat(y)
    }
    
    public var length: CGFloat {
        return sqrt(lengthSQ)
    }
    
    public var lengthSQ: CGFloat {
        return x*x + y*y
    }
    
    public var normalized: CGPoint {
        let l = length
        return (l > 0 ? self / l : CGPoint.zero)
    }
    
    public func midpoint(_ point: CGPoint) -> CGPoint {
        return (self + point)*CGFloat(0.5)
    }
    
    public func dot(_ point: CGPoint) -> CGFloat {
        return self.x*point.x + self.y*point.y
    }
    
    public func cross(_ point: CGPoint) -> CGPoint {
        return CGPoint(x: self.x*point.y, y: self.y*point.x)
    }
    
    public func centeroid(_ points: Set<CGPoint>) -> CGPoint {
        return points.reduce(self){ $0 + $1 }/Float(points.count + 1)
    }
    
    public func distance(_ point: CGPoint) -> CGFloat {
        return (self - point).length
    }
}

extension CGPoint : Hashable {
    public var hashValue: Int {
        // iOS Swift Game Development Cookbook
        // https://books.google.se/books?id=QQY_CQAAQBAJ&pg=PA304&lpg=PA304&dq=swift+CGpoint+hashvalue&source=bl&ots=1hp2Fph274&sig=LvT36RXAmNcr8Ethwrmpt1ynMjY&hl=sv&sa=X&ved=0CCoQ6AEwAWoVChMIu9mc4IrnxgIVxXxyCh3CSwSU#v=onepage&q=swift%20CGpoint%20hashvalue&f=false
        return x.hashValue << 32 ^ y.hashValue
    }
}

public func ==(lhs: CGPoint, rhs: CGPoint) -> Bool {
    return lhs.distance(rhs) < 0.000001 //CGPointEqualToPoint(lhs, rhs)
}

extension CGPoint {
    /// True iff self is exacly on the border
    public func onBorder(rect: CGRect) -> Bool {
        return (x == rect.origin.x || x == rect.origin.x + rect.size.width || y == rect.origin.y || y == rect.origin.y + rect.size.height)
    }
    
    public func closerThan(dist: CGFloat, to point: CGPoint) -> (CGPoint, CGFloat) {
        let selfDist = distance(point)
        if selfDist < dist {
            return (self, selfDist)
        }
        return (point, dist)
    }
    
    public func closestCornerTo(rect: CGRect) -> CGPoint {
        var shortest = (rect.origin, distance(rect.origin))
        shortest = closerThan(dist: shortest.1, to: rect.topLeft)
        shortest = closerThan(dist: shortest.1, to: rect.topRight)
        shortest = closerThan(dist: shortest.1, to: rect.bottomRight)
        return shortest.0
    }
}

// Add
public func + (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x + right.x, y: left.y + right.y)
}

/*func += (inout left: CGPoint, right: CGPoint) -> CGPoint {
 left = left + right
 }*/

// Subtract
public func - (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x - right.x, y: left.y - right.y)
}

/*func -= (inout left: CGPoint, right: CGPoint) -> CGPoint {
 left = left - right
 }*/

// Multiply
public func * (left: CGPoint, scalar: CGFloat) -> CGPoint {
    return CGPoint(x: left.x * scalar, y: left.y * scalar)
}

/*func *= (inout left: CGPoint, scalar: CGFloat) -> CGPoint {
 left = left * scalar
 }*/

public func * (left: CGPoint, scalar: Float) -> CGPoint {
    return left * CGFloat(scalar)
}

/*func *= (inout left: CGPoint, scalar: Float) -> CGPoint {
 left = left * scalar
 }*/

// Division
public func / (left: CGPoint, scalar: CGFloat) -> CGPoint {
    return CGPoint(x: left.x / scalar, y: left.y / scalar)
}

/*func /= (inout left: CGPoint, scalar: CGFloat) -> CGPoint {
 left = left / scalar
 }*/

public func / (left: CGPoint, scalar: Float) -> CGPoint {
    return left / CGFloat(scalar)
}

/*func /= (inout left: CGPoint, scalar: Float) -> CGPoint {
 left = left / scalar
 }*/

import GameplayKit
extension CGPoint {
    init(random: GKRandom, interval: ClosedRange<Float>) {
        x = CGFloat(random.nextUniform(interval: interval))
        y = CGFloat(random.nextUniform(interval: interval))
    }
}
