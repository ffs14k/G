//
//  GCManager.swift
//  G
//
//  Created by Евгений Орехин on 18.04.2020.
//  Copyright © 2020 Eugene. All rights reserved.
//

import UIKit

public protocol GCManagerProtocol {
    
    var sectionsCount: Int { get }
    
    func cellsCount(for section: Int) -> Int?
    
    func header(for section: Int) -> GCCell?
    
    func footer(for section: Int) -> GCCell?
    
    func cells(for section: Int) -> [GCCell]
    
    func cell(for section: Int, at index: Int) -> GCCell
    
    func reloadData(sections: [GridSection], animator: GridReloadAnimatorFactory?)
    
    func appendSections(_ sections: [GridSection])
    
    func insertSections(_ sections: [GridSection], _ pattern: GridSourceMatchPattern)
    
    func deleteSections(pattern: GridSourceMatchPattern)
    
    //    TODO
    //    func reloadSections(_ sections: [GridSection], _ pattern: GridSourceMatchPattern, with animation: Animation?)
    
    func appendCells(_ cells: [GCCell], section: Int)
    
    func insertCells(_ cells: [GCCell], section: Int, pattern: GridSourceMatchPattern)
    
    func reloadCells(_ cells: [GCCell], section: Int, pattern: GridSourceMatchPattern)
    
    func deleteCells(section: Int, pattern: GridSourceMatchPattern)
    
    func updateHeader(_ header: GCCell, section: Int)
    
    func updateFooter(_ footer: GCCell, section: Int)
}

public extension GCManagerProtocol {
    
    func cell(indexPath: IndexPath) -> GCCell {
        return cell(for: indexPath.section, at: indexPath.item)
    }
    
    func reloadData(section: GridSection, animator: GridReloadAnimatorFactory?) {
        self.reloadData(sections: [section], animator: animator)
    }
}

public final class GCManager: GCManagerProtocol {
    
    // MARK: - Public properties
    
    public unowned var collectionView: UICollectionView!
    
    private let sizeProvider: GridCellSizeProvider
    private let gridSource: GridSourceProtocol
    
    // Grid Custom Reload Animation
    
    private var reloadAnimator: GridReloadAnimatorManager?
    private var endReloadCatchingTimer: Timer?
    
    
    // MARK: - Init
    
    public init(gridSource: GridSourceProtocol = GridSource(),
                sizeProvider: GridCellSizeProvider = GridCellSizeProviderImp()) {
        self.gridSource = gridSource
        self.sizeProvider = sizeProvider
    }
    
    // MARK: - Public methods that should be used inside View Contoller
    
    /// cell
    public func cellSize(forIndexPath indexPath: IndexPath, in rect: CGRect) -> CGSize {
        return cell(indexPath: indexPath).size(in: rect, sizeProvider: sizeProvider)
    }
    
    public func configureCell(forIndexPath indexPath: IndexPath) -> UICollectionViewCell {
        return cell(indexPath: indexPath).configureCell(collectionView)
    }
    
    /// header & footer
    public func configureHeaderFooter(forSection section: Int, kind: String) -> UICollectionReusableView? {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let header = header(for: section) else { return nil }
            return header.configureHeaderFooter(collectionView, kind: kind)
            
        case UICollectionView.elementKindSectionFooter:
            guard let footer = footer(for: section) else { return nil }
            return footer.configureHeaderFooter(collectionView, kind: kind)
            
        default:
            return nil
        }
    }
    
    public func headerSize(forSection section: Int, in rect: CGRect) -> CGSize {
        return header(for: section)?.size(in: rect, sizeProvider: sizeProvider) ?? .zero
    }
    
    public func footerSize(forSection section: Int, in rect: CGRect) -> CGSize {
        return footer(for: section)?.size(in: rect, sizeProvider: sizeProvider) ?? .zero
    }
    
    /// Raw reload animator
    public func willDisplayCell(_ cell: UICollectionViewCell, section: Int, gridRect: CGRect) {
        guard let reloadAnimator = reloadAnimator else { return }
        reloadAnimator.willDisplay(cell, type: .cell, section: section, gridRect: gridRect)
    }
    
    public func willDisplayHeaderFooter(_ headerFooter: UICollectionReusableView, kind: String, section: Int, gridRect: CGRect) {
        guard let reloadAnimator = reloadAnimator else { return }
        
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            reloadAnimator.willDisplay(headerFooter, type: .header, section: section, gridRect: gridRect)
            
        case UICollectionView.elementKindSectionFooter:
            reloadAnimator.willDisplay(headerFooter, type: .footer, section: section, gridRect: gridRect)
            
        default:
            return
        }
    }
    
}


// MARK: - GCManagerProtocol Methods
public extension GCManager {
    
    var sectionsCount: Int {
        return gridSource.sectionsCount
    }
    
    func cellsCount(for section: Int) -> Int? {
        return gridSource.itemsCount(section: section)
    }
    
    func header(for section: Int) -> GCCell? {
        guard let header = gridSource.headerItem(section: section) else { return nil }
        return (header as! GCCell)
    }
    
    func footer(for section: Int) -> GCCell? {
        guard let footer = gridSource.footerItem(section: section) else { return nil }
        return (footer as! GCCell)
    }
    
