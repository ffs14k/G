//
//  GridSource.swift
//  G
//
//  Created by Eugene on 17.02.2020.
//  Copyright © 2020 Eugene. All rights reserved.
//

import Foundation

public final class GridSource: GridSourceProtocol {
    
    private var sections: [Int: GridSection] = [:]
    
    public init() { }
}


// MARK: - Getter
public extension GridSource {
    
    var sectionsCount: Int {
        return sections.count
    }
    
    func itemsCount(section: Int) -> Int? {
        return sections[section]?.items.count
    }
    
    func section(index: Int) -> GridSection {
        return sections[index]!
    }
    
    func items(section: Int) -> [GCIndexPathable] {
        return sections[section]!.items
    }
    
    func headerItem(section: Int) -> GCIndexPathable? {
        return sections[section]!.headerItem
    }
    
    func footerItem(section: Int) -> GCIndexPathable? {
        return sections[section]!.footerItem
    }
    
    func item(section: Int, item: Int) -> GCIndexPathable {
        return sections[section]!.items[item]
    }
}


// MARK: - Section setter
public extension GridSource {
    
    func reloadData(sections: [GridSection]) {
        self.sections.removeAll()
        _ = appendSections(sections)
    }
    
    func appendSections(_ sections: [GridSection]) -> IndexSet {
        let appendRange = (self.sections.count..<self.sections.count + sections.count)
        sections.forEach({
            let section = GridSection(section: $0, index: self.sections.count)
            self.sections.updateValue(section, forKey: self.sections.count)
        })
        return IndexSet(integersIn: appendRange)
    }
    
    func insertSections(_ sections: [GridSection], pattern: GridSourceMatchPattern) -> IndexSet {
        
        let newSectionsCount = self.sections.count + sections.count
        let insertIndexes: [Int]
        
        switch pattern {
        case .startWithIndex(let index):
            insertIndexes = Array((index..<index + sections.count))
            
        case .matchIndexes(let indexes):
            insertIndexes = indexes
        }
        
        var buffer: [Int: GridSection] = [:]
        buffer.reserveCapacity(newSectionsCount)
        
        let insertItems = createIndexesSections(sections: sections, indexes: insertIndexes)
        var storageSectionIndex = 0
        var minInsertIndex = self.sections.count
        
        for i in (0..<newSectionsCount) {
            if let insertItem = insertItems[i] {
                buffer.updateValue(insertItem, forKey: i)
                if i < minInsertIndex { minInsertIndex = i }
            } else {
                buffer.updateValue(self.sections[storageSectionIndex]!, forKey: i)
                storageSectionIndex += 1
            }
        }
        
        self.sections = buffer
        
        updateSectionsIndexPaths(startWithIndex: minInsertIndex)
        
        return IndexSet(insertIndexes)
    }
    
    func updateHeader(_ headerItem: GCIndexPathable, atSection section: Int) {
        setEmpySectionIfNeeded(index: section)
        sections[section]!.headerItem = headerItem
    }
    
    func updateFooter(_ footerItem: GCIndexPathable, atSection section: Int) {
        setEmpySectionIfNeeded(index: section)
        sections[section]!.footerItem = footerItem
    }
}


// MARK: - Items setter
public extension GridSource {
    
    func appendItems(_ items: [GCIndexPathable], section: Int) -> [IndexPath] {
        
        setEmpySectionIfNeeded(index: section)
        
        let itemsCount = sections[section]!.items.count
        
        var newItemsBuffer: [GCIndexPathable] = []
        newItemsBuffer.reserveCapacity(items.count)
        
        let appendDiff = (itemsCount..<itemsCount + items.count).enumerated().map { idx, itemPosition -> IndexPath in
            let indexPath = IndexPath(item: itemPosition, section: section)
            let updatedItem = items[idx].copy(type: .cell, newIndexPath: indexPath)
            newItemsBuffer.append(updatedItem)
            return indexPath
        }
        
        sections[section]!.items.append(contentsOf: newItemsBuffer)
        return appendDiff
    }
    
