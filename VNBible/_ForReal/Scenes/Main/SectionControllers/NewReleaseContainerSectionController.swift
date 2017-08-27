//
//  NewReleaseContainerSectionController.swift
//  VNBible
//
//  Created by peerapat atawatana on 1/26/2560 BE.
//  Copyright © 2560 DaydreamClover. All rights reserved.
//

import Foundation
import IGListKit
import XCGLogger

final class NewReleaseContainerSectionController: IGListSectionController, IGListSectionType {
    
    var displayNewReleaseContainer: DisplayNewReleaseContainer?
    
    lazy var adapter: IGListAdapter = {
        let adapter = IGListAdapter(
            updater: IGListAdapterUpdater(), viewController: self.viewController, workingRangeSize: 0
        )
        adapter.dataSource = self
        return adapter
    }()
    
    func numberOfItems() -> Int {
        return 1
    }
    
    func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: collectionContext!.containerSize.width, height: 166)
    }
    
    func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell = collectionContext!.dequeueReusableCell(of: EmbeddedCollectionViewCell.self, for: self, at: index) as! EmbeddedCollectionViewCell
        adapter.collectionView = cell.collectionView
        return cell
    }
    
    
    func didUpdate(to object: Any) {
        self.displayNewReleaseContainer = object as? DisplayNewReleaseContainer
        adapter.performUpdates(animated: true, completion: nil) 
    }
    
    func didSelectItem(at index: Int) {}
}

extension NewReleaseContainerSectionController: IGListAdapterDataSource {
    
    func objects(for listAdapter: IGListAdapter) -> [IGListDiffable] {
        return (displayNewReleaseContainer?.displayNewReleases) ?? []
    }
    
    func listAdapter(_ listAdapter: IGListAdapter, sectionControllerFor object: Any) -> IGListSectionController {
        return NewReleaseSectionController()
    }
    
    func emptyView(for listAdapter: IGListAdapter) -> UIView? {
        return nil
    }
}
