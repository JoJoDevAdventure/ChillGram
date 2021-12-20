//
//  ViewController.swift
//  ChillGram
//
//  Created by Youssef Bhl on 26/11/2021.
//

import UIKit
import FirebaseAuth

class HomeViewController: UIViewController {
    
    //MARK: -UIs declaration
    private let tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.register(CGFeedPostsTableViewCell.self, forCellReuseIdentifier: CGFeedPostsTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        handleNotAuthenticated()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    //MARK: functions
    private func handleNotAuthenticated() {
        //check auth status
        if Auth.auth().currentUser == nil {
            //show login screen
            performSegue(withIdentifier: "GoToLoginScreen", sender: self)
        }
    }
}
//MARK: -Extensions
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CGFeedPostsTableViewCell.identifier, for: indexPath) as! CGFeedPostsTableViewCell
        return UITableViewCell()//cell.self.reuseIdentifier(Identifiable: "cell")
    }
    
}
    
