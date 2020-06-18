//
//  GCViewController.swift
//  GExample
//
//  Created by Евгений Орехин on 16.05.2020.
//  Copyright © 2020 Eugene. All rights reserved.
//

import G
import UIKit

protocol GCPresentable: AnyObject {
    
    var gridManager: GCManagerProtocol { get }
}

class GCViewController: UIViewController, GCPresentable {
    
    // MARK: - GCPresentable
    
    var gridManager: GCManagerProtocol {
        return collectionManager
    }
    
    // MARK: - Public properties
    
    let collectionManager = GCManager()
    var collectionView: UICollectionView!
    
    var flowLayout: UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.sectionHeadersPinToVisibleBounds = true
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        return layout
    }
    
    // MARK: - Init
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        collectionManager.collectionView = collectionView
        collectionView.dataSource = self
        collectionView.delegate = self
        super.viewDidLoad()
    }
    
}


// MARK: - UICollectionViewDataSource
extension GCViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return collectionManager.sectionsCount
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionManager.cellsCount(for: section) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionManager.configureCell(forIndexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard let headerFooter = collectionManager.configureHeaderFooter(forSection: indexPath.section, kind: kind) else {
            return UICollectionReusableView()
        }
        return headerFooter
    }
    
}


// MARK: - UICollectionViewDelegateFlowLayout
extension GCViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return collectionManager.cellSize(forIndexPath: indexPath, in: collectionView.frame)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return collectionManager.headerSize(forSection: section, in: collectionView.frame)
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForFooterInSection section: Int) -> CGSize {
        
        return collectionManager.footerSize(forSection: section, in: collectionView.frame)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        
        collectionManager.willDisplayCell(cell, section: indexPath.section, gridRect: collectionView.frame)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        willDisplaySupplementaryView view: UICollectionReusableView,
                        forElementKind elementKind: String,
                        at indexPath: IndexPath) {
        
        collectionManager.willDisplayHeaderFooter(view, kind: elementKind, section: indexPath.section, gridRect: collectionView.frame)
    }
    
}
