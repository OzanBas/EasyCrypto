//
//  WelcomeViewController.swift
//  Trader_Playground
//
//  Created by Ozan Bas on 30.09.2021.
//

import UIKit

class WelcomeViewController : UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(self.moveToMain), userInfo: nil, repeats: false)
    }
    
    @objc func moveToMain() {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "moveToMain", sender: self)

        }
    }
    
    
    
}
