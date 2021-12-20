//
//  ProfileInfoHeaderCollectionReusableView.swift
//  ChillGram
//
//  Created by Youssef Bhl on 07/12/2021.
//

import UIKit

protocol ProfileInfoHeaderCollectionReusableViewDelegate: AnyObject {
    func profileHeaderDidTapPostsButton(_ header: ProfileInfoHeaderCollectionReusableView)
    func profileHeaderDidTapFollowersButton(_ header: ProfileInfoHeaderCollectionReusableView)
    func profileHeaderDidTapFollowingButton(_ header: ProfileInfoHeaderCollectionReusableView)
    func profileHeaderDidTapEditButton(_ header: ProfileInfoHeaderCollectionReusableView)
}

final class ProfileInfoHeaderCollectionReusableView: UICollectionReusableView {
    static let identifier = "ProfileInfoHeaderCollectionReusableView"
    
    public weak var delegate: ProfileInfoHeaderCollectionReusableViewDelegate?
    
    private let profilePhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .red
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private let postsButton: UIButton = {
        let button = UIButton()
        button.setTitle("21", for: .normal)
        button.setTitleColor(.label, for: .normal)
        return button
    }()
    
    private let postsLabel: UILabel = {
        let text = UILabel()
        text.text = "posts"
        text.alpha = 0.50
        text.textAlignment = .center
        text.adjustsFontSizeToFitWidth = true
        text.textColor = .label
        text.numberOfLines = 1
        return text
    }()
    
    private let followersButton: UIButton = {
        let button = UIButton()
        button.setTitle("400K", for: .normal)
        button.setTitleColor(.label, for: .normal)
        return button
    }()
    
    private let followersLabel: UILabel = {
        let text = UILabel()
        text.text = "followers"
        text.alpha = 0.50
        text.textAlignment = .center
        text.adjustsFontSizeToFitWidth = true
        text.textColor = .label
        text.numberOfLines = 1
        return text
    }()
    
    private let followingButton: UIButton = {
        let button = UIButton()
        button.setTitle("1203", for: .normal)
        button.setTitleColor(.label, for: .normal)
        return button
    }()
    
    private let followingLabel: UILabel = {
        let text = UILabel()
        text.text = "following"
        text.alpha = 0.50
        text.textAlignment = .center
        text.adjustsFontSizeToFitWidth = true
        text.textColor = .label
        text.numberOfLines = 1
        return text
    }()
    
    private let editProfileButton: UIButton = {
        let button = UIButton()
        button.setTitle("Edit profile", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.label.cgColor
        button.layer.cornerRadius = 10
        return button
    }()
    
    private let usernameLabel: UILabel = {
        let username = UILabel()
        username.text = "Username"
        username.textColor = .label
        username.numberOfLines = 1
        return username
    }()
    
    private let bioLabel: UILabel = {
        let bio = UILabel()
        bio.text = "This is supposed to be a bio"
        bio.textColor = .label
        bio.numberOfLines = 0
        return bio
    }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        clipsToBounds = true
        addSubview()
        addButtonActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    override func layoutSubviews() {
        super.layoutSubviews()
        let profilePhotoSize = bounds.width/4
        
        profilePhotoImageView.frame = CGRect(x: 15,
                                             y: 15,
                                             width: profilePhotoSize,
                                             height: profilePhotoSize)
                                             .integral
        profilePhotoImageView.layer.cornerRadius = profilePhotoSize/2.0
    
        
        let buttonHeight = profilePhotoSize/2
        let countButtonWidth = (bounds.width-40-profilePhotoSize)/3
        
        postsButton.frame = CGRect(x: profilePhotoSize+30 ,
                                   y: 0,
                                   width: countButtonWidth,
                                   height: buttonHeight)
                                   .integral
        postsLabel.frame = CGRect(x: profilePhotoSize+30 ,
                                   y: 22,
                                   width: countButtonWidth,
                                   height: buttonHeight)
                                   .integral
        
        followersButton.frame = CGRect(x: 30+profilePhotoSize+countButtonWidth,
                                   y: 0,
                                   width: countButtonWidth,
                                   height: buttonHeight)
                                   .integral
        followersLabel.frame = CGRect(x: 30+profilePhotoSize+countButtonWidth,
                                   y: 22,
                                   width: countButtonWidth,
                                   height: buttonHeight)
                                   .integral
        
        followingButton.frame = CGRect(x: 30+profilePhotoSize+2*countButtonWidth,
                                   y: 0,
                                   width: countButtonWidth,
                                   height: buttonHeight)
                                   .integral
        followingLabel.frame = CGRect(x: 30+profilePhotoSize+2*countButtonWidth,
                                   y: 22,
                                   width: countButtonWidth,
                                   height: buttonHeight)
                                   .integral
        
        editProfileButton.frame = CGRect(x: profilePhotoSize+30,
                                   y: 70,
                                   width: countButtonWidth*3,
                                   height: buttonHeight)
                                   .integral
        
        usernameLabel.frame = CGRect(x: 15,
                                   y: profilePhotoSize + 15,
                                   width: countButtonWidth*3,
                                   height: buttonHeight)
                                   .integral
        
        bioLabel.frame = CGRect(x: 15,
                                   y: profilePhotoSize + 50,
                                   width: countButtonWidth*3,
                                   height: buttonHeight)
                                   .integral
    }
    
    private func addSubview() {
        addSubview(profilePhotoImageView)
        addSubview(postsButton)
        addSubview(followingButton)
        addSubview(followersButton)
        addSubview(editProfileButton)
        addSubview(usernameLabel)
        addSubview(bioLabel)
        addSubview(postsLabel)
        addSubview(followersLabel)
        addSubview(followingLabel)
    }
    
    private func addButtonActions(){
        postsButton.addTarget(self,
                                  action: #selector(didTapPostsButton),
                                  for: .touchUpInside)
        
        followersButton.addTarget(self,
                                  action: #selector(didTapFollowersButton),
                                  for: .touchUpInside)
    
        followingButton.addTarget(self,
                                  action: #selector(didTapFollowingButton),
                                  for: .touchUpInside)
        
        editProfileButton.addTarget(self,
                                  action: #selector(didTapEditProfileButton),
                                  for: .touchUpInside)
    }

    //MARK: Actions
    
    @objc private func didTapPostsButton(){
        delegate?.profileHeaderDidTapPostsButton(self)
    }
    
    @objc private func didTapFollowersButton(){
        delegate?.profileHeaderDidTapFollowersButton(self)    }
    
    @objc private func didTapFollowingButton(){
        delegate?.profileHeaderDidTapFollowingButton(self)
    }
    
    @objc private func didTapEditProfileButton(){
        delegate?.profileHeaderDidTapEditButton(self)
    }

}
