//
//  GTCConfigurator.swift
//  G
//
//  Created by Eugene on 17.02.2020.
//  Copyright © 2020 Eugene. All rights reserved.
//

import UIKit

// Grid Table Cell
protocol GTCConfigurator {
    
    func size(in rect: CGRect, sizeProvider: GTCSizeProvider) -> CGSize
    
    func configureCell(_ tableView: UITableView) -> UITableViewCell
    
    func configureHeaderFooter(_ headerFooterView: UITableViewHeaderFooterView?) -> UITableViewHeaderFooterView
    
}
