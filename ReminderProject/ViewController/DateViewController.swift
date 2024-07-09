//
//  DateViewController.swift
//  ReminderProject
//
//  Created by 전준영 on 7/3/24.
//

import UIKit
import SnapKit

final class DateViewController: BaseViewController {
    
    private let datePicker = UIDatePicker()
    private let dateLabel = UILabel()
    
    let viewModel = DateViewModel()
    weak var delegate: LastDateProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindData()
    }
    
    override func configureHierarchy() {
        view.addSubview(datePicker)
        view.addSubview(dateLabel)
    }
    
    override func configureLayout() {
        
        datePicker.snp.makeConstraints { make in
            make.center.equalTo(view.safeAreaLayoutGuide)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.centerX.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(datePicker.snp.bottom).offset(20)
        }
    }
    
    override func configureView() {
        super.configureView()
        
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
        
        dateLabel.textColor = .black
        dateLabel.font = UIFont.systemFont(ofSize: 18)
        dateLabel.textAlignment = .center

    }
    
}

extension DateViewController {
    
    func bindData() {
        viewModel.outputDateString.bind { value in
            self.dateLabel.text = value
        }
        
        viewModel.outputDate.bind { value in
            if let date = value {
                self.delegate?.lastDateSet(date: date)
            }
        }
    }
    
    @objc private func datePickerValueChanged(_ sender: UIDatePicker) {
        print(sender.date)
        viewModel.inputDateTapped.value = sender.date
    }
}