    func cells(for section: Int) -> [GCCell] {
        return gridSource.items(section: section) as! [GCCell]
    }
    
    func cell(for section: Int, at index: Int) -> GCCell {
        return gridSource.item(section: section, item: index) as! GCCell
    }
    
    func reloadData(sections: [GridSection], animator: GridReloadAnimatorFactory?) {
        
        gridSource.reloadData(sections: sections)
        
        guard !sections.isEmpty else {
            collectionView.reloadData()
            return
        }
        
        if let animator = animator {
            reloadAnimator = animator.animatorManager
            createEndReloadCatchingTimer()
        }
        
        UIView.animate(withDuration: 0.01) {
            self.collectionView.reloadData()
        }
    }
    
    func appendSections(_ sections: [GridSection]) {
        let appendIndexSet = gridSource.appendSections(sections)
        collectionView.insertSections(appendIndexSet)
    }
    
    func insertSections(_ sections: [GridSection], _ pattern: GridSourceMatchPattern) {
        let insertIndexSet = gridSource.insertSections(sections, pattern: pattern)
        collectionView.insertSections(insertIndexSet)
    }
    
    func deleteSections(pattern: GridSourceMatchPattern) {
        let deleteIndexSet = gridSource.deleteSections(pattern: pattern)
        collectionView.deleteSections(deleteIndexSet)
    }
    
    func appendCells(_ cells: [GCCell], section: Int) {
        let appendIndexPaths = gridSource.appendItems(cells, section: section)
        collectionView.insertItems(at: appendIndexPaths)
    }
    
    func insertCells(_ cells: [GCCell], section: Int, pattern: GridSourceMatchPattern) {
        let insertIndexPaths = gridSource.insertItems(cells, section: section, pattern: pattern)
        collectionView.insertItems(at: insertIndexPaths)
        updateVisibleCellsIndexPaths()
    }
    
    func reloadCells(_ cells: [GCCell], section: Int, pattern: GridSourceMatchPattern) {
        let reloadIndexPaths = gridSource.reloadItems(cells, section: 0, pattern: pattern)
        collectionView.reloadItems(at: reloadIndexPaths)
    }
    
    func deleteCells(section: Int, pattern: GridSourceMatchPattern) {
        let deleteIndexPaths = gridSource.deleteItems(section: section, pattern: pattern)
        collectionView.deleteItems(at: deleteIndexPaths)
        updateVisibleCellsIndexPaths()
    }
    
    func updateHeader(_ header: GCCell, section: Int) {
        
        gridSource.updateHeader(header, atSection: section)
        
        let indexPath = IndexPath(item: 0, section: section)
        if let headerCell = collectionView.supplementaryView(forElementKind: UICollectionView.elementKindSectionHeader, at: indexPath) {
            self.header(for: section)?.updateHeaderFooter(headerCell)
        } else {
            collectionView.reloadSections(IndexSet(arrayLiteral: section))
        }
    }
    
    func updateFooter(_ footer: GCCell, section: Int) {
        
        gridSource.updateFooter(footer, atSection: section)
        
        let indexPath = IndexPath(item: 0, section: section)
        if let footerCell = collectionView.supplementaryView(forElementKind: UICollectionView.elementKindSectionFooter, at: indexPath) {
            self.footer(for: section)?.updateHeaderFooter(footerCell)
        } else {
            collectionView.reloadSections(IndexSet(arrayLiteral: section))
        }
    }
}


// MARK: - Private methods
private extension GCManager {
    
    private func updateVisibleCellsIndexPaths() {
        collectionView.indexPathsForVisibleItems.forEach({ indexPath in
            guard let cell = collectionView.cellForItem(at: indexPath) else { return }
            let cellModel = gridSource.item(section: indexPath.section, item: indexPath.item) as! GCCell
            cellModel.updateCell(cell)
        })
    }
    
    private func createEndReloadCatchingTimer() {
        collectionView.alpha = 0
        
        let block: (Timer) -> Void = { [weak self] timer in
            self?.handleGridReloadAnimation()
            if self?.endReloadCatchingTimer == nil {
                timer.invalidate()
            }
        }
        endReloadCatchingTimer = Timer.scheduledTimer(withTimeInterval: 1 / 24, repeats: true, block: block)
        endReloadCatchingTimer!.fire()
    }
    
    private func handleGridReloadAnimation() {
        guard self.isCellsReloaded else {
            return
        }
        
        self.releaseEndReloadCatchingTimer()
        self.reloadAnimator!.handleCellsAnimation { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.collectionView.alpha = 1
            }
            self.reloadAnimator = nil
        }
    }
    
    private func releaseEndReloadCatchingTimer() {
        endReloadCatchingTimer!.invalidate()
        endReloadCatchingTimer = nil
    }
    
    private var isCellsReloaded: Bool {
        let isHeadersReloaded = !self.collectionView.visibleSupplementaryViews(ofKind: UICollectionView.elementKindSectionHeader).isEmpty
        let isCellsReloaded = !self.collectionView.visibleCells.isEmpty
        return isHeadersReloaded || isCellsReloaded
    }
    
}
