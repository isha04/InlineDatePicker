//
//  TextFieldActionProtocol.swift
//  DateTableTest
//
//  Created by Isha Dua on 10/11/20.
//

import UIKit

public typealias TargetAction = (target: Any?, action: Selector, event: UIControl.Event)

/// Protocol to get textField changes from views inside ViewController
@objc protocol InputFieldActionProtocol: class {
    @objc optional func titleTextFieldChanged(_ sender: UITextField)
    @objc optional func dateChanged(_ sender: UIDatePicker)
}
