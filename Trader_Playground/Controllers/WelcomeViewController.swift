//
//  ViewController.swift
//  Trader_Playground
//
//  Created by Ozan Bas on 29.08.2021.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var logInButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DataManager().getData(with: DataManager().apiUrl)
}

    @IBAction func logInTapped(_ sender: UIButton) {
    }
}








