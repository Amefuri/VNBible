//
//  MainViewController.swift
//  VNBible
//
//  Created by peerapat atawatana on 1/21/2560 BE.
//  Copyright © 2560 DaydreamClover. All rights reserved.
//

import UIKit
import IGListKit

class Main2ViewController: UIViewController, IGListAdapterDataSource {
    
    // MARK: Property
    
    let vndbAPI:VNDbAPIProtocol = VNDbAPI()
    
    var collectionView:IGListCollectionView!
    var adapter:IGListAdapter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        collectionView = IGListCollectionView(frame: .zero, collectionViewLayout: layout)
        
        
        let updater = IGListAdapterUpdater()
        adapter = IGListAdapter(updater: updater, viewController: self, workingRangeSize: 0)
        
        adapter.collectionView = collectionView
        adapter.dataSource = self
        
        view.addSubview(collectionView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
    // MARK: IBListKit datasource
    
    func objects(for listAdapter: IGListAdapter) -> [IGListDiffable] {
        // this can be anything!
        return [UserHistory(users:allUsers()),  "Foo" as IGListDiffable, "Bar" as IGListDiffable, "Biz" as IGListDiffable ]
    }
    
    func listAdapter(_ listAdapter: IGListAdapter, sectionControllerFor object: Any) -> IGListSectionController {
        if object is UserHistory {
            return UserHistorySectionController()
        }
        else {
            return LabelSectionController()
        }
    }
    
    func emptyView(for listAdapter: IGListAdapter) -> UIView? {
        return nil
    }
    
    // MARK: Helper
    
    func allUsers() -> [User] {
        let radioboo     = User(id: 1, nickname: "radioboo")
        let ainame       = User(id: 2, nickname: "ainame")
        let punchdrunker = User(id: 3, nickname: "punchdrunker")
        let sarukun      = User(id: 4, nickname: "sarukun")
        let sobataro     = User(id: 5, nickname: "sobataro")
        
        return [radioboo, ainame, punchdrunker, sarukun, sobataro]
    }
    
}
