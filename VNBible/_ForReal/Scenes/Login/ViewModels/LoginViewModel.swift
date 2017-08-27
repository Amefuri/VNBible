//
//  LoginViewModel.swift
//  VNBible
//
//  Created by peerapat atawatana on 2/23/2560 BE.
//  Copyright © 2560 DaydreamClover. All rights reserved.
//

import RxSwift
import RxCocoa

public protocol LoginViewModelInputs {
    
}

public protocol LoginViewModelOutputs {
    
}

public protocol LoginViewModelType {
    var inputs: LoginViewModelInputs { get }
    var outputs: LoginViewModelOutputs { get }
}

public final class LoginViewModel: LoginViewModelType, LoginViewModelInputs, LoginViewModelOutputs {
    
    // MARK: Variable
    
    private let disposeBag = DisposeBag()
    
    // MARK: Init
    
    public init() {
        
    }
    
    // MARK: Input
    
    // MARK: Output
    
    // MARK: Input&Output
    
    public var outputs: LoginViewModelOutputs { return self }
    public var inputs: LoginViewModelInputs { return self }
    
    // MARK: Private
}
