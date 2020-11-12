//
//  NewDateTableViewCell.swift
//  DateTableTest
//
//  Created by Isha Dua on 04/11/20.
//

import UIKit

class DateTableViewCell: UITableViewCell {
    
    private lazy var titleTextLabel = UILabel()
    private lazy var dateLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        createViews()
    }
    
    private func createViews() {
        contentView.addSubview(titleTextLabel)
        contentView.addSubview(dateLabel)
        
        titleTextLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            titleTextLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            titleTextLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleTextLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            
            dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
//            dateLabel.leadingAnchor.constraint(equalTo: titleTextLabel.trailingAnchor, constant: 30),
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func configure(title: String, placeholder: String, date: String?) {
        titleTextLabel.text = title
        if let d = date {
            dateLabel.text = d
        } else {
            dateLabel.text = placeholder
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
