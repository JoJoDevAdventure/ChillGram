//
//  UserFolloeTableViewCell.swift
//  ChillGram
//
//  Created by Youssef Bhl on 16/12/2021.
//

import UIKit

protocol UserFollowTableViewCellDelegate: AnyObject {
    func didTapFollowUnfollowButton(model: UserRelationship)
}

enum followState {
    case following // indicate the current user is following the other user
    case not_following // indicate the current user is NOT following the other user
}

struct UserRelationship {
    let name: String
    let username: String
    let type: followState
}


class UserFollowTableViewCell: UITableViewCell {
    static let identifier = "UserFolloeTableViewCell"
    
    weak var delegate: UserFollowTableViewCellDelegate?
    
    private var model: UserRelationship?
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .red
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let nameLabbel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.text = "Youssef"
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        return label
    }()
    
    private let usernameLabbel: UILabel = {
        let label = UILabel()
        label.text = "@Just.Joseph"
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.alpha = 0.7
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
        contentView.addSubview(nameLabbel)
        contentView.addSubview(usernameLabbel)
        contentView.addSubview(followButton)
        selectionStyle = .none
        followButton.addTarget(self,
                               action: #selector(didTapFollowUnfollowButton),
                               for: .touchUpInside)
    }
    
    @objc func didTapFollowUnfollowButton() {
        guard let model = model else {
            return
        }
        delegate?.didTapFollowUnfollowButton(model: model )
    }
    
    public func configure(with model: UserRelationship) {
        self.model = model
        nameLabbel.text = model.name
        usernameLabbel.text = model.username
        switch model.type {
        case .following :
            //show unfollow button
            followButton.setTitle("Unfollow", for: .normal)
            followButton.backgroundColor = .systemBackground
            followButton.layer.borderWidth = 1
            followButton.layer.borderColor = UIColor.secondaryLabel.cgColor
            break
        case .not_following :
                //show follow button
            followButton.setTitle("Follow", for: .normal)
            followButton.backgroundColor = .link
            followButton.layer.borderWidth = 0
            break
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        profileImageView.image = nil
        nameLabbel.text = nil
        usernameLabbel.text = nil
        followButton.layer.borderWidth = 0
        followButton.backgroundColor = .systemBlue
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        profileImageView.frame = CGRect(x: 3, y: 3, width: contentView.bounds.height-6, height: contentView.bounds.height-6)
        profileImageView.layer.cornerRadius = profileImageView.bounds.height/2.0
        
        let labelHeight = contentView.bounds.height/2
        nameLabbel.frame = CGRect(x: contentView.bounds.height + 10, y: 0, width: contentView.bounds.width, height: labelHeight)
        usernameLabbel.frame = CGRect(x: contentView.bounds.height + 10, y: 18, width: contentView.bounds.width, height: labelHeight)
        
        let buttonWidth = contentView.bounds.width > 500 ? 220.0 : (contentView.bounds.width/4)-5
        let buttonX = contentView.bounds.width-buttonWidth-10
        followButton.frame = CGRect(x: buttonX, y: 12, width: buttonWidth, height: contentView.bounds.height-24)
        followButton.layer.cornerRadius = 5
        followButton.titleLabel?.font = .systemFont(ofSize: 12)
        followButton.titleLabel?.textColor = .label
    }
}
