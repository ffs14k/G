//
//  GridSourceReloadTests.swift
//  GTests
//
//  Created by Eugene on 08.03.2020.
//  Copyright © 2020 Eugene. All rights reserved.
//

import XCTest
@testable import G

final class GridSourceReloadTests: XCTestCase {
    
    func testReloadStartWithIndexItems() {
        
        let gridSource = GridSource()
        
        let test1_reload_cells = GTests.cells(count: 0, startId: 0)
        
        let test_append_items = GTests.cells(count: 5, startId: 0)
        
        let test2_reloadIndex = 2
        let test2_reload_cells = GTests.cells(count: 3, startId: 222)
        let test2_cells = [
            GTests.TestCellModel(id: 0, gcIndexPath: GCIndexPath(cellType: .cell, indexPath: IndexPath(item: 0, section: 0))),
            GTests.TestCellModel(id: 1, gcIndexPath: GCIndexPath(cellType: .cell, indexPath: IndexPath(item: 1, section: 0))),
            GTests.TestCellModel(id: 222, gcIndexPath: GCIndexPath(cellType: .cell, indexPath: IndexPath(item: 2, section: 0))),
            GTests.TestCellModel(id: 223, gcIndexPath: GCIndexPath(cellType: .cell, indexPath: IndexPath(item: 3, section: 0))),
            GTests.TestCellModel(id: 224, gcIndexPath: GCIndexPath(cellType: .cell, indexPath: IndexPath(item: 4, section: 0)))
        ]
        
        let test3_reloadIndex = 0
        let test3_reload_cells = GTests.cells(count: 5, startId: 333)
        let test3_cells = [
            GTests.TestCellModel(id: 333, gcIndexPath: GCIndexPath(cellType: .cell, indexPath: IndexPath(item: 0, section: 0))),
            GTests.TestCellModel(id: 334, gcIndexPath: GCIndexPath(cellType: .cell, indexPath: IndexPath(item: 1, section: 0))),
            GTests.TestCellModel(id: 335, gcIndexPath: GCIndexPath(cellType: .cell, indexPath: IndexPath(item: 2, section: 0))),
            GTests.TestCellModel(id: 336, gcIndexPath: GCIndexPath(cellType: .cell, indexPath: IndexPath(item: 3, section: 0))),
            GTests.TestCellModel(id: 337, gcIndexPath: GCIndexPath(cellType: .cell, indexPath: IndexPath(item: 4, section: 0)))
        ]
        
        
        // Test 1 (0 items reloaded in empty source)
        let reload_ips1 = gridSource.reloadItems(test1_reload_cells, section: 0, pattern: .startWithIndex(0))
        
        XCTAssertEqual(gridSource.itemsCount(section: 0), nil)
        XCTAssertEqual(reload_ips1.count, 0)
        
        
        // Append 5 Items
        _ = gridSource.appendItems(test_append_items, section: 0)
        // End Append
        
        
        // Test 2 (3 items reloaded)
        let reload_ips2 = gridSource.reloadItems(test2_reload_cells, section: 0, pattern: .startWithIndex(test2_reloadIndex))
        
        XCTAssertEqual(gridSource.itemsCount(section: 0), 5)
        XCTAssertEqual(reload_ips2.count, test2_reload_cells.count)
        XCTAssertEqual(test2_cells, (gridSource.items(section: 0) as! [GTests.TestCellModel]))
        
        
        // Test 3 (5 items reloaded)
        let reload_ips3 = gridSource.reloadItems(test3_reload_cells, section: 0, pattern: .startWithIndex(test3_reloadIndex))
        
        XCTAssertEqual(gridSource.itemsCount(section: 0)!, 5)
        XCTAssertEqual(reload_ips3.count, 5)
        XCTAssertEqual(test3_cells, (gridSource.items(section: 0) as! [GTests.TestCellModel]))
        
    }
    
    func testReloadMatchIndexesItems() {
        
        let gridSource = GridSource()
        
        let test1_reload_cells = GTests.cells(count: 0, startId: 0)
        
        let test_append_items = GTests.cells(count: 5, startId: 0)
        
        let test2_reloadIndexes = [2, 3, 4]
        let test2_reload_cells = GTests.cells(count: 3, startId: 222)
        let test2_cells = [
            GTests.TestCellModel(id: 0, gcIndexPath: GCIndexPath(cellType: .cell, indexPath: IndexPath(item: 0, section: 0))),
            GTests.TestCellModel(id: 1, gcIndexPath: GCIndexPath(cellType: .cell, indexPath: IndexPath(item: 1, section: 0))),
            GTests.TestCellModel(id: 222, gcIndexPath: GCIndexPath(cellType: .cell, indexPath: IndexPath(item: 2, section: 0))),
            GTests.TestCellModel(id: 223, gcIndexPath: GCIndexPath(cellType: .cell, indexPath: IndexPath(item: 3, section: 0))),
            GTests.TestCellModel(id: 224, gcIndexPath: GCIndexPath(cellType: .cell, indexPath: IndexPath(item: 4, section: 0)))
        ]
        
        let test3_reloadIndexes = [0, 1, 2, 3, 4]
        let test3_reload_cells = GTests.cells(count: 5, startId: 333)
        let test3_cells = [
            GTests.TestCellModel(id: 333, gcIndexPath: GCIndexPath(cellType: .cell, indexPath: IndexPath(item: 0, section: 0))),
            GTests.TestCellModel(id: 334, gcIndexPath: GCIndexPath(cellType: .cell, indexPath: IndexPath(item: 1, section: 0))),
            GTests.TestCellModel(id: 335, gcIndexPath: GCIndexPath(cellType: .cell, indexPath: IndexPath(item: 2, section: 0))),
            GTests.TestCellModel(id: 336, gcIndexPath: GCIndexPath(cellType: .cell, indexPath: IndexPath(item: 3, section: 0))),
            GTests.TestCellModel(id: 337, gcIndexPath: GCIndexPath(cellType: .cell, indexPath: IndexPath(item: 4, section: 0)))
        ]
        
        
        // Test 1 (0 items reloaded in empty source)
        let reload_ips1 = gridSource.reloadItems(test1_reload_cells, section: 0, pattern: .startWithIndex(0))
        
        XCTAssertEqual(gridSource.itemsCount(section: 0), nil)
        XCTAssertEqual(reload_ips1.count, 0)
        
        
        // Append 5 Items
        _ = gridSource.appendItems(test_append_items, section: 0)
        // End Append
        
        
        // Test 2 (3 items reloaded)
        let reload_ips2 = gridSource.reloadItems(test2_reload_cells, section: 0, pattern: .matchIndexes(test2_reloadIndexes))
        
        XCTAssertEqual(gridSource.itemsCount(section: 0), 5)
        XCTAssertEqual(reload_ips2.count, test2_reload_cells.count)
        XCTAssertEqual(test2_cells, (gridSource.items(section: 0) as! [GTests.TestCellModel]))
        
        
        // Test 3 (5 items reloaded)
        let reload_ips3 = gridSource.reloadItems(test3_reload_cells, section: 0, pattern: .matchIndexes(test3_reloadIndexes))
        
        XCTAssertEqual(gridSource.itemsCount(section: 0)!, 5)
        XCTAssertEqual(reload_ips3.count, 5)
        XCTAssertEqual(test3_cells, (gridSource.items(section: 0) as! [GTests.TestCellModel]))
        
    }
    
    
}
