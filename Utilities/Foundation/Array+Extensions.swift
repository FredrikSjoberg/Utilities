//
//  Array+Extensions.swift
//  Utilities
//
//  Created by Fredrik Sjöberg on 10/10/16.
//  Copyright © 2016 KnightsFee. All rights reserved.
//

import Foundation

extension Array where Element: Hashable {
    public func unique(preserveOrder: Bool = false) -> [Element] {
        guard preserveOrder else { return Array(self.set()) }
        var set = Set(self)
        return self.filter{
            if set.contains($0) {
                set.remove($0)
                return true
            }
            return false
        }
    }
    
    public func set() -> Set<Element> {
        return Set(self)
    }
}

extension Sequence {
    public func prefix(while predicate: @escaping (Self.Iterator.Element) -> Bool) -> [Self.Iterator.Element] {
        var total: [Self.Iterator.Element] = []
        for e in self {
            if predicate(e) {
                total.append(e)
            }
            else {
                return total
            }
        }
        return total
    }
    
    public func take(until predicate: @escaping (Self.Iterator.Element) -> Bool) -> [Self.Iterator.Element] {
        var total: [Self.Iterator.Element] = []
        for e in self {
            total.append(e)
            if predicate(e) {
                return total
            }
        }
        return total
    }
}
/*extension Sequence {
    ///
    /// let test = [2, 3, 1, 4, 5, 6]
    ///
    /// test.takeWhile{ $0 > 4 }
    /// -> []
    ///
    /// test.takeWhile{ $0 < 4 }
    ///  -> [2, 3, 1]
    ///
    /// Steps through the array, keeping each consecutive element while 'filter' is valid, then returns the slice
    func takeWhile(takeElement: (Self.Iterator.Element) -> Bool) -> [Self.Iterator.Element] {
        return TakeWhile(self, block: takeElement).map{ $0 }
    }
    
    ///
    /// let test = [2, 3, 1, 4, 5, 6]
    ///
    /// test.takeUntil{ $0 > 4 }
    /// -> [2, 3, 1, 4, 5]
    ///
    /// test.takeUntil{ $0 < 4 }
    ///  -> [2]
    ///
    /// Steps through the array, keeping each consecutive element while 'filter' is valid, then returns the slice
    func takeUntil(takeElement: (Self.Iterator.Element) -> Bool) -> [Self.Iterator.Element] {
        return TakeUntil(self, block: takeElement).map{ $0 }
    }
}


private struct TakeWhile<S: Sequence>: Sequence {
    let seq: S
    let block: (S.Iterator.Element) -> Bool
    
    init(_ seq: S, block: (S.Iterator.Element) -> Bool) {
        self.seq = seq
        self.block = block
    }
    
    func generate() -> AnyIterator<S.Iterator.Element> {
        var gen = seq.generate()
        return anyGenerator{
            if let element = gen.next() {
                if self.block(element) {
                    return element
                }
            }
            return nil
        }
    }
}

private struct TakeUntil<S: Sequence>: Sequence {
    let seq: S
    let block: (S.Iterator.Element) -> Bool
    
    init(_ seq: S, block: @escaping (S.Iterator.Element) -> Bool) {
        self.seq = seq
        self.block = block
    }
    
    func generate() -> AnyIterator<S.Iterator.Element> {
        var gen = seq.makeIterator()
        var completed: Bool = false
        return AnyIterator{
            if completed { return nil }
            if let element = gen.next() {
                if self.block(element) {
                    completed = true
                }
                return element
            }
            return nil
        }
    }
}*/
