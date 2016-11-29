//
//  Lineage.swift
//  KFDataStructures
//
//  Created by Fredrik Sjöberg on 24/09/15.
//  Copyright © 2015 Fredrik Sjoberg. All rights reserved.
//

import Foundation

public class Lineage<Element: Hashable> {
    fileprivate var root: LineageNode<Element>?
    
    public init(element: Element) {
        self.root = LineageNode(element: element)
    }
    
    public func link(parent: Element, child: Element) {
        guard let root = root else {
            return
        }
        root.link(parent: parent, child: child)
    }
    
    /// Truncates 'element' if it is a leaf
    public func prune(element: Element) {
        guard let root = self.root else { return }
        guard let present = root.node(for: element) else { return }
        guard let replacement = present.prune(element: element) else { return }
        if present === root {
            self.root = nil
        }
    }
    
    public func contains(element: Element) -> Bool {
        guard let root = self.root else { return false }
        return root.contains(element: element)
    }
    public var leaves: [Element] {
        guard let root = self.root else { return [] }
        return root.leaves
    }
    
    /// Path is from 'element' -> 'root'
    public func rootPath(from element: Element) -> [Element] {
        guard let root = self.root else { return [] }
        return root.rootPath(from: element)
    }
}

public class LineageNode<Element: Hashable> {
    let element: Element
    
    private weak var parent: LineageNode?
    private var children: Set<LineageNode>
    
    public convenience init(element: Element) {
        self.init(element: element, parent: nil)
    }
    
    public init(element: Element, parent: LineageNode?) {
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
        node.children.insert(LineageNode(element: child, parent: node))
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
    public func prune(element: Element) -> LineageNode<Element>? {
        guard let node = node(for: element) else { return nil }
        guard node.isLeaf else { return nil }
        node.parent?.children.remove(node)
        node.parent = nil
        
        return node
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
    
    fileprivate func node(for element: Element) -> LineageNode? {
        if self.element == element { return self }
        
        for c in children {
            if let node = c.node(for: element) {
                return node
            }
        }
        return nil
    }
}

extension LineageNode : Hashable {
    public var hashValue: Int {
        return element.hashValue
    }
}

public func == <T: Hashable>(lhs: LineageNode<T>, rhs: LineageNode<T>) -> Bool {
    return lhs.element == rhs.element
}
