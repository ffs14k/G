//
//  GridSourceAppendTests.swift
//  GTests
//
//  Created by Eugene on 07.03.2020.
//  Copyright © 2020 Eugene. All rights reserved.
//

import XCTest
@testable import G

final class GridSourceAppendTests: XCTestCase {
    
    func testAppendItems() {
        
        let gridSource = GridSource()
        
        let test1_cells = GTests.cells(count: 3, startId: 0)
        let test1_ips = test1_cells.enumerated().map({ IndexPath(item: $0.offset, section: 0) })
        
        let test2_cells = GTests.cells(count: 3, startId: 3)
        let test2_ips = test2_cells.enumerated().map({ IndexPath(item: $0.offset + 3, section: 0) })
        
        let test3_cells = GTests.cells(count: 0, startId: 0, section: 1)
        let test3_ips = test3_cells.enumerated().map({ IndexPath(item: $0.offset, section: 1) })
        
        let test31_cells = GTests.cells(count: 10, startId: 0, section: 1)
        let test31_ips = test31_cells.enumerated().map({ IndexPath(item: $0.offset, section: 1) })
        
        
        // Test 1
        let ips1 = gridSource.appendItems(test1_cells, section: 0)
        
        XCTAssertEqual(ips1, test1_ips)
        GTests.iterateCells(source: gridSource, section: 0) { idx, model in
            XCTAssertEqual(idx, model.id)
            XCTAssertEqual(model.gcIndexPath.indexPath, IndexPath(item: idx, section: 0))
        }
        
        // Test 2
        let ips2 = gridSource.appendItems(test2_cells, section: 0)
        
        XCTAssertEqual(ips2, test2_ips)
        GTests.iterateCells(source: gridSource, section: 0) { idx, model in
            XCTAssertEqual(idx, model.id)
            XCTAssertEqual(model.gcIndexPath.indexPath, IndexPath(item: idx, section: 0))
        }
        
        // Test 3
        let ips3 = gridSource.appendItems(test3_cells, section: 1)
        
        XCTAssertEqual(ips3, test3_ips)
        XCTAssertEqual(ips3.count, 0)
        
        // Test 31
        let ips31 = gridSource.appendItems(test31_cells, section: 1)
        
        XCTAssertEqual(ips31, test31_ips)
        GTests.iterateCells(source: gridSource, section: 1) { idx, model in
            XCTAssertEqual(idx, model.id)
            XCTAssertEqual(model.gcIndexPath.indexPath, IndexPath(item: idx, section: 1))
        }
        
        // Test 32
        let ips32 = gridSource.appendItems([], section: 1)
        
        XCTAssertEqual(gridSource.itemsCount(section: 1), test31_cells.count)
        XCTAssertEqual(ips32.count, 0)
        
    }
    
}
