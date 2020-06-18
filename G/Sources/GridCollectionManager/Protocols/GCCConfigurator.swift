//
//  GCCConfigurator.swift
//  G
//
//  Created by Евгений Орехин on 18.04.2020.
//  Copyright © 2020 Eugene. All rights reserved.
//

import UIKit

// Grid Table Cell
public protocol GCCConfigurator {
    
    func size(in rect: CGRect, sizeProvider: GridCellSizeProvider) -> CGSize
    
    func configureCell(_ collectionView: UICollectionView) -> UICollectionViewCell
    
    func configureHeaderFooter(_ collectionView: UICollectionView, kind: String) -> UICollectionReusableView
    
    func updateCell(_ cell: UICollectionViewCell)
}
