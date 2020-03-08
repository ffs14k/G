//
//  GridSection.swift
//  G
//
//  Created by Eugene on 17.02.2020.
//  Copyright © 2020 Eugene. All rights reserved.
//

struct GridSection {
    
    var headerItem: GCIndexPathable?
    var items: [GCIndexPathable]
    var footerItem: GCIndexPathable?
    
}

extension GridSection {
    
    init(header: GTCellProvider? = nil,
         cells: [GTCellProvider] = [],
         footer: GTCellProvider? = nil)
    {
        self.headerItem = header?.gtcModel
        self.items = cells.map({ $0.gtcModel })
        self.footerItem = footer?.gtcModel
    }
    
}
