//
//  TitleHeaderTableCell.swift
//  GExample
//
//  Created by Eugene on 09.03.2020.
//  Copyright © 2020 Eugene. All rights reserved.
//

import UIKit
import G

final class TitleHeaderTableCell: UITableViewHeaderFooterView {
    
    var gtcModel: GTCellModel<TitleHeaderTableCell>?
    
}

extension TitleHeaderTableCell: GTCSetupable {
    
    typealias Model = TitleCellModel
    
    static func createSelf() -> TitleHeaderTableCell {
        return TitleHeaderTableCell()
    }
    
    func setup(model: TitleCellModel) {
        textLabel?.text = model.title
        backgroundColor = model.color
    }
    
    func size(in rect: CGRect, model: TitleCellModel) -> CGSize {
        return CGSize(width: rect.width, height: 50)
    }
    
}
