//
//  GCCSetupableCreator.swift
//  G
//
//  Created by Евгений Орехин on 18.04.2020.
//  Copyright © 2020 Eugene. All rights reserved.
//

import UIKit

public protocol GCCSetupableCreator where Self: UIView {
    
    static func createSelf() -> Self
    static func create<Setupable: GCCSetupable>() -> Setupable
}

public extension GCCSetupableCreator where Self: UICollectionViewCell {
    
    static func create<Setupable: GCCSetupable>() -> Setupable {
        return createSelf() as! Setupable
    }
}

public extension GCCSetupableCreator where Self: UICollectionReusableView {
    
    static func create<Setupable: GCCSetupable>() -> Setupable {
        return createSelf() as! Setupable
    }
}
