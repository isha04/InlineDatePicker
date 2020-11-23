//
//  ButtonTableViewCell.swift
//  DateTableTest
//
//  Created by Isha Dua on 17/11/20.
//

import UIKit

class ButtonTableViewCell: UITableViewCell {
    
    lazy var button = UIButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        createViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createViews() {
        contentView.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            button.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            button.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
        
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        button.backgroundColor = .systemGray3
        button.titleLabel?.textColor = .black
    }
    
    func configure(title: String) {
        button.setTitle(title, for: .normal)
    }
    
    @objc private func buttonTapped() {
        print("button was tapped: \(button.title(for: .normal))")
    }
    

}
