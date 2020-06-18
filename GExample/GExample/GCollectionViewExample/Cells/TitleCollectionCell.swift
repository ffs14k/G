//
//  TitleCollectionCell.swift
//  GExample
//
//  Created by Евгений Орехин on 16.05.2020.
//  Copyright © 2020 Eugene. All rights reserved.
//

import G
import UIKit

final class TitleCollectionCell: UICollectionViewCell {
    
    var gccModel: GCCellModel<TitleCollectionCell>?
    
    private let button = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        
        button.setTitleColor(UIColor.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(onButtonTap), for: .touchUpInside)
        
        addSubview(button)
        NSLayoutConstraint.activate([
            button.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            button.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            button.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 10),
            button.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 10)
        ])
    }
    
    @objc private final func onButtonTap() {
        guard let gccModel = self.gccModel else { return }
        gccModel.model.action(gccModel.indexPath)
    }
}


// MARK: - GCCSetupable
extension TitleCollectionCell: GCCSetupable {
    
    typealias Model = TitleCellModel
    
    static func createSelf() -> TitleCollectionCell {
        return TitleCollectionCell()
    }
    
    // setup(gccModel: GCCellModel<Self>) call this method by default. Whatch `GCCSetupable`
    func setup(model: TitleCellModel) {
        
        // !automatic updating indexPaths withing gccModel
        let title = "\(gccModel!.indexPath) " + model.title
        
        button.setTitle(title, for: .normal)
        button.backgroundColor = model.color
    }
    
    func size(in rect: CGRect, model: TitleCellModel) -> CGSize {
        return CGSize(width: rect.width - 30, height: 45)
    }
    
}
