//
//  GTCellModel.swift
//  G
//
//  Created by Eugene on 17.02.2020.
//  Copyright © 2020 Eugene. All rights reserved.
//

import UIKit

// Grid Table Cell
public typealias GTCell = GTCConfigurator & GCIndexPathable

public struct GTCellModel<Modelable: GTCSetupable>: GTCell {
    
    public typealias ModelableModel = Modelable.Model
    
    public var gcIndexPath: GCIndexPath
    public var model: ModelableModel
    
    public var indexPath: IndexPath {
        return gcIndexPath.indexPath
    }
    
    // MARK: - init
    
    public init(model: ModelableModel) {
        
        switch Modelable.self {
        case is UITableViewCell.Type:
            gcIndexPath = .zero(type: .cell, section: 0)
        case is UITableViewHeaderFooterView.Type:
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
        return sizeProvider.size(in: rect, gtcModel: self)
    }
    
    public func configureHeaderFooter(_ headerFooterView: UITableViewHeaderFooterView?) -> UITableViewHeaderFooterView {
        
        guard let headerFooterView = headerFooterView else {
            let headerFooterView = Modelable.createSelf()
            headerFooterView.setup(gtcModel: self)
            return headerFooterView as! UITableViewHeaderFooterView
        }
        
        (headerFooterView as! Modelable).setup(gtcModel: self)
        
        return headerFooterView
    }
    
    public func configureCell(_ tableView: UITableView) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Modelable.className, for: indexPath) as! Modelable
        cell.setup(gtcModel: self)
        
        return cell as! UITableViewCell
    }
    
    public func updateCell(_ cell: UITableViewCell) {
        (cell as! Modelable).setup(gtcModel: self)
    }
    
}
