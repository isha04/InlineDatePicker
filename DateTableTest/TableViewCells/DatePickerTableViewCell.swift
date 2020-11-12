//
//  DatePickerTableViewCell.swift
//  DateTableTest
//
//  Created by Isha Dua on 06/11/20.
//

import UIKit

class DatePickerTableViewCell: UITableViewCell {

    private lazy var datePicker = UIDatePicker()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        createViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(datePickerTarget: TargetAction) {
        datePicker.addTarget(datePickerTarget.target, action: datePickerTarget.action, for: datePickerTarget.event)
        
    }
    
    private func createViews() {
        contentView.addSubview(datePicker)
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        
        
        if #available(iOS 14.0, *) {
            datePicker.preferredDatePickerStyle = .inline
        }
        
        NSLayoutConstraint.activate([
            datePicker.topAnchor.constraint(equalTo: contentView.topAnchor),
            datePicker.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            datePicker.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            datePicker.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

}
