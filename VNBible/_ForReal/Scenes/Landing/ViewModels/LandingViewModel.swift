//
//  LandingViewModel.swift
//  VNBible
//
//  Created by peerapat atawatana on 2/10/2560 BE.
//  Copyright © 2560 DaydreamClover. All rights reserved.
//

import RxSwift
import RxCocoa

public protocol LandingViewModelInputs {
    
}

public protocol LandingViewModelOutputs {
    
}

public protocol LandingViewModelType {
    var inputs: LandingViewModelInputs { get }
    var outputs: LandingViewModelOutputs { get }
}

public final class LandingViewModel: LandingViewModelType, LandingViewModelInputs, LandingViewModelOutputs {
    
    // MARK: Variable
    
    private let disposeBag = DisposeBag()
    
    // MARK: Init
    
    public init() {
        
    }
    
    // MARK: Input
    
    // MARK: Output
    
    // MARK: Input&Output
    
    public var outputs: LandingViewModelOutputs { return self }
    public var inputs: LandingViewModelInputs { return self }
    
    // MARK: Private
}
