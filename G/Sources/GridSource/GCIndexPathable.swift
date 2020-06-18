//
//  GCIndexPathable.swift
//  G
//
//  Created by Eugene on 17.02.2020.
//  Copyright © 2020 Eugene. All rights reserved.
//

import Foundation

// Grid Cell
public protocol GCIndexPathable {
    
    var gcIndexPath: GCIndexPath { get set }
    
}

extension GCIndexPathable {
    
    mutating func updateIndexPath(_ indexPath: IndexPath) {
        gcIndexPath.indexPath = indexPath
    }
    
    mutating func update(_ gcIndexPath: GCIndexPath) {
        self.gcIndexPath = gcIndexPath
    }
    
    func copy(type: GCIndexPath.CellType, newIndexPath: IndexPath) -> Self {
        var object = self
        object.gcIndexPath = GCIndexPath(cellType: type, indexPath: newIndexPath)
        return object
    }
    
    func copy(gcIndexPath: GCIndexPath) -> Self {
        var object = self
        object.gcIndexPath = gcIndexPath
        return object
    }
}


// Grid Cell
public struct GCIndexPath: Hashable {
    
    let cellType: CellType
    var indexPath: IndexPath
    
    public enum CellType: UInt8 {
        case header
        case cell
        case footer
    }
    
    static func zero(type: CellType, section: Int) -> GCIndexPath {
        let indexPath = IndexPath(item: 0, section: section)
        return GCIndexPath(cellType: type, indexPath: indexPath)
    }
}
