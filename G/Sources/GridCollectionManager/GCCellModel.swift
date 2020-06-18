//
//  GCCellModel.swift
//  G
//
//  Created by Евгений Орехин on 18.04.2020.
//  Copyright © 2020 Eugene. All rights reserved.
//

import UIKit

// Grid Collection Cell
public typealias GCCell = GCCConfigurator & GCIndexPathable

public struct GCCellModel<Modelable: GCCSetupable>: GCCell {
    
    public typealias ModelableModel = Modelable.Model
    
    public var gcIndexPath: GCIndexPath
    public var model: ModelableModel
    
    public var indexPath: IndexPath {
        return gcIndexPath.indexPath
    }
    
    // MARK: - init
    
    public init(model: ModelableModel) {
        
        switch Modelable.self {
        case is UICollectionViewCell.Type:
            gcIndexPath = .zero(type: .cell, section: 0)
        case is UICollectionReusableView.Type:
            gcIndexPath = .zero(type: .header, section: 0)
        default:
            fatalError("Modelable must be UITableViewCell or UITableViewHeaderFooterView")
        }
        
        self.model = model
    }
    
    init(indexPath: GCIndexPath, model: ModelableModel) {
        self.gcIndexPath = indexPath
        self.model = model
    }
    
    
    // MARK: - GTCConfigurator
    
    public func size(in rect: CGRect, sizeProvider: GridCellSizeProvider) -> CGSize {
        return sizeProvider.size(in: rect, gccModel: self)
    }
    
    public func configureHeaderFooter(_ collectionView: UICollectionView, kind: String) -> UICollectionReusableView {
        
        let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Modelable.className, for: indexPath) as! Modelable
        cell.setup(gccModel: self)
        
        return cell as! UICollectionReusableView
    }
    
    public func configureCell(_ collectionView: UICollectionView) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Modelable.className, for: indexPath) as! Modelable
        cell.setup(gccModel: self)
        
        return cell as! UICollectionViewCell
    }
    
    public func updateCell(_ cell: UICollectionViewCell) {
        (cell as! Modelable).setup(gccModel: self)
    }
    
}
