//
//  ClassNameIdentified.swift
//  G
//
//  Created by Eugene on 18.02.2020.
//  Copyright © 2020 Eugene. All rights reserved.
//

import UIKit

protocol ClassNameIdentified {
    
    static var className: String { get }
    
}

extension UIView: ClassNameIdentified {
    
    static var className: String {
        return String(describing: self)
    }
    
}