    func insertItems(_ items: [GCIndexPathable], section: Int, pattern: GridSourceMatchPattern) -> [IndexPath] {
        
        setEmpySectionIfNeeded(index: section)
        
        let itemsCount = sections[section]!.items.count
        let newItemsCount = itemsCount + items.count
        
        guard itemsCount > 0 else {
            let insert = appendItems(items, section: section)
            return insert
        }
        
        let insertIndexPaths: [IndexPath]
        
        switch pattern {
        case .startWithIndex(let index):
            sections[section]!.items.insert(contentsOf: items, at: index)
            insertIndexPaths = (index..<index + items.count).map({ IndexPath(item: $0, section: section) })
            
        case .matchIndexes(let indexes):
            
            var buffer: [GCIndexPathable] = []
            buffer.reserveCapacity(newItemsCount)
            
            let insertItems = createIndexedItems(items: items, indexes: indexes)
            var itemsIndex = 0
            
            for i in (0..<newItemsCount) {
                
                if let insertItem = insertItems[i] {
                    buffer.append(insertItem)
                } else {
                    buffer.append(sections[section]!.items[itemsIndex])
                    itemsIndex += 1
                }
                
            }
            
            sections[section]!.items = buffer
            
            insertIndexPaths = IndexSet(indexes).map({ IndexPath(item: $0, section: section) })
        }
        
        (insertIndexPaths[0].item..<sections[section]!.items.count).forEach({
            let updatedItem = sections[section]!.items[$0].copy(type: .cell, newIndexPath: IndexPath(item: $0, section: 0))
            sections[section]!.items[$0] = updatedItem
        })
        
        return insertIndexPaths
    }
    
    func reloadItems(_ items: [GCIndexPathable],
                     section: Int,
                     pattern: GridSourceMatchPattern) -> [IndexPath] {
        
        let reloadIndexes: [Int]
        
        switch pattern {
        case let .startWithIndex(index):
            reloadIndexes = Array(index..<index + items.count)
            
        case let .matchIndexes(indexes):
            reloadIndexes = indexes
        }
        
        var reloadIndexPaths: [IndexPath] = []
        reloadIndexPaths.reserveCapacity(items.count)
        
        reloadIndexes.enumerated().forEach { idx, reloadIndex in
            let indexPath = IndexPath(item: reloadIndex, section: section)
            let newItem = items[idx].copy(type: .cell, newIndexPath: indexPath)
            sections[section]!.items[reloadIndex] = newItem
            reloadIndexPaths.append(indexPath)
        }
        
        return reloadIndexPaths
    }
    
    
    func deleteItems(section: Int, pattern: GridSourceMatchPattern) -> [IndexPath] {
        
        let itemsCount = sections[section]!.items.count
        var removeIndexPaths: [IndexPath] = []
        
        switch pattern {
        case .startWithIndex(let index):
            let removeRange = (index..<itemsCount)
            removeIndexPaths = removeRange.map({ IndexPath(item: $0, section: section) })
            sections[section]!.items.removeSubrange(removeRange)
            
        case .matchIndexes(let indexes):
            
            removeIndexPaths.reserveCapacity(indexes.count)
            
            let removeIndexedIndexes = Dictionary(uniqueKeysWithValues: Set(indexes).lazy.map({ ($0, $0) }))
            
            var buffer: [GCIndexPathable] = []
            buffer.reserveCapacity(itemsCount - indexes.count)
            
            var itemsIndex = 0
            
            (0..<itemsCount).forEach {
                
                guard removeIndexedIndexes[$0] == nil else {
                    removeIndexPaths.append(IndexPath(item: $0, section: section))
                    itemsIndex += 1
                    return
                }
                
                buffer.append(sections[section]!.items[itemsIndex])
                itemsIndex += 1
            }
            
            sections[section]!.items = buffer
        }
        
        return removeIndexPaths
    }
}


// MARK: - Private methods
private extension GridSource {
    
    func setEmpySectionIfNeeded(index: Int) {
        guard sections[index] == nil else { return }
        let emptySection = GridSection(header: nil, items: [], footer: nil)
        sections.updateValue(emptySection, forKey: index)
    }
    
    func createIndexedItems(items: [GCIndexPathable], indexes: [Int]) -> [Int: GCIndexPathable] {
        var dict: [Int: GCIndexPathable] = [:]
        dict.reserveCapacity(indexes.count)
        indexes.enumerated().forEach({
            dict.updateValue(items[$0], forKey: $1)
        })
        return dict
    }
    
    func createIndexesSections(sections: [GridSection], indexes: [Int]) -> [Int: GridSection] {
        var dict: [Int: GridSection] = [:]
        dict.reserveCapacity(indexes.count)
        indexes.enumerated().forEach({
            dict.updateValue(sections[$0], forKey: $1)
        })
        return dict
    }
    
    func updateSectionsIndexPaths(startWithIndex index: Int) {
        (index..<sections.count).forEach {
            let updatedSection = GridSection(section: sections[$0]!, index: $0)
            sections.updateValue(updatedSection, forKey: $0)
        }
    }
}


fileprivate extension GridSection {
    
    init(section: GridSection, index: Int) {
        headerItem = section.headerItem?.copy(type: .header, newIndexPath: IndexPath(item: 0, section: index))
        footerItem = section.footerItem?.copy(type: .footer, newIndexPath: IndexPath(item: 0, section: index))
        items = section.items
            .enumerated()
            .map({ $1.copy(type: .cell, newIndexPath: IndexPath(item: $0, section: index)) })
    }
}
