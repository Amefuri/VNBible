//
//  LandingViewController.swift
//  VNBible
//
//  Created by peerapat atawatana on 2/10/2560 BE.
//  Copyright © 2560 DaydreamClover. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class LandingViewController: BaseViewController {
    
    // MARK: Initializing
    
    /*init(viewModel: LandingViewModelType) {
        super.init()
        self.configure(viewModel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }*/
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure(LandingViewModel())
    }
    
    // MARK: Configuring
    
    private func configure(_ viewModel: LandingViewModelType) {
        
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
