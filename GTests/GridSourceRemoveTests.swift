//
//  GridSourceRemoveTests.swift
//  GTests
//
//  Created by Eugene on 08.03.2020.
//  Copyright © 2020 Eugene. All rights reserved.
//

import XCTest
@testable import G

final class GridSourceRemoveTests: XCTestCase {
    
    func testRemoveSectionsWithMatchIndexes() {
        
        let gridSource = GridSource()
        
        let sections: [GridSection] = [0, 1, 2, 3, 4, 5].map {
            return GridSection(items: GTests.cells(count: 1, startId: $0))
        }
        
        gridSource.reloadData(sections: sections)
        
        let deleteIndexSet = gridSource.deleteSections(pattern: .matchIndexes([0, 1, 2, 5]))
        
        let testDeleteIndexSet = IndexSet(arrayLiteral: 0, 1, 2, 5)
        
        XCTAssertEqual(deleteIndexSet, testDeleteIndexSet)
        XCTAssertEqual((0..<gridSource.sectionsCount), (0..<2))
        
        func testCellId(section: Int, shiftedId: Int) {
            let item = gridSource.item(section: section, item: 0) as! GTests.TestCellModel
            XCTAssertEqual(item.id, shiftedId)
        }
        
        testCellId(section: 0, shiftedId: 3)
        testCellId(section: 1, shiftedId: 4)
    }
    
    func testRemoveSectionsWithStartWithIndex() {
        
        let gridSource = GridSource()
        
        let sections: [GridSection] = [0, 1, 2, 3, 4, 5].map {
            return GridSection(items: GTests.cells(count: 1, startId: $0))
        }
        
        gridSource.reloadData(sections: sections)
        
        let deleteIndexSet = gridSource.deleteSections(pattern: .startWithIndex(3))
        
        let testDeleteIndexSet = IndexSet(arrayLiteral: 3, 4, 5)
        
        XCTAssertEqual(deleteIndexSet, testDeleteIndexSet)
        XCTAssertEqual((0..<gridSource.sectionsCount), (0..<3))
        
        func testCellId(section: Int, shiftedId: Int) {
            let item = gridSource.item(section: section, item: 0) as! GTests.TestCellModel
            XCTAssertEqual(item.id, shiftedId)
        }
        
        testCellId(section: 0, shiftedId: 0)
        testCellId(section: 1, shiftedId: 1)
        testCellId(section: 2, shiftedId: 2)
    }
    
    func testRemoveCellsWithStartWithIndex() {
        
        let gridSource = GridSource()
        let appenCells = GTests.cells(count: 10, startId: 0)
        _ = gridSource.appendItems(appenCells, section: 0)
        
        
        // Test 1
        let remove_ips1 = gridSource.deleteItems(section: 0, pattern: .startWithIndex(5))
        
        XCTAssertEqual(remove_ips1.count, 5)
        GTests.iterateCells(source: gridSource, section: 0) { idx, model in
            XCTAssertEqual(idx, model.id)
            XCTAssertEqual(IndexPath(item: idx, section: 0), model.gcIndexPath.indexPath)
        }
        
        // Test 2
        let remove_ips2 = gridSource.deleteItems(section: 0, pattern: .startWithIndex(5))
        
        XCTAssertEqual(remove_ips2.count, 0)
        
        // Test 3
        let remove_ips3 = gridSource.deleteItems(section: 0, pattern: .startWithIndex(0))
        
        XCTAssertEqual(remove_ips3.count, 5)
        XCTAssertEqual(gridSource.itemsCount(section: 0)!, 0)
        
    }
    
    func testRemoveCellWithMatchIndexes() {
        
        let gridSource = GridSource()
        let appenCells = GTests.cells(count: 10, startId: 0)
        _ = gridSource.appendItems(appenCells, section: 0)
        
        
        // Test 1
        let remove_ips1 = gridSource.deleteItems(section: 0, pattern: .matchIndexes([5, 6, 7, 8, 9]))
        
        XCTAssertEqual(remove_ips1.count, 5)
        XCTAssertEqual(gridSource.itemsCount(section: 0)!, 5)
        GTests.iterateCells(source: gridSource, section: 0) { idx, model in
            XCTAssertEqual(idx, model.id)
            XCTAssertEqual(IndexPath(item: idx, section: 0), model.gcIndexPath.indexPath)
        }
        
        // Test 2
        let remove_ips2 = gridSource.deleteItems(section: 0, pattern: .matchIndexes([5]))
        
        XCTAssertEqual(remove_ips2.count, 0)
        
        // Test 3
        let remove_ips3 = gridSource.deleteItems(section: 0, pattern: .matchIndexes([0, 1, 2, 3, 4]))
        
        XCTAssertEqual(remove_ips3.count, 5)
        XCTAssertEqual(gridSource.itemsCount(section: 0)!, 0)
    }
    
}
