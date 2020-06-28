//
//  GCollectionExampleViewModel.swift
//  GExample
//
//  Created by Евгений Орехин on 16.05.2020.
//  Copyright © 2020 Eugene. All rights reserved.
//


import G
import UIKit


protocol GCollectionExampleViewOutput {
    
    func viewDidAppear()
}


final class GCollectionExampleViewModel {
    
    
    weak var view: GCPresentable?
    
    private let colorsSet: [UIColor] = [.red, .green, .blue]
    
    // creating cell models, which apply GCManagerProtocol interface
    private func createCells(text: String, indexes: [Int]) -> [GCCell] {
        
        let action: (IndexPath) -> Void = { [weak self] indexPath in
            guard let self = self else { return }
            let newModel = self.createCells(text: "Reloaded at index", indexes: Array((indexPath.item..<indexPath.item + 1)))
            self.view?.gridManager.reloadCells(newModel, section: 0, pattern: .startWithIndex(indexPath.item))
        }
        
        return indexes.map { (index) -> GCCellModel<TitleCollectionCell>  in
            let model = TitleCellModel(title: text + " \(index)", color: randomColor, action: action)
            return TitleCollectionCell.build(model: model)
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


extension GCollectionExampleViewModel: GCollectionExampleViewOutput {
    
    func viewDidAppear() {
        
        let cells = createCells(text: "Created at index", indexes: Array(0..<5))
        let section = GridSection(header: nil, items: cells, footer: nil)
        view?.gridManager.reloadData(section: section, animator: .fade())
        
        testApi(delay: 1) { [weak self] in
            guard let self = self else { return }
            let indexes = [0, 1, 2, 3, 4]
            let cells = self.createCells(text: "Inserted at index", indexes: indexes)
            self.view?.gridManager.insertCells(cells, section: 0, pattern: .matchIndexes(indexes))
        }
        
        testApi(delay: 2) { [weak self] in
            guard let self = self else { return }
            let startIndex = self.view?.gridManager.cellsCount(for: 0) ?? 0
            let cells = self.createCells(text: "Inserted at index", indexes: Array(0..<8))
            self.view?.gridManager.insertCells(cells, section: 0, pattern: .startWithIndex(startIndex))
        }
        
        testApi(delay: 3.5) { [weak self] in
            let indexes = [0, 1, 2, 3, 4, 5, 6, 7, 8, 8, 8]
            self?.view?.gridManager.deleteCells(section: 0, pattern: .matchIndexes(indexes))
        }
        
    }
    
}
