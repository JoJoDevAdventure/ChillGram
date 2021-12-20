//
//  FormTableViewCell.swift
//  ChillGram
//
//  Created by Youssef Bhl on 04/12/2021.
//

import UIKit

protocol FormTableViewCellDelegate: AnyObject {
    func formTableViewCell(_ cell: FormTableViewCell, didUpdateField updatedModel : EditProfileFormModel )
}

class FormTableViewCell: UITableViewCell, UITextFieldDelegate {
    
    static let identifier = "FormTableViewCell"
    public weak var delegate: FormTableViewCellDelegate?
    private var model : EditProfileFormModel?
    private let formLabel: UILabel = {
        
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 1
        return label
    }()

    private let field: UITextField = {
        let field = UITextField()
        field.returnKeyType = .done
        return field
    }()

    override func layoutSubviews() {
        super.layoutSubviews()
        //Assign frames
        formLabel.frame = CGRect(x: 10, y: 0, width: contentView.bounds.width/3, height: contentView.bounds.height)
        field.frame = CGRect(x: 130, y: 0, width: contentView.bounds.width/3, height: contentView.bounds.height)
        
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        clipsToBounds = true
        contentView.addSubview(formLabel)
        contentView.addSubview(field)
        
        /*field.leftAnchor.constraint(equalTo: formLabel.rightAnchor, constant: 100).isActive = true
        field.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        field.heightAnchor.constraint(equalTo: contentView.heightAnchor).isActive = true
        
        formLabel.leftAnchor.constraint(equalTo: contentView.rightAnchor, constant: 5).isActive = true
        formLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor ).isActive = true
        formLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor ).isActive = true*/
        
        field.delegate = self
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with model: EditProfileFormModel) {
        self.model = model
        formLabel.text = model.label
        field.placeholder = model.placeHolder
        field.text = model.value
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        formLabel.text = nil
        field.placeholder = nil
        field.text = nil
    }
    
    //MARK: Field
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        model?.value = textField.text
        guard let model = model else {
            return true
        }
        delegate?.formTableViewCell(self, didUpdateField: model)
        textField.resignFirstResponder()
        return true
    }
}
