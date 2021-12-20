//
//  PostViewController.swift
//  ChillGram
//
//  Created by Youssef Bhl on 26/11/2021.
//

import UIKit

class PostViewController: UIViewController {
    
    private let model: UserPost?
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        
        //register cells
        tableView.register(CGFeedPostsTableViewCell.self,
                           forCellReuseIdentifier: CGFeedPostsTableViewCell.identifier)
        tableView.register(CGFeedPostHeaderTableViewCell.self,
                           forCellReuseIdentifier: CGFeedPostHeaderTableViewCell.identifier)
        tableView.register(CGFeedPostActionsTableViewCell.self,
                           forCellReuseIdentifier: CGFeedPostActionsTableViewCell.identifier)
        tableView.register(CGFeedPostGeneralTableViewCell.self,
                           forCellReuseIdentifier: CGFeedPostGeneralTableViewCell.identifier)
        
        return tableView
    }()
    
    //MARK: Init
    
    init(model: UserPost?) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
     - Header model
     - Post cell model
     - Action buttons cell model
     - A number of general models for comments
     */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        view.backgroundColor = .systemBackground
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
}

extension PostViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
