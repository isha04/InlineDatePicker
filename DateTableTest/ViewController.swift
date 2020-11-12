//
//  ViewController.swift
//  DateTableTest
//
//  Created by Isha Dua on 04/11/20.
//

import UIKit

class ViewController: UITableViewController {
    
    private var data: [Input] = [
        Input(title: "Name", placeholder: "Enter Name", detail: "Isha"),
        Input(title: "Start Date", placeholder: "None", detail: "9/10/2020"),
        Input(title: "End Date", placeholder: "None", detail: "8/10/2020"),
        Input(title: "End Date", placeholder: "None", detail: "8/10/2020")
    ]
    
    private var selectedDatePickerIndexPath: IndexPath? = nil
    lazy var dateformatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.register(TitleAndTextFieldCell.self, forCellReuseIdentifier: "TitleAndTextFieldCell")
        tableView.register(DateTableViewCell.self, forCellReuseIdentifier: "NewDateTableViewCell")
        tableView.register(DatePickerTableViewCell.self, forCellReuseIdentifier: "DatePickerTableViewCell")
        tableView.register(TextViewTableViewCell.self, forCellReuseIdentifier: "TextViewTableViewCell")

        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(endEditing))
        self.tableView.addGestureRecognizer(tapGesture)
        tapGesture.cancelsTouchesInView = false
    }
    
    @objc private func endEditing() {
        view.endEditing(true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if selectedDatePickerIndexPath != nil {
            return data.count + 1
        }
        
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let selector = #selector(self.titleTextFieldChanged(_:))
            let cell = tableView.dequeueReusableCell(withIdentifier: "TitleAndTextFieldCell") as! TitleAndTextFieldCell
            cell.configure(title: data[0].title, placeholder: "Enter text", value: data[0].detail, textFieldTarget: (self, selector, .editingChanged))
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewDateTableViewCell") as! DateTableViewCell
            cell.configure(title: data[1].title, placeholder: data[1].placeholder, date: data[1].detail)
            return cell
        case 2:
            if selectedDatePickerIndexPath == nil {
                let cell = tableView.dequeueReusableCell(withIdentifier: "NewDateTableViewCell") as! DateTableViewCell
                cell.configure(title: data[2].title, placeholder: data[2].placeholder, date: data[2].detail)
                return cell
            }
        case 3:
            if selectedDatePickerIndexPath == nil {
                let cell = tableView.dequeueReusableCell(withIdentifier: "TextViewTableViewCell") as! TextViewTableViewCell
                return cell
            }
        default:
            break
        }
        
        
        if selectedDatePickerIndexPath != nil  && selectedDatePickerIndexPath?.row == indexPath.row {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DatePickerTableViewCell") as! DatePickerTableViewCell
            cell.configure(datePickerTarget: (self, #selector(self.dateChanged(_:)), .valueChanged))
            return cell
        } else if selectedDatePickerIndexPath != nil  && selectedDatePickerIndexPath!.row - 1 == indexPath.row {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewDateTableViewCell") as! DateTableViewCell
            let cellData = data[selectedDatePickerIndexPath!.row - 1]
            cell.configure(title: cellData.title, placeholder: cellData.placeholder, date: cellData.detail)
            return cell
        }
        return UITableViewCell()
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        view.endEditing(true)
        
        tableView.beginUpdates()
        
        let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? TitleAndTextFieldCell
        
        
        if indexPath.row == 0 {
            cell?.isInputEnabled = true
        } else {
            cell?.isInputEnabled = false
        }
    
        if selectedDatePickerIndexPath != nil && ((selectedDatePickerIndexPath!.row - 1 == indexPath.row) || (indexPath.row == 0)) || (indexPath.row == 4) {
            // Datepicker is there. If the row just before the datepicker is tapped or 1st and last row are tapped, datepicker needs to be removed
            tableView.deleteRows(at: [selectedDatePickerIndexPath!], with: .fade)
            selectedDatePickerIndexPath = nil
        } else if selectedDatePickerIndexPath != nil && indexPath.row > 0 && indexPath.row < 4 {
            // Datepicker is there. If start/end date rows are tapped, we need to remove the datepicer and insert at new indexpath
            tableView.deleteRows(at: [selectedDatePickerIndexPath!], with: .fade)
            selectedDatePickerIndexPath = calculateDatePickerIndexPath(indexPathSelected: indexPath)
            tableView.insertRows(at: [selectedDatePickerIndexPath!], with: .fade)
        } else if selectedDatePickerIndexPath == nil && indexPath.row > 0 && indexPath.row < 3 {
            // There is no datepicker cell.Insert datepicker cell only if cells except the textfield and textview are tapped
            selectedDatePickerIndexPath = calculateDatePickerIndexPath(indexPathSelected: indexPath)
            tableView.insertRows(at: [selectedDatePickerIndexPath!], with: .fade)
        }
        
        
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.endUpdates()
    }
    
    func calculateDatePickerIndexPath(indexPathSelected: IndexPath) -> IndexPath {
        if selectedDatePickerIndexPath != nil && selectedDatePickerIndexPath!.row  <= indexPathSelected.row {
            // Will be calculated after deleting the previous datepickerRow. That is the assumption of this code.
            return IndexPath(row: indexPathSelected.row, section: 0)
        } else {
            return IndexPath(row: indexPathSelected.row + 1, section: 0)
        }
    }
}

extension ViewController: InputFieldActionProtocol {
    @objc func titleTextFieldChanged(_ sender: UITextField) {
        data[0].detail = sender.text
    }
    
    @objc func dateChanged(_ sender: UIDatePicker) {
        dateformatter.dateStyle = .medium
        if selectedDatePickerIndexPath?.row == 2 {
            data[1].detail = dateformatter.string(from: sender.date)
            tableView.reloadRows(at: [IndexPath(row: 1, section: 0)], with: .none)
        } else if selectedDatePickerIndexPath?.row == 3 {
            data[2].detail = dateformatter.string(from: sender.date)
            tableView.reloadRows(at: [IndexPath(row: 2, section: 0)], with: .none)
        }
    }
}
