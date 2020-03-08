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
    
    private func createCells(range: Range<Int>) -> [GTCellProvider] {
        range.map {
            GTableCellModel(title: "Created at index \($0)", color: randomColor, action: cellAction)
        }
    }
    
    private var cellAction: (IndexPath) -> Void {
        return { [weak self] indexPath in
            guard let self = self else { return }
            let newModel = self.createCells(range: (indexPath.item..<indexPath.item + 1))
            self.view?.gridManager.reloadCells(newModel, section: 0, pattern: .startWithIndex(indexPath.item), animation: .fade)
        }
    }
    
}


extension GTableExampleViewModel: GTableExampleViewModelInput {
    
    func viewIsReady() {
        let cells = createCells(range: (0..<50))
        let sections = GridSection(header: nil, cells: cells, footer: nil)
        view?.gridManager.reloadData(sections: [sections], animator: .bottom())
    }
    
}
