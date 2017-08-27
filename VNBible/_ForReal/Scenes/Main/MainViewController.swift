//
//  MainViewController.swift
//  VNBible
//
//  Created by peerapat atawatana on 1/23/2560 BE.
//  Copyright © 2560 DaydreamClover. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import IGListKit
import XCGLogger

class MainViewController: BaseViewController, IGListAdapterDataSource {
    
    // MARK: Property
    
    var collectionView:IGListCollectionView!
    var adapter:IGListAdapter!
    var viewModel:MainViewModelType!
    var displayNewReleases:[DisplayNewRelease] = []
    
    // MARK: Initializing
    
    /*init(viewModel: MainViewModelType) {
        super.init()
        self.configure(viewModel)
    }*/
    
    //required init?(coder aDecoder: NSCoder) {
        //fatalError("init(coder:) has not been implemented")
        //super.init(coder: aDecoder)
    //}
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure(MainViewModel())
        setupIGList()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
    // MARK: Configuring

    private func configure(_ viewModel: MainViewModelType) {
        self.viewModel = viewModel
        
        self.viewModel.outputs.newReleaseVNs.subscribe(onNext: { displayNewReleases in
            self.displayNewReleases = displayNewReleases
            
            /*displayNewReleases.forEach({ (eachNewRelease) in
                self.displayNewReleases.append(eachNewRelease)
            })*/
            
            self.adapter.performUpdates(animated: true)
            //self.collectionContext?.reload(in: self, at: 0)
        }).addDisposableTo(disposeBag)
        
        // Force Trigger
        self.viewModel.inputs.reloadTrigger.onNext()
    }
    
    private func setupIGList() {
        let layout = UICollectionViewFlowLayout()
        collectionView = IGListCollectionView(frame: .zero, collectionViewLayout: layout)
        
        let updater = IGListAdapterUpdater()
        adapter = IGListAdapter(updater: updater, viewController: self, workingRangeSize: 0)
        
        adapter.collectionView = collectionView
        adapter.dataSource = self
        
        view.addSubview(collectionView)
    }
    
    // MARK: IBListKit datasource
    
    func objects(for listAdapter: IGListAdapter) -> [IGListDiffable] {
        // this can be anything!
        //return [UserHistory(users:allUsers())]
        /*let temp1 = DisplayNewRelease(id: 1, title: "1", image: "https://cdn2.raywenderlich.com/wp-content/themes/raywenderlich/images/store/profile-page-products/cdt@2x.png")
        let temp2 = DisplayNewRelease(id: 2, title: "2", image: "https://cdn2.raywenderlich.com/wp-content/themes/raywenderlich/images/store/profile-page-products/cdt@2x.png")
        let temp3 = DisplayNewRelease(id: 3, title: "3", image: "https://cdn2.raywenderlich.com/wp-content/themes/raywenderlich/images/store/profile-page-products/cdt@2x.png")
        let temp4 = DisplayNewRelease(id: 4, title: "4", image: "https://cdn2.raywenderlich.com/wp-content/themes/raywenderlich/images/store/profile-page-products/cdt@2x.png")
        let temp5 = DisplayNewRelease(id: 5, title: "5", image: "https://cdn2.raywenderlich.com/wp-content/themes/raywenderlich/images/store/profile-page-products/cdt@2x.png")
        return [DisplayNewReleaseContainer(displayNewReleases: [temp1,temp2,temp3,temp4,temp4,temp5])]*/
        log.debug("IN")
        print(displayNewReleases.count)
        return [DisplayNewReleaseContainer(displayNewReleases: displayNewReleases)]
    }
    
    func listAdapter(_ listAdapter: IGListAdapter, sectionControllerFor object: Any) -> IGListSectionController {
        //if object is UserHistory { 
            //return UserHistorySectionController()
            return NewReleaseContainerSectionController()
        //}
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
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
