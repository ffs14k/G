//
//  GridSourceInsertTests.swift
//  GTests
//
//  Created by Eugene on 07.03.2020.
//  Copyright © 2020 Eugene. All rights reserved.
//

import XCTest
@testable import G

final class GridSourceInsertTests: XCTestCase {
    
    func testInsertStartWithIndexItems() {
        
        let gridSource = GridSource()
        
        let test1_insert_cells = GTests.cells(count: 5, startId: 0)
        let test1_ips = test1_insert_cells.enumerated().map({ IndexPath(item: $0.offset, section: 0) })
        
        let test2_insert_cells = GTests.cells(count: 3, startId: 222)
        let test2_cells = [
            GTests.TestCellModel(id: 222, gcIndexPath: GCIndexPath(cellType: .cell, indexPath: IndexPath(item: 0, section: 0))),
            GTests.TestCellModel(id: 223, gcIndexPath: GCIndexPath(cellType: .cell, indexPath: IndexPath(item: 1, section: 0))),
            GTests.TestCellModel(id: 224, gcIndexPath: GCIndexPath(cellType: .cell, indexPath: IndexPath(item: 2, section: 0))),
            GTests.TestCellModel(id: 0, gcIndexPath: GCIndexPath(cellType: .cell, indexPath: IndexPath(item: 3, section: 0))),
            GTests.TestCellModel(id: 1, gcIndexPath: GCIndexPath(cellType: .cell, indexPath: IndexPath(item: 4, section: 0))),
            GTests.TestCellModel(id: 2, gcIndexPath: GCIndexPath(cellType: .cell, indexPath: IndexPath(item: 5, section: 0))),
            GTests.TestCellModel(id: 3, gcIndexPath: GCIndexPath(cellType: .cell, indexPath: IndexPath(item: 6, section: 0))),
            GTests.TestCellModel(id: 4, gcIndexPath: GCIndexPath(cellType: .cell, indexPath: IndexPath(item: 7, section: 0)))
        ]
        
        let test2_ips = (test2_insert_cells).enumerated().map({ IndexPath(item: $0.offset, section: 0) })
        
        let test3_insert_cells = GTests.cells(count: 3, startId: 333)
        let test3_cells = [
            GTests.TestCellModel(id: 222, gcIndexPath: GCIndexPath(cellType: .cell, indexPath: IndexPath(item: 0, section: 0))),
            GTests.TestCellModel(id: 223, gcIndexPath: GCIndexPath(cellType: .cell, indexPath: IndexPath(item: 1, section: 0))),
            GTests.TestCellModel(id: 224, gcIndexPath: GCIndexPath(cellType: .cell, indexPath: IndexPath(item: 2, section: 0))),
            GTests.TestCellModel(id: 0, gcIndexPath: GCIndexPath(cellType: .cell, indexPath: IndexPath(item: 3, section: 0))),
            GTests.TestCellModel(id: 333, gcIndexPath: GCIndexPath(cellType: .cell, indexPath: IndexPath(item: 4, section: 0))),
            GTests.TestCellModel(id: 334, gcIndexPath: GCIndexPath(cellType: .cell, indexPath: IndexPath(item: 5, section: 0))),
            GTests.TestCellModel(id: 335, gcIndexPath: GCIndexPath(cellType: .cell, indexPath: IndexPath(item: 6, section: 0))),
            GTests.TestCellModel(id: 1, gcIndexPath: GCIndexPath(cellType: .cell, indexPath: IndexPath(item: 7, section: 0))),
            GTests.TestCellModel(id: 2, gcIndexPath: GCIndexPath(cellType: .cell, indexPath: IndexPath(item: 8, section: 0))),
            GTests.TestCellModel(id: 3, gcIndexPath: GCIndexPath(cellType: .cell, indexPath: IndexPath(item: 9, section: 0))),
            GTests.TestCellModel(id: 4, gcIndexPath: GCIndexPath(cellType: .cell, indexPath: IndexPath(item: 10, section: 0)))
        ]
        
        let test3_ips = (test3_insert_cells).enumerated().map({ IndexPath(item: $0.offset + 4, section: 0) })
        
        // Test 1
        let ips1 = gridSource.insertItems(test1_insert_cells, section: 0, pattern: .startWithIndex(0))
        
        XCTAssertEqual(test1_ips, ips1)
        
        GTests.iterateCells(source: gridSource, section: 0) { idx, model in
            XCTAssertEqual(idx, model.id)
            XCTAssertEqual(model.gcIndexPath.indexPath, IndexPath(item: idx, section: 0))
        }
        
        // Test 2
        let ips2 = gridSource.insertItems(test2_insert_cells, section: 0, pattern: .startWithIndex(0))
        
        XCTAssertEqual(test2_ips, ips2)
        XCTAssertEqual(test2_cells, (gridSource.items(section: 0) as! [GTests.TestCellModel]))
        
        GTests.iterateCells(source: gridSource, section: 0) { idx, model in
            XCTAssertEqual(model.gcIndexPath.indexPath, IndexPath(item: idx, section: 0))
        }
        
        // Test 3
        let ips3 = gridSource.insertItems(test3_insert_cells, section: 0, pattern: .startWithIndex(4))
        
        XCTAssertEqual(test3_ips, ips3)
        XCTAssertEqual(test3_cells, (gridSource.items(section: 0) as! [GTests.TestCellModel]))
        
        GTests.iterateCells(source: gridSource, section: 0) { idx, model in
            XCTAssertEqual(model.gcIndexPath.indexPath, IndexPath(item: idx, section: 0))
        }
        
    }
    
