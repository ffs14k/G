//
//  GCollectionExampleViewController.swift
//  GExample
//
//  Created by Евгений Орехин on 16.05.2020.
//  Copyright © 2020 Eugene. All rights reserved.
//

import UIKit

final class GCollectionExampleViewController: GCViewController {
    
    var viewModel: GCollectionExampleViewOutput?
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        collectionView.backgroundColor = .white
        collectionView.allowsSelection = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(TitleCollectionCell.self, forCellWithReuseIdentifier: String(describing: TitleCollectionCell.self))
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        viewModel?.viewDidAppear()
    }
    
}
