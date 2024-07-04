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
    
    weak var delegate: LastDateProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        
        updateDateLabel(date: datePicker.date)
    }
    
    @objc private func datePickerValueChanged(_ sender: UIDatePicker) {
        updateDateLabel(date: sender.date)
    }
    
    private func updateDateLabel(date: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = "yyyy.MM.dd (EEEE)"
        let dateString = dateFormatter.string(from: date)
        dateLabel.text = dateString
        delegate?.lastDateSet(date: date)
    }
}

