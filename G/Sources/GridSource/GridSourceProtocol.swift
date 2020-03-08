//
//  GridSourceProtocol.swift
//  G
//
//  Created by Eugene on 17.02.2020.
//  Copyright © 2020 Eugene. All rights reserved.
//

import Foundation

public protocol GridSourceProtocol: AnyObject {
    
    var sectionsCount: Int { get }
    
    func itemsCount(section: Int) -> Int?
    
    func section(index: Int) -> GridSection
    
    func headerItem(section: Int) -> GCIndexPathable?
    
    func footerItem(section: Int) -> GCIndexPathable?
    
    func items(section: Int) -> [GCIndexPathable]
    
    func item(section: Int, item: Int) -> GCIndexPathable
    
    func reloadData(sections: [GridSection])
    
    func appendSections(_ sections: [GridSection]) -> Range<Int>
    
//    TODO
//    func insertSections(_ sections: [GridSection], pattern: GridSourceMatchPattern) -> (insert: [Int], reload: [Int])
    
//    TODO
//    func reloadSections(_ sections: GridSection, pattern: GridSourceMatchPattern) -> [Int]

//    TODO
//    func deleteSection(pattern: GridSourceMatchPattern) -> (delete: [Int], reload: [Int])
    
    func appendItems(_ items: [GCIndexPathable], section: Int) -> [IndexPath]
    
    func insertItems(_ items: [GCIndexPathable],
                     section: Int,
                     pattern: GridSourceMatchPattern) -> [IndexPath]
    
    func reloadItems(_ items: [GCIndexPathable],
                     section: Int,
                     pattern: GridSourceMatchPattern) -> [IndexPath]
    
    func deleteItems(section: Int,
                     pattern: GridSourceMatchPattern) -> [IndexPath]
    
    func updateHeader(_ headerItem: GCIndexPathable, atSection section: Int)
    
    func updateFooter(_ footerItem: GCIndexPathable, atSection section: Int)
    
}

public enum GridSourceMatchPattern {
    
    case startWithIndex(_ index: Int)
    case matchIndexes(_ indexes: [Int])
    
}
