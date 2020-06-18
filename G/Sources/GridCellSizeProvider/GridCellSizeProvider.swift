//
//  GridCellSizeProvider.swift
//  G
//
//  Created by Eugene on 17.02.2020.
//  Copyright © 2020 Eugene. All rights reserved.
//

import UIKit

public protocol GridCellSizeProvider: AnyObject {
    
    func size<S: GTCSetupable>(in rect: CGRect, gtcModel: GTCellModel<S>) -> CGSize
    
    func size<S: GCCSetupable>(in rect: CGRect, gccModel: GCCellModel<S>) -> CGSize
}

public final class GridCellSizeProviderImp {
    
    private var prototypeCells: [String: AnyObject] = [:]
    private var sizeCache: [GCIndexPath: CGSize] = [:]
    
    public init() { }
    
}

extension GridCellSizeProviderImp: GridCellSizeProvider {
    
    public func size<S: GTCSetupable>(in rect: CGRect, gtcModel: GTCellModel<S>) -> CGSize {
        
        let id = S.className
        
//        guard sizeCache[gtcModel.gcIndexPath] == nil else {
//            return sizeCache[gtcModel.gcIndexPath]!
//        }
        
        if prototypeCells[id] == nil {
            prototypeCells.updateValue(S.createSelf(), forKey: id)
        }

        let size = (prototypeCells[id] as! S).size(in: rect, model: gtcModel.model)

        sizeCache.updateValue(size, forKey: gtcModel.gcIndexPath)

        return size
    }
    
    public func size<S>(in rect: CGRect, gccModel: GCCellModel<S>) -> CGSize where S : GCCSetupable {
        
        let id = S.className
        
//        guard sizeCache[gccModel.gcIndexPath] == nil else {
//            return sizeCache[gccModel.gcIndexPath]!
//        }
        
        if prototypeCells[id] == nil {
            prototypeCells.updateValue(S.createSelf(), forKey: id)
        }

        let size = (prototypeCells[id] as! S).size(in: rect, model: gccModel.model)

        sizeCache.updateValue(size, forKey: gccModel.gcIndexPath)

        return size
    }
    
}
