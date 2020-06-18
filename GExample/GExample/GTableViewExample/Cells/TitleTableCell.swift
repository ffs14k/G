//
//  TitleTableCell.swift
//  GExample
//
//  Created by Eugene on 09.03.2020.
//  Copyright © 2020 Eugene. All rights reserved.
//

import UIKit
import G

final class TitleTableCell: UITableViewCell {
    
    var gtcModel: GTCellModel<TitleTableCell>?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        addGestureRecognizer(tapGesture)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc final func tapAction() {
        gtcModel?.model.action(gtcModel!.indexPath)
    }
}


// MARK: - GTCSetupable
extension TitleTableCell: GTCSetupable {
    
    typealias Model = TitleCellModel
    
    static func createSelf() -> TitleTableCell {
        return TitleTableCell()
    }
    
    // setup(gtcModel: GTCellModel<Self>) call this method by default. Whatch `GTCSetupable`
    func setup(model: TitleCellModel) {
        
        // !automatic updating indexPaths withing gtcModel
        let title = "\(gtcModel!.indexPath) " + model.title
        
        textLabel?.text = title
        backgroundColor = model.color
        
        print(model)
    }
    
    func size(in rect: CGRect, model: TitleCellModel) -> CGSize {
        return CGSize(width: rect.width, height: 70)
    }
    
}
