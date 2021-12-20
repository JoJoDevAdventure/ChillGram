//
//  NotificationsLikeTableViewCell.swift
//  ChillGram
//
//  Created by Youssef Bhl on 17/12/2021.
//

import SDWebImage
import UIKit

protocol NotificationsLikeTableViewCellDelegate: AnyObject {
    func didTapRelatedPostButton(model: UserNotification)
}

class NotificationsLikeTableViewCell: UITableViewCell {
    static let identifier = "NotificationsLikeTableViewCell"
    
    weak var delegate: NotificationsLikeTableViewCellDelegate?
    private var model : UserNotification?
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .red
        return imageView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 0
        label.text = "@Joseph liked your photo."
        return label
    }()
    
    private let postButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "test"), for: .normal)
        button.backgroundColor = .link
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        contentView.addSubview(profileImageView)
        contentView.addSubview(label)
        contentView.addSubview(postButton)
        selectionStyle = .none
        postButton.addTarget(self,
                             action: #selector(didTapImageButton), for: .touchUpInside)
    }
    
    @objc private func didTapImageButton() {
        guard let model = model else {
            return
        }
        delegate?.didTapRelatedPostButton(model: model)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with model: UserNotification) {
        self.model = model
        switch model.type {
        case .like(let post):
            let thunbnail = post.thunmbnailImage
            guard !thunbnail.absoluteString.contains("google.com") else {
                return
            }
            postButton.sd_setBackgroundImage(with: thunbnail, for: .normal, completed: nil)
        case .follow :
            break
        }
        label.text = model.text
        profileImageView.sd_setImage(with: model.user.profilePicture, completed: nil)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        postButton.setBackgroundImage(nil, for: .normal)
        label.text = nil
        profileImageView.image = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //photo, text, post button
        profileImageView.frame = CGRect(x: 6, y: 6, width: contentView.bounds.height-12, height: contentView.bounds.height-12)
        profileImageView.layer.cornerRadius = profileImageView.bounds.height/2.0
        
        let size = contentView.bounds.height-4
        postButton.frame = CGRect(x: contentView.bounds.width-size-8,
                                  y: 2,
                                  width: size,
                                  height: size)
        
        label.frame = CGRect(x: profileImageView.bounds.width + 15,
                             y: 0,
                             width: contentView.bounds.width-size-profileImageView.bounds.width-6,
                             height: contentView.bounds.height )
    }
}
