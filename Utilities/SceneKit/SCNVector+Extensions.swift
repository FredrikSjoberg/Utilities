//
//  SCNVector+Extensions.swift
//  Utilities
//
//  Created by Fredrik Sjöberg on 10/10/16.
//  Copyright © 2016 KnightsFee. All rights reserved.
//

import Foundation
import SceneKit

extension SCNVector3 {
    public init(x: CGFloat, y: CGFloat, z: CGFloat) {
        self.x = Float(x)
        self.y = Float(y)
        self.z = Float(z)
    }
    
    public var length: Float {
        return sqrt(lengthSQ)
    }
    
    public var lengthSQ: Float {
        return x*x + y*y + z*z
    }
    
    public var normalized: SCNVector3 {
        let l = length
        return (l > 0 ? self / l : SCNVector3Zero)
    }
    
    public func cross(_ vector: SCNVector3) -> SCNVector3 {
        return SCNVector3(y * vector.z - z * vector.y, z * vector.x - x * vector.z, x * vector.y - y * vector.x)
    }
    
    public func planeNormal(v0: SCNVector3, v1: SCNVector3) -> SCNVector3 {
        let m0 = v0-self
        let m1 = v1-self
        return m0.cross(m1).normalized
    }
}


public func + (left: SCNVector3, right: SCNVector3) -> SCNVector3 {
    return SCNVector3(left.x + right.x, left.y + right.y, left.z + right.z)
}

public func - (left: SCNVector3, right: SCNVector3) -> SCNVector3 {
    return SCNVector3(left.x - right.x, left.y - right.y, left.z - right.z)
}

public func * (left: SCNVector3, right: SCNVector3) -> SCNVector3 {
    return SCNVector3(left.x * right.x, left.y * right.y, left.z * right.z)
}

public func / (left: SCNVector3, right: SCNVector3) -> SCNVector3 {
    return SCNVector3(left.x / right.x, left.y / right.y, left.z / right.z)
}

public func * (vector: SCNVector3, scalar: Float) -> SCNVector3 {
    return SCNVector3(vector.x * scalar, vector.y * scalar, vector.z * scalar)
}

public func / (vector: SCNVector3, scalar: Float) -> SCNVector3 {
    return SCNVector3(vector.x / scalar, vector.y / scalar, vector.z / scalar)
}
