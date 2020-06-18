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
    
    func viewDidAppear()
    
}

final class GTableExampleViewModel {
    
    weak var view: GTPresentable?
    
    private let colorsSet: [UIColor] = [.red, .green, .blue]
    
    // creating cell models, which apply GTManagerProtocol interface
    private func createCells(text: String, indexes: [Int]) -> [GTCell] {
        
        let action: (IndexPath) -> Void = { [weak self] indexPath in
            guard let self = self else { return }
            let newModel = self.createCells(text: "Reloaded at index", indexes: Array((indexPath.item..<indexPath.item + 1)))
            self.view?.gridManager.reloadCells(newModel, section: 0, pattern: .startWithIndex(indexPath.item), animation: .fade)
        }
        
        return indexes.map { (index) -> GTCellModel<TitleTableCell>  in
            let model = TitleCellModel(title: text + " \(index)", color: randomColor, action: action)
            return TitleTableCell.build(model: model)
        }
    }
    
    private func testApi(delay: TimeInterval, block: @escaping() -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: block)
    }
    
    private var randomColor: UIColor {
        let randomIndex = Int.random(in: (0..<colorsSet.count))
        return colorsSet[randomIndex]
    }
    
}


extension GTableExampleViewModel: GTableExampleViewModelInput {
    
    func viewDidAppear() {
        
        let cells = createCells(text: "Created at index", indexes: Array(0..<6))
        let section = GridSection(header: nil, items: cells, footer: nil)
        view?.gridManager.reloadData(section: section, animator: .bottom())
        
        testApi(delay: 1) { [weak self] in
            guard let self = self else { return }
            let indexes = [0, 2]
            let cells = self.createCells(text: "Inserted at index", indexes: indexes)
            self.view?.gridManager.insertCells(cells, section: 0, pattern: .matchIndexes(indexes), animation: .left)
        }
        
        testApi(delay: 2.5) { [weak self] in
            guard let self = self else { return }
            let startIndex = self.view?.gridManager.cellsCount(for: 0) ?? 0
            let cells = self.createCells(text: "Inserted at index", indexes: Array(startIndex - 3..<startIndex))
            self.view?.gridManager.insertCells(cells, section: 0, pattern: .startWithIndex(startIndex), animation: .left)
        }
        
        testApi(delay: 4) { [weak self] in
//            #warning("Here is a !* mysterious *! crash. `Undefined` behaviour of UITableViewDatatSource")
//            let indexes = [0, 1, 2, 3, 4, 5, 6, 7, 8]
//            let indexes = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13]
            
//            let indexes = [4]
//            self?.view?.gridManager.deleteCells(section: 0, pattern: .matchIndexes(indexes), animation: .left)
        }
    }
    
}
