//
//  GTableExampleViewModel.swift
//  GExample
//
//  Created by Eugene on 08.03.2020.
//  Copyright © 2020 Eugene. All rights reserved.
//

import Foundation
import G
import UIKit

protocol GTableExampleViewModelInput: AnyObject {
    
    func viewIsReady()
    
}

final class GTableExampleViewModel {
    
    weak var view: GTPresentable?
    
    private let colorsSet: [UIColor] = [.red, .green, .blue]
    private var randomColor: UIColor {
        let randomIndex = Int.random(in: (0..<colorsSet.count))
        return colorsSet[randomIndex]
    }
    
    private var cellAction: (IndexPath) -> Void {
        return { [weak self] indexPath in
            guard let self = self else { return }
            let newModel = self.createCells(text: "Reloaded at index", range: (indexPath.item..<indexPath.item + 1))
            self.view?.gridManager.reloadCells(newModel, section: 0, pattern: .startWithIndex(indexPath.item), animation: .fade)
        }
    }
    
    private func createCells(text: String, range: Range<Int>) -> [GTCellProvider] {
        range.map {
            GTableCellModel(title: text + " \($0)", color: randomColor, action: cellAction)
        }
    }

    private func testApi(delay: TimeInterval, block: @escaping() -> Void) {
        Timer.scheduledTimer(withTimeInterval: delay, repeats: false, block: { _ in block() })
    }
    
}


extension GTableExampleViewModel: GTableExampleViewModelInput {
    
    func viewIsReady() {
        let cells = createCells(text: "Created at index", range: (0..<5))
        let sections = GridSection(header: nil, cells: cells, footer: nil)
        view?.gridManager.reloadData(sections: [sections], animator: .bottom())
        
        testApi(delay: 1) { [weak self] in
            guard let self = self else { return }
            let cells = self.createCells(text: "Inserted at index", range: (0..<5))
            self.view?.gridManager.insertCells(cells, section: 0, pattern: .startWithIndex(0), animation: .left)
        }
        
        testApi(delay: 3) { [weak self] in
            guard let self = self else { return }
            let cells = self.createCells(text: "Inserted at index", range: (0..<5))
            self.view?.gridManager.insertCells(cells, section: 0, pattern: .startWithIndex(0), animation: .left)
        }
        
    }
    
}
