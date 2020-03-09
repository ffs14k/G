//
//  GTCellModel.swift
//  G
//
//  Created by Eugene on 17.02.2020.
//  Copyright © 2020 Eugene. All rights reserved.
//

import UIKit

// Grid Table Cell

public typealias GTManagerCell = GTCConfigurator & GCIndexPathable

public protocol GTCellProvider {
    var gtcModel: GTManagerCell  { get }
}

public struct GTCellModel<Modelable: GTCSetupable>: GTManagerCell {
    
    public typealias ModelableModel = Modelable.Model
    
    public var gcIndexPath: GCIndexPath
    public var model: ModelableModel
    
    public var indexPath: IndexPath {
        return gcIndexPath.indexPath
    }
    
    // MARK: - init
    
    public init(model: ModelableModel) {
        
        if Modelable.self is UITableViewCell.Type {
            gcIndexPath = .zero(type: .cell, section: 0)
        } else if Modelable.self is UITableViewHeaderFooterView.Type {
            gcIndexPath = .zero(type: .header, section: 0)
        } else {
            fatalError("Modelable must be UITableViewCell or UITableViewHeaderFooterView")
        }
        
        self.model = model
    }
    
    init(indexPath: GCIndexPath, model: ModelableModel) {
        self.gcIndexPath = indexPath
        self.model = model
    }
    
    
    // MARK: - GTCConfigurator
    
    public func size(in rect: CGRect, sizeProvider: GTCSizeProvider) -> CGSize {
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
    
    public func updateIndexPath(_ cell: UITableViewCell) {
        (cell as! Modelable).gtcModel!.updateIndexPath(indexPath)
    }
    
}
