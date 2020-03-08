//
//  GTests.swift
//  GTests
//
//  Created by Eugene on 17.02.2020.
//  Copyright © 2020 Eugene. All rights reserved.
//

import XCTest
@testable import G

class GTests: XCTestCase {
    
    struct TestCellModel: GCIndexPathable, Equatable {
        
        let id: Int
        var gcIndexPath: GCIndexPath
        
    }
    
    static func cells(count: Int, startId: Int, section: Int = 0) -> [TestCellModel] {
        var id = startId
        return (0..<count).map({ idx -> TestCellModel in
            let model = TestCellModel(id: id, gcIndexPath: .zero(type: .cell, section: section))
            id += 1
            return model
        })
    }
    
    
    static func iterateCells(source: GridSource, section: Int, testBlock: (Int, TestCellModel) -> Void) {
        for (idx, cell) in source.section(index: section).items.enumerated() {
            let cell = cell as! TestCellModel
            testBlock(idx, cell)
        }
    }
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
