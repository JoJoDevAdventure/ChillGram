//
//  PhotosCollectionViewCell.swift
//  ChillGram
//
//  Created by Youssef Bhl on 07/12/2021.
//

import UIKit
import SDWebImage

class PhotosCollectionViewCell: UICollectionViewCell {
    static let identifier = "PhotosCollectionViewCell"
    
    private let photosImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
        
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        photosImageView.frame = contentView.bounds
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        photosImageView.image = nil
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubview(photosImageView)
        contentView.clipsToBounds = true
        accessibilityHint = "double tap to open post"
        accessibilityLabel = "user post image"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with model: UserPost) {
        let url = model.thunmbnailImage
        photosImageView.sd_setImage(with: url, completed: nil)
    }
    
    public func configure(debug imageName: String) {
        photosImageView.image = UIImage(named: imageName)
    }
    
}
