//
//  GTests.swift
//  GTests
//
//  Created by Eugene on 17.02.2020.
//  Copyright © 2020 Eugene. All rights reserved.
//

import XCTest
@testable import G

class GTests {
    
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
    
    static func cellProviders(count: Int, startId: Int, section: Int = 0) -> [GTCell] {
        var id = startId
        return (0..<count).map({ idx -> GTCell in
            let model = GTCellModel<TestTableCell>.init(model: id)
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
    
    static func iterateGTC(source: GridSource, section: Int, testBlock: (Int, GTCellModel<TestTableCell>) -> Void) {
        for (idx, cell) in source.section(index: section).items.enumerated() {
            let cell = cell as! GTCellModel<TestTableCell>
            testBlock(idx, cell)
        }
    }

}

final class TestTableCell: UITableViewCell, GTCSetupable {
    
    var gtcModel: GTCellModel<TestTableCell>?
    
    func size(in rect: CGRect, model: Int) -> CGSize {
        return .zero
    }
    
    typealias Model = Int
    
    static func createSelf() -> TestTableCell {
        return TestTableCell()
    }
    
    func setup(model: Int) {
        
    }
    
}
