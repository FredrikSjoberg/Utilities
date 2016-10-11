//
//  Lineage.swift
//  KFDataStructures
//
//  Created by Fredrik Sjöberg on 24/09/15.
//  Copyright © 2015 Fredrik Sjoberg. All rights reserved.
//

import Foundation

public class Lineage<Element: Hashable> {
    let element: Element
    
    private weak var parent: Lineage?
    private var children: Set<Lineage>
    
    public convenience init(element: Element) {
        self.init(element: element, parent: nil)
    }
    
    public init(element: Element, parent: Lineage?) {
        self.element = element
        self.parent = parent
        children = Set()
    }
    
    public var isLeaf: Bool {
        return children.isEmpty
    }
    
    public var isOrigin: Bool {
        return parent == nil ? true : false
    }
    
    public func contains(element: Element) -> Bool {
        guard node(for: element) != nil else {
            return false
        }
        return true
    }
    
    public func link(parent: Element, child: Element) {
        guard let node = node(for: parent) else { return }
        node.children.insert(Lineage(element: child, parent: node))
    }
    
    /// Removes 'element' from the Lineage
    /// If 'repair' == true, transfers all children of 'element' to 'element.parent
    public func unlink(element: Element, repair: Bool = false) -> Element? {
        guard let node = node(for: element) else { return nil }
        node.parent?.children.remove(node)
        
        if repair {
            node.parent?.children.formUnion(node.children)
            node.children.forEach{ $0.parent = node.parent }
        }
        else { node.children.removeAll() }
        node.parent = nil
        
        return node.element
    }
    
    /// Truncates 'element' if it is a leaf
    public func prune(element: Element) -> Element? {
        guard let node = node(for: element) else { return nil }
        guard node.isLeaf else { return nil }
        node.parent?.children.remove(node)
        node.parent = nil
        
        return node.element
    }
    
    /// Path is from 'element' -> 'root'
    public func rootPath(from element: Element) -> [Element] {
        guard let node = node(for: element) else { return [] }
        if node.isOrigin { return [node.element] }
        
        var result: [Element] = [node.element]
        var parent = node.parent
        while parent != nil {
            result.append(parent!.element)
            parent = parent?.parent
        }
        return result
    }
    
    public var leaves: [Element] {
        if isLeaf { return [element] }
        return children.flatMap{ $0.leaves }
    }
    
    private func node(for element: Element) -> Lineage? {
        if self.element == element { return self }
        
        for c in children {
            if let node = c.node(for: element) {
                return node
            }
        }
        return nil
    }
}

extension Lineage : Hashable {
    public var hashValue: Int {
        return element.hashValue
    }
}

public func == <T: Hashable>(lhs: Lineage<T>, rhs: Lineage<T>) -> Bool {
    return lhs.element == rhs.element
}
