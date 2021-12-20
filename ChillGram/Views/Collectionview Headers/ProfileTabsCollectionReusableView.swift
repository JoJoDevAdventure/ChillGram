//
//  ProfileTabsCollectionReusableView.swift
//  ChillGram
//
//  Created by Youssef Bhl on 07/12/2021.
//

import UIKit

protocol ProfileTabsCollectionReusableViewDelegate: AnyObject {
    func didTapGridButton()
    func didTapTaggedButton()
}

    class ProfileTabsCollectionReusableView: UICollectionReusableView {
    static let identifier = "ProfileTabsCollectionReusableView"
    
    public weak var delegate: ProfileTabsCollectionReusableViewDelegate?
    
    private let gridButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.tintColor = .systemBlue
        button.setBackgroundImage(UIImage(systemName: "square.grid.2x2"), for: .normal)
        return button
    }()
    
    private let taggedButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.tintColor = .tertiaryLabel
        button.setBackgroundImage(UIImage(systemName: "tag"), for: .normal)
        return button
    }()
        
    private let view: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.alpha = 0.30
        view.layer.cornerRadius = 1
        view.backgroundColor = .secondaryLabel
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        addSubview(gridButton)
        addSubview(taggedButton)
        addSubview(view)
        
        gridButton.addTarget(self,
                             action: #selector(didTapGridButton),
                             for: .touchUpInside)
        
        taggedButton.addTarget(self,
                             action: #selector(didTapTaggedButton),
                             for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let size = bounds.height-20
        let HalfWidth = ((bounds.width/2)-size)/2
        let barWidth = bounds.width-6
        
        gridButton.frame = CGRect(x: HalfWidth, y: 9, width: size, height: size)

        taggedButton.frame = CGRect(x: HalfWidth + bounds.width/2, y: 9, width: size, height: size)
        
        view.frame = CGRect(x: 3, y: 0, width: barWidth, height: 1)
    }
        
    @objc private func didTapGridButton(){
        gridButton.tintColor = .systemBlue
        taggedButton.tintColor = .secondaryLabel
        delegate?.didTapGridButton()
        }
        
    @objc private func didTapTaggedButton(){
        gridButton.tintColor = .secondaryLabel
        taggedButton.tintColor = .systemBlue
        delegate?.didTapTaggedButton()
        }
        
}
