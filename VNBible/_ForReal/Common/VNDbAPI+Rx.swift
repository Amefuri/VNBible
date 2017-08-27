//
//  VNDbAPI+Rx.swift
//  VNBible
//
//  Created by peerapat atawatana on 1/24/2560 BE.
//  Copyright © 2560 DaydreamClover. All rights reserved.
//

import Foundation
import RxSwift

public extension VNDbAPIProtocol {
    
    func rx_connect()-> Observable<Bool> {
        return Observable.create({ (observer) -> Disposable in
            self.connect({ (result) in
                switch result {
                case .success(let data):
                    observer.on(.next(data))
                    observer.on(.completed)
                case .fail(let error):
                    observer.on(.error(error))
                }
            })
            return Disposables.create()
        })
    }
    
    func rx_login(username:String, password:String)-> Observable<String> {
        return Observable.create({ (observer) -> Disposable in
            self.login(username: username, password: password) { result in
                switch result {
                case .success(let data):
                    observer.on(.next(data))
                    observer.on(.completed)
                case .fail(let error):
                    observer.on(.error(error))
                }
            }
            return Disposables.create()
        })
    }
    
    public func rx_send(command:VNDbAPICommand, type:VNDbAPICommandType?, flags:[VNDbAPICommandFlag]?, filters:CustomStringConvertible?, data:[String : Any]?)-> Observable<String> {
        return Observable.create({ (observer) -> Disposable in
            self.send(command: command, type: type, flags: flags, filters: filters, data: data) { result in
                switch result {
                case .success(let data):
                    observer.on(.next(data))
                    observer.on(.completed)
                case .fail(let error):
                    observer.on(.error(error))
                }
            }
            return Disposables.create()
        })
    }
}
