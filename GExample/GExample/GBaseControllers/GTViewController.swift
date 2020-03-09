//
//  GTViewController.swift
//  GExample
//
//  Created by Eugene on 08.03.2020.
//  Copyright © 2020 Eugene. All rights reserved.
//

import UIKit
import G

public protocol GTPresentable: AnyObject {
    var gridManager: GTManagerProtocol { get }
}

class GTViewController: UIViewController, GTPresentable {
    
    // MARK: - GTPresentable
    
    var gridManager: GTManagerProtocol {
        return tableManager
    }
    
    // MARK: - Properties
    
    let tableManager = GTManager()
    
    // MARK: - Subviews
    
    let tableView = UITableView()
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableManager.tableView = tableView
        tableView.dataSource = self
        tableView.delegate = self
    }
    
}


// MARK: - UITableViewDataSource
extension GTViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableManager.sectionsCount
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableManager.cellsCount(for: section)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableManager.configureCell(forIndexPath: indexPath)
    }
    
}


// MARK: - UITableViewDelegate
extension GTViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return tableManager.configureHeader(forSection: section)
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return tableManager.configureFooter(forSection: section)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableManager.cellSize(forIndexPath: indexPath, in: view.frame).height
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return tableManager.headerSize(forSection: section, in: view.frame).height
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return tableManager.footerSize(forSection: section, in: view.frame).height
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        tableManager.willDisplayCell(cell, section: indexPath.section, gridRect: tableView.frame)
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        tableManager.willDisplayHeader(view, section: section, gridRect: tableView.frame)
    }
    
    func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        tableManager.willDisplayFooter(view, section: section, gridRect: tableView.frame)
    }
    
}
