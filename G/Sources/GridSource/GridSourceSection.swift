//
//  GridSection.swift
//  G
//
//  Created by Eugene on 17.02.2020.
//  Copyright © 2020 Eugene. All rights reserved.
//

public struct GridSection {
    
    /// Table / Collection section's header
    var headerItem: GCIndexPathable?
    
    /// Table / Collection section's cells
    var items: [GCIndexPathable]
    
    /// Table / Collection section's footer
    var footerItem: GCIndexPathable?
    
    
    /// Base init for Grid Section
    /// - Parameters:
    ///   - header: Some GCIndexPathable. Probably is `GCCellModel<Modelable: GCCSetupable>` or `GTCellModel<Modelable: GTCSetupable>`
    ///   - items: Some GCIndexPathable. Probably is `GCCellModel<Modelable: GCCSetupable>` or `GTCellModel<Modelable: GTCSetupable>`
    ///   - footer: Some GCIndexPathable. Probably is `GCCellModel<Modelable: GCCSetupable>` or `GTCellModel<Modelable: GTCSetupable>`
    public init(header: GCIndexPathable? = nil,
                items: [GCIndexPathable] = [],
                footer: GCIndexPathable? = nil) {
        self.headerItem = header
        self.items = items
        self.footerItem = footer
    }
    
}
