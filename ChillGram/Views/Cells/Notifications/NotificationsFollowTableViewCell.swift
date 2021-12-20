//
//  NotificationsFollowTableViewCell.swift
//  ChillGram
//
//  Created by Youssef Bhl on 17/12/2021.
//

import UIKit

protocol NotificationsFollowTableViewCellDelegate: AnyObject {
    func didTapFollowUnfollowButton(model: UserNotification)
}

class NotificationsFollowTableViewCell: UITableViewCell {
    static let identifier = "NotificationsFollowTableViewCell"
    
    weak var delegate: NotificationsFollowTableViewCellDelegate?
    
    private var model: UserNotification?
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .blue
        return imageView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 0
        label.text = "@Youssef starting following you."
        
        return label
    }()
    
    private let followButton: UIButton = {
        let button = UIButton()
        button.setTitle("Follow", for: .normal)
        button.backgroundColor = .link
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        contentView.addSubview(profileImageView)
        contentView.addSubview(label)
        contentView.addSubview(followButton)
        selectionStyle = .none
        followButton.addTarget(self, action: #selector(didTapFollowUnfollowButton), for: .touchUpInside)
    }
    
    @objc private func didTapFollowUnfollowButton() {
        guard let model = model else {
            return
        }
        delegate?.didTapFollowUnfollowButton(model: model)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with model: UserNotification) {
        self.model = model
        switch model.type {
        case .like(let post):
            break
            
        case .follow(let state) :
            //configure button
            switch state {
            case .following:
                showFollowButton()
            case .not_following:
                showUnfollowButton()
            }
            break
        }
        
        label.text = model.text
        profileImageView.sd_setImage(with: model.user.profilePicture, completed: nil)
    }
    
    private func showFollowButton() {
        //show follow button
        followButton.backgroundColor = .systemBackground
        followButton.setTitle("Unfollow", for: .normal)
        followButton.setTitleColor(.label, for: .normal)
        followButton.layer.borderWidth = 1
        followButton.layer.borderColor = UIColor.label.cgColor
    }
    private func showUnfollowButton() {
        //show unfollow button
        followButton.backgroundColor = .link
        followButton.setTitle("Follow", for: .normal)
        followButton.setTitleColor(.white, for: .normal)
        followButton.layer.borderWidth = 0
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        followButton.setTitle(nil, for: .normal)
        followButton.backgroundColor = nil
        followButton.layer.borderWidth = 0
        label.text = nil
        profileImageView.image = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //photo, text, follow button
        profileImageView.frame = CGRect(x: 6, y: 6, width: contentView.bounds.height-12, height: contentView.bounds.height-12)
        profileImageView.layer.cornerRadius = profileImageView.bounds.height/2.0
        
        let buttonWidth = contentView.bounds.width > 500 ? 220.0 : (contentView.bounds.width/4)-5
        let buttonX = contentView.bounds.width-buttonWidth-10
        followButton.frame = CGRect(x: buttonX, y: 12, width: buttonWidth, height: contentView.bounds.height-24)
        followButton.layer.cornerRadius = 5
        followButton.titleLabel?.font = .systemFont(ofSize: 12)
        followButton.titleLabel?.textColor = .label
        
        label.frame = CGRect(x: profileImageView.bounds.width + 15,
                             y: 0,
                             width: contentView.bounds.width-buttonWidth-profileImageView.bounds.width-14,
                             height: contentView.bounds.height )
    }
    
    
}