    func testInsertMatchIndexesItems() {
        
        let gridSource = GridSource()
        
        let test1_insertIndexes = [0, 1, 2, 3, 4, 5]
        let test1_insert_cells = GTests.cells(count: 5, startId: 0)
        let test1_ips = test1_insert_cells.enumerated().map({ IndexPath(item: $0.offset, section: 0) })
        
        let test2_insertIndexes = [1, 3, 7]
        let test2_insert_cells = GTests.cells(count: 3, startId: 222)
        let test2_cells = [
            GTests.TestCellModel(id: 0, gcIndexPath: GCIndexPath(cellType: .cell, indexPath: IndexPath(item: 0, section: 0))),
            GTests.TestCellModel(id: 222, gcIndexPath: GCIndexPath(cellType: .cell, indexPath: IndexPath(item: 1, section: 0))),
            GTests.TestCellModel(id: 1, gcIndexPath: GCIndexPath(cellType: .cell, indexPath: IndexPath(item: 2, section: 0))),
            GTests.TestCellModel(id: 223, gcIndexPath: GCIndexPath(cellType: .cell, indexPath: IndexPath(item: 3, section: 0))),
            GTests.TestCellModel(id: 2, gcIndexPath: GCIndexPath(cellType: .cell, indexPath: IndexPath(item: 4, section: 0))),
            GTests.TestCellModel(id: 3, gcIndexPath: GCIndexPath(cellType: .cell, indexPath: IndexPath(item: 5, section: 0))),
            GTests.TestCellModel(id: 4, gcIndexPath: GCIndexPath(cellType: .cell, indexPath: IndexPath(item: 6, section: 0))),
            GTests.TestCellModel(id: 224, gcIndexPath: GCIndexPath(cellType: .cell, indexPath: IndexPath(item: 7, section: 0)))
        ]
        
        let test2_ips = [
            IndexPath(item: 1, section: 0),
            IndexPath(item: 3, section: 0),
            IndexPath(item: 7, section: 0),
        ]
        
        let test3_insertIndexes = [6, 0, 5]
        let test3_insert_cells = GTests.cells(count: 3, startId: 333)
        let test3_cells = [
            GTests.TestCellModel(id: 334, gcIndexPath: GCIndexPath(cellType: .cell, indexPath: IndexPath(item: 0, section: 0))),
            GTests.TestCellModel(id: 0, gcIndexPath: GCIndexPath(cellType: .cell, indexPath: IndexPath(item: 1, section: 0))),
            GTests.TestCellModel(id: 222, gcIndexPath: GCIndexPath(cellType: .cell, indexPath: IndexPath(item: 2, section: 0))),
            GTests.TestCellModel(id: 1, gcIndexPath: GCIndexPath(cellType: .cell, indexPath: IndexPath(item: 3, section: 0))),
            GTests.TestCellModel(id: 223, gcIndexPath: GCIndexPath(cellType: .cell, indexPath: IndexPath(item: 4, section: 0))),
            GTests.TestCellModel(id: 335, gcIndexPath: GCIndexPath(cellType: .cell, indexPath: IndexPath(item: 5, section: 0))),
            GTests.TestCellModel(id: 333, gcIndexPath: GCIndexPath(cellType: .cell, indexPath: IndexPath(item: 6, section: 0))),
            GTests.TestCellModel(id: 2, gcIndexPath: GCIndexPath(cellType: .cell, indexPath: IndexPath(item: 7, section: 0))),
            GTests.TestCellModel(id: 3, gcIndexPath: GCIndexPath(cellType: .cell, indexPath: IndexPath(item: 8, section: 0))),
            GTests.TestCellModel(id: 4, gcIndexPath: GCIndexPath(cellType: .cell, indexPath: IndexPath(item: 9, section: 0))),
            GTests.TestCellModel(id: 224, gcIndexPath: GCIndexPath(cellType: .cell, indexPath: IndexPath(item: 10, section: 0)))
        ]
        
        let test3_ips = [
            IndexPath(item: 0, section: 0),
            IndexPath(item: 5, section: 0),
            IndexPath(item: 6, section: 0),
        ]
        
        
        // Test 1
        let ips1 = gridSource.insertItems(test1_insert_cells, section: 0, pattern: .matchIndexes(test1_insertIndexes))
        XCTAssertEqual(test1_ips, ips1)
        
        GTests.iterateCells(source: gridSource, section: 0) { idx, model in
            XCTAssertEqual(idx, model.id)
            XCTAssertEqual(model.gcIndexPath.indexPath, IndexPath(item: idx, section: 0))
        }
        
        // Test 2
        let ips2 = gridSource.insertItems(test2_insert_cells, section: 0, pattern: .matchIndexes(test2_insertIndexes))
        
        XCTAssertEqual(test2_ips, ips2)
        XCTAssertEqual(test2_cells, (gridSource.items(section: 0) as! [GTests.TestCellModel]))
        
        GTests.iterateCells(source: gridSource, section: 0) { idx, model in
            XCTAssertEqual(model.gcIndexPath.indexPath, IndexPath(item: idx, section: 0))
        }
        
        // Test 3
        let ips3 = gridSource.insertItems(test3_insert_cells, section: 0, pattern: .matchIndexes(test3_insertIndexes))
        
        XCTAssertEqual(test3_ips, ips3)
        XCTAssertEqual(test3_cells, (gridSource.items(section: 0) as! [GTests.TestCellModel]))
        
        GTests.iterateCells(source: gridSource, section: 0) { idx, model in
            XCTAssertEqual(model.gcIndexPath.indexPath, IndexPath(item: idx, section: 0))
        }
        
    }
    
    
}
