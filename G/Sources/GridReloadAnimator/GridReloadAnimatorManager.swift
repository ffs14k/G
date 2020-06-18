//
//  GridReloadAnimatorManager.swift
//  G
//
//  Created by Eugene on 19.02.2020.
//  Copyright © 2020 Eugene. All rights reserved.
//

import UIKit

public protocol GridReloadAnimatorManager: AnyObject {

    var animator: GridReloadAnimator { get }

    func willDisplay(_ cell: UIView, type: GCIndexPath.CellType, section: Int, gridRect: CGRect)
    func handleCellsAnimation(completion: () -> Void)
}

open class GridReloadAnimatorManagerImp: GridReloadAnimatorManager {

    // MARK: - Public Properties
    
    public let animator: GridReloadAnimator
    public let itemDelay: TimeInterval
    
    private(set) public var sections: [Int: Section] = [:]
    private(set) public var gridRect: CGRect = .zero

    // MARK: - Init

    public init(itemDelay: TimeInterval, animator: GridReloadAnimator) {
        self.animator = animator
        self.itemDelay = itemDelay
    }

    // MARK: - Public methods
    
    public func willDisplay(_ cell: UIView, type: GCIndexPath.CellType, section: Int, gridRect: CGRect) {
        
        self.gridRect = gridRect
        
        if sections[section] == nil {
            sections.updateValue(.init(header: nil, cells: [], footer: nil), forKey: section)
        }

        switch type {
        case .cell:
            sections[section]!.cells.append(cell)
            
        case .header:
            sections[section]!.header = cell

        case .footer:
            sections[section]!.footer = cell
        }
        
    }
    
    open func handleCellsAnimation(completion: () -> Void) {
        
        var headerDelay: TimeInterval = 0
        var cellDelay: TimeInterval = 0
        var footerDelay: TimeInterval = 0
        
        for (idx, section) in sections.sorted(by: { $0.key < $1.key }) {
            
            if let header = section.header {
                headerDelay += idx == 0 ? 0 : itemDelay
                cellDelay = headerDelay
                animator.animate(header, delay: headerDelay, gridRect: gridRect)
            }
            
            section.cells.forEach({ cell in
                cellDelay += itemDelay
                animator.animate(cell, delay: cellDelay, gridRect: gridRect)
            })
            
            footerDelay += cellDelay
            if let footer = section.footer {
                footerDelay += itemDelay
                animator.animate(footer, delay: footerDelay, gridRect: gridRect)
            }
            
            headerDelay = footerDelay
        }
        completion()
    }

}

public extension GridReloadAnimatorManagerImp {
    
    struct Section {
        public var header: UIView?
        public var cells: [UIView]
        public var footer: UIView?
    }
    
}
