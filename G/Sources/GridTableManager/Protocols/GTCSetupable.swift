//
//  GTCSetupable.swift
//  G
//
//  Created by Eugene on 17.02.2020.
//  Copyright © 2020 Eugene. All rights reserved.
//

import UIKit

// Grid Table Cell
protocol GTCSetupable: GTCSetupableCreator {
    
    associatedtype Model
    
    var gtcModel: GTCellModel<Self>? { get set }
    
    func setup(model: Model)
    
    func size(in rect: CGRect, gtcModel: GTCellModel<Self>) -> CGSize
    
}

extension GTCSetupable {
    
    func setup(gtcModel: GTCellModel<Self>) {
        self.gtcModel = gtcModel
        setup(model: gtcModel.model)
    }
    
}
