//
//  GCCSetupable.swift
//  G
//
//  Created by Евгений Орехин on 18.04.2020.
//  Copyright © 2020 Eugene. All rights reserved.
//

import UIKit

// Grid Collection Cell
public protocol GCCSetupable: GCCSetupableCreator {
    
    associatedtype Model
    
    var gccModel: GCCellModel<Self>? { get set }
    
    func setup(model: Model)
    
    func size(in rect: CGRect, model: Model) -> CGSize
}

extension GCCSetupable {
    
    func setup(gccModel: GCCellModel<Self>) {
        self.gccModel = gccModel
        setup(model: gccModel.model)
    }
    
    public static func build(model: Model) -> GCCellModel<Self> {
        return GCCellModel<Self>(model: model)
    }
}
