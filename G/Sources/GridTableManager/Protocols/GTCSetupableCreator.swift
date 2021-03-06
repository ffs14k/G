//
//  GTCSetupableCreator.swift
//  G
//
//  Created by Eugene on 17.02.2020.
//  Copyright © 2020 Eugene. All rights reserved.
//

import UIKit

public protocol GTCSetupableCreator where Self: UIView {
    
    static func createSelf() -> Self
    static func create<Setupable: GTCSetupable>() -> Setupable
}

public extension GTCSetupableCreator where Self: UITableViewCell {
    
    static func create<Setupable: GTCSetupable>() -> Setupable {
        return createSelf() as! Setupable
    }
}

public extension GTCSetupableCreator where Self: UITableViewHeaderFooterView {
    
    static func create<Setupable: GTCSetupable>() -> Setupable {
        return createSelf() as! Setupable
    }
}
