//
//  SettingViewController.swift
//  ChillGram
//
//  Created by Youssef Bhl on 26/11/2021.
//

import UIKit
import SafariServices

struct settingCellModel {
    let tittle: String
    let handler : (() -> Void)
}

///view conrtroller to show user settings :
final class SettingViewController: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var settingsTableView: UITableView!
    
    private var data = [[settingCellModel]]()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        settingsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        configureModels()
        settingsTableView.delegate = self
        settingsTableView.dataSource = self
    }
    
    //MARK: Private func
    private func configureModels() {
        //Adding settings
        data.append([
            settingCellModel(tittle: "Edit Profile"){ [weak self] in
                self?.didEditProfile()
            },
            settingCellModel(tittle: "Invite friends"){ [weak self] in
                self?.didTapInviteFriend()
            },
            settingCellModel(tittle: "Save Original Posts"){ [weak self] in
                self?.didTapSaveOriginalPosts()
            }
        ])
        
        data.append([
            settingCellModel(tittle: "Terms of Services"){ [weak self] in
                self?.didTapTermusofServices()
            },
            settingCellModel(tittle: "Privacy Policy"){ [weak self] in
                self?.didTapPrivacyPolicy()
            },
            settingCellModel(tittle: "Help / Feedback"){ [weak self] in
                self?.didTapHelpFeedback()
            }
        ])
        
        data.append([
            settingCellModel(tittle: "Log Out"){ [weak self] in
                self?.didTapLogOut()
            }
        ])
    }
    
    private func didTapLogOut(){
        AuthManager.shared.LogOutUser(Completion: { success in
            if success {
                //logged out, present login
                performSegue(withIdentifier: "GoToLoginScreen", sender: self)
                self.navigationController?.popToRootViewController(animated: true)
                self.tabBarController?.selectedIndex = 0
            }
            else {
                //problem
            }
        })
    }
    
    //MARK: functions buttons
    // Action if user pressed : Edit profile
    private func didEditProfile(){
        let vc = EditProileViewController()
        vc.title = "Edit profile"
        let navVC = UINavigationController(rootViewController: vc)
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true)
    }
    
    // Action if user pressed : invite friends
    private func didTapInviteFriend(){
        
    }
    
    // Action if user pressed : save original post
    private func didTapSaveOriginalPosts(){
        
    }
    
    // Action if user pressed : terms of use
    private func didTapTermusofServices(){
        
    guard let url = URL(string: "https://help.instagram.com/581066165581870") else {
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    
    // Action if user pressed : privacy policy
    private func didTapPrivacyPolicy(){
        
    guard let url = URL(string: "https://help.instagram.com/519522125107875") else {
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    
    // Action if user pressed : feedback
    private func didTapHelpFeedback(){
        
        guard let url = URL(string: "https://help.instagram.com/581066165581870") else {
                return
            }
            let vc = SFSafariViewController(url: url)
            present(vc, animated: true)
        
    }
}

//MARK: Extensions
extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in settingsTableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ settingsTableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].count
    }
    
    func tableView(_ settingsTableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = settingsTableView.dequeueReusableCell(withIdentifier: "cell",for : indexPath)
        cell.textLabel?.text = data[indexPath.section][indexPath.row].tittle
        cell.accessoryType = .disclosureIndicator
        return  cell
    }
    
    func tableView(_ settingsTableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        settingsTableView.deselectRow(at: indexPath, animated: true)
        let model = data[indexPath.section][indexPath.row]
        model.handler()
    }
    
}
