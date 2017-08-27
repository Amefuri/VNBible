//
//  ViewController.swift
//  VNBible
//
//  Created by peerapat atawatana on 1/18/2560 BE.
//  Copyright © 2560 DaydreamClover. All rights reserved.
//

import UIKit
import RxSwift

class ViewController: UIViewController {

    // MARK: Property
    
    let disposeBag = DisposeBag()
    let vndbAPI:VNDbAPIProtocol = VNDbAPI()
    
    // MARK: IBAction
    
    @IBAction func didClickOnButton1() {
        vndbAPI.connect { (result) in
            switch result {
            case .success(let success):
                print("connect result = " + success.description)
            case .fail(_):
                break
            }
        }
    }
    
    @IBAction func didClickOnButton2() {
        vndbAPI.login(username: "amefuri", password: "71fa0932") { (result) in
            switch result {
            case .success(let success):
                print("login result = " + success.description)
            case .fail(_):
                break
            }
        }
    }
    
    @IBAction func didClickOnButton3() {
        vndbAPI.send(command: .get, type: .vn, flags: [.basic,.details], filters: "(id>1)", data:nil) { (result) in
            switch result {
            case .success(let dataStr):
                print("sendCommand result = " + dataStr)
            case .fail(_):
                break
            }
        }
    }
    
    @IBAction func didClickOnButton4() {
        vndbAPI.rx_send(command: .get,
                        type: .vn,
                        flags: [.basic,.details],
                        filters: VNDbAPICommandFilter.query(filterOperator: .greaterThan, id: 1),
                        data: nil)
            .subscribe(onNext: { print($0) })
            .addDisposableTo(disposeBag)
    }
    
    @IBAction func didClickOnButton5() { }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

