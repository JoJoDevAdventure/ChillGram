//
//  ViewController.swift
//  ChillGram
//
//  Created by Youssef Bhl on 26/11/2021.
//

import UIKit
import FirebaseAuth

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        handleNotAuthenticated()
    }
    
    private func handleNotAuthenticated() {
        //check auth status
        if Auth.auth().currentUser == nil {
            //show login screen
            performSegue(withIdentifier: "GoToLoginScreen", sender: self)
        }
    }
}

