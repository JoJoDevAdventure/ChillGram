//
//  NotificationViewController.swift
//  ChillGram
//
//  Created by Youssef Bhl on 26/11/2021.
//

///Notifications view Controller
import UIKit

enum UserNotificationType{
    case like(post: UserPost)
    case follow(state: followState)
}

struct UserNotification{
    let type: UserNotificationType
    let text: String
    let user: user
}
    
final class NotificationViewController: UIViewController {
    
    //MARK: -Views
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.isHidden = false
        tableView.register(NotificationsFollowTableViewCell.self,
                           forCellReuseIdentifier: NotificationsFollowTableViewCell.identifier)
        tableView.register(NotificationsLikeTableViewCell.self,
                           forCellReuseIdentifier: NotificationsLikeTableViewCell.identifier)
        return tableView
    }()
    
    private lazy var noNotificationsView = noNotificationView()
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.tintColor = .label
        return spinner
    }()
    
    private var models = [UserNotification]()
    
    //MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchNotifications()
        navigationItem.title = "Notifications"
        view.addSubview(tableView)
        view.addSubview(spinner)
        //spinner.startAnimating()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        spinner.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        spinner.center = view.center
    }
    
    private func addNoNotification() {
        tableView.isHidden = true
        view.addSubview(noNotificationsView)
        noNotificationsView.frame = CGRect(x: 0, y: 0, width: view.bounds.width/2, height: view.bounds.height/4)
        noNotificationsView.center = view.center
    }
    
    private func fetchNotifications() {
        for x in 0...200 {
            let post = UserPost(identifieer: "",
                                postType: .photo,
                                thunmbnailImage: URL(string: "https://www.google.com")!,
                                postURL: URL(string: "https://www.google.com")!,
                                caption: nil, likeCount: [],
                                comments: [],
                                createdDate: Date(),
                                taggedUser: [])
            let model = UserNotification(type: x % 2 == 0 ? .like(post: post ) : .follow(state: .not_following) ,
                                         text: "Hello world",
                                         user: user(username: "youssef",
                                                    bio: "",
                                                    name: (first: "", last: ""),
                                                    profilePicture: URL(string: "https://www.google.con")!,
                                                    birthDate: Date(),
                                                    gender: .female,
                                                    counts: UserCounts(followers: 1, following: 1, posts: 1),
                                                    joinDate: Date()) )
            models.append(model)
        }
    }
    
}

//MARK: Extensions

extension NotificationViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        switch model.type {
        case .like(_):
            //like cell
            let cell =  tableView.dequeueReusableCell(withIdentifier: NotificationsLikeTableViewCell.identifier,
                                                      for: indexPath) as! NotificationsLikeTableViewCell
            cell.configure(with: model)
            cell.delegate = self
            return cell
        case .follow :
            //follow cell
            let cell = tableView.dequeueReusableCell(withIdentifier: NotificationsFollowTableViewCell.identifier,
                                                     for: indexPath) as! NotificationsFollowTableViewCell
            cell.delegate = self 
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
}

extension NotificationViewController: NotificationsLikeTableViewCellDelegate, NotificationsFollowTableViewCellDelegate  {
    
    func didTapFollowUnfollowButton(model: UserNotification) {
        //perform data base update
        
    }
    
    func didTapRelatedPostButton(model: UserNotification) {
        //open the post
        switch model.type {
        case .like(let post):
            let vc = PostViewController(model: post)
            vc.title = post.postType.rawValue
            vc.navigationItem.largeTitleDisplayMode = .never
            navigationController?.pushViewController(vc, animated: true)
        case .follow(_):
            fatalError("Dev error : Should never get called")
        }
    }
    
    
}
