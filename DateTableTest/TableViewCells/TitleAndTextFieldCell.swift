//
//  TitleAndTextFieldCell.swift
//  Keep-a-Record
//
//  Created by Isha Dua on 06/05/20.
//  Copyright © 2020 Isha Dua. All rights reserved.
//

import UIKit

class TitleAndTextFieldCell: UITableViewCell {
    
    private lazy var textField = UITextField()
    
    var isInputEnabled: Bool = false {
        didSet {
            textField.isUserInteractionEnabled = isInputEnabled
            if isInputEnabled {
                textField.becomeFirstResponder()
            } else {
                textField.resignFirstResponder()
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        createViews()
    }
    
    private func createViews() {
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = self
        textField.isUserInteractionEnabled = false
        
        contentView.addSubview(textField)
        
        let constraints: [NSLayoutConstraint] = [
            textField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),

            textField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            textField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            textField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
        ]
                        
        NSLayoutConstraint.activate(constraints)
    }
    
    func dismissKeyBoard() {
        textField.resignFirstResponder()
    }
    
    func configure(title: String, placeholder: String, value: String?, textFieldTarget: TargetAction) {
        textField.text = value
        textField.placeholder = placeholder
        textField.addTarget(textFieldTarget.target, action: textFieldTarget.action, for: textFieldTarget.event)
    }
        
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TitleAndTextFieldCell: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becomeFirstResponder()
    }
    
    /// Validadation of textfield text. Textfield's first character should not be a whitespace or a new line
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let firstCharacter = string.first
        if (firstCharacter == " " || firstCharacter == "\n") && (textField.text?.isEmpty == true) {
            textField.text = ""
            return false
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

