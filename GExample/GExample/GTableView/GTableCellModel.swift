//
//  GTableCellModel.swift
//  GExample
//
//  Created by Eugene on 09.03.2020.
//  Copyright © 2020 Eugene. All rights reserved.
//

import G
import UIKit

struct GTableCellModel: GTCellProvider {
    
    let gtcModel: GTManagerCell
    
    init(title: String, color: UIColor, action: @escaping(IndexPath) -> Void) {
        let model = TitleCellModel(title: title, color: color, action: action)
        gtcModel = GTCellModel<TitleTableCell>(model: model)
    }
    
}
