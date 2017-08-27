//
//  MainViewModel.swift
//  VNBible
//
//  Created by peerapat atawatana on 1/23/2560 BE.
//  Copyright © 2560 DaydreamClover. All rights reserved.
//

import RxSwift
import RxCocoa

public protocol MainViewModelInputs {
    var connectTrigger: PublishSubject<Void> { get }
    var reloadTrigger: PublishSubject<Void> { get }
}

public protocol MainViewModelOutputs {
    var newReleaseVNs:Observable<[DisplayNewRelease]> { get }
}

public protocol MainViewModelType {
    var inputs: MainViewModelInputs { get }
    var outputs: MainViewModelOutputs { get }
}

public final class MainViewModel: MainViewModelType, MainViewModelInputs, MainViewModelOutputs {
    
    // MARK: Variable
    
    private let disposeBag = DisposeBag()
    
    // MARK: Init
    
    public init() {
        
    }
    
    // MARK: Input
    
    public var connectTrigger: PublishSubject<Void> = PublishSubject()
    public var reloadTrigger: PublishSubject<Void> = PublishSubject()
    
    // MARK: Output
    
    lazy public var newReleaseVNs:Observable<[DisplayNewRelease]> = self.setupVNs()
    
    // MARK: Input&Output
    
    public var outputs: MainViewModelOutputs { return self }
    public var inputs: MainViewModelInputs { return self }
    
    // MARK: Private
    
    private func setupVNs()-> Observable<[DisplayNewRelease]> {
        return self.reloadTrigger
            .asObservable()
            .debounce(0.3, scheduler: MainScheduler.instance)
            .flatMapLatest { (_) -> Observable<String> in
                /*return VNDbAPI().rx_send(command: .get,
                                       type: .vn,
                                       flags: [.basic,.details],
                                       filters: VNDbAPICommandFilter.query(filterOperator: .greaterThan, id: 1),
                                       data: nil)*/
                return Observable.just("XX")
            }
            .map({ (resultString) -> [DisplayNewRelease] in
                
                log.debug("MAP")
                
                let temp1 = DisplayNewRelease(id: 1, title: "1", image: "https://cdn2.raywenderlich.com/wp-content/themes/raywenderlich/images/store/profile-page-products/cdt@2x.png")
                let temp2 = DisplayNewRelease(id: 2, title: "2", image: "https://cdn2.raywenderlich.com/wp-content/themes/raywenderlich/images/store/profile-page-products/cdt@2x.png")
                let temp3 = DisplayNewRelease(id: 3, title: "3", image: "https://cdn2.raywenderlich.com/wp-content/themes/raywenderlich/images/store/profile-page-products/cdt@2x.png")
                let temp4 = DisplayNewRelease(id: 4, title: "4", image: "https://cdn2.raywenderlich.com/wp-content/themes/raywenderlich/images/store/profile-page-products/cdt@2x.png")
                let temp5 = DisplayNewRelease(id: 5, title: "5", image: "https://cdn2.raywenderlich.com/wp-content/themes/raywenderlich/images/store/profile-page-products/cdt@2x.png")
                return [temp1,temp2,temp3,temp4,temp5]
            })
            .shareReplay(1)
    }
}
