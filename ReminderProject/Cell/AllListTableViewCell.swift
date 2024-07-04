//
//  AllListTableViewCell.swift
//  ReminderProject
//
//  Created by 전준영 on 7/3/24.
//

import UIKit
import SnapKit

final class AllListTableViewCell: BaseTableViewCell {
    
    let completeButton = UIButton()
    let titleLabel = UILabel()
    let contentLabel = UILabel()
    let dateLabel = UILabel()
    
    override func configureHierarchy() {
        contentView.addSubview(completeButton)
        contentView.addSubview(titleLabel)
        contentView.addSubview(contentLabel)
        contentView.addSubview(dateLabel)
    }
    
    override func configureLayout() {
        
        completeButton.snp.makeConstraints { make in
            make.leading.equalTo(contentView.safeAreaLayoutGuide).inset(20)
            make.centerY.equalTo(contentView.safeAreaLayoutGuide)
            make.size.equalTo(20)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).inset(20)
            make.leading.equalTo(completeButton.snp.trailing).offset(10)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(2)
            make.leading.equalTo(completeButton.snp.trailing).offset(10)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(contentLabel.snp.bottom).offset(2)
            make.leading.equalTo(completeButton.snp.trailing).offset(10)
        }
    }
    
    override func configureView() {
        
        completeButton.backgroundColor = .clear
        completeButton.layer.cornerRadius = 10
        completeButton.layer.borderWidth = 2
        completeButton.layer.borderColor = UIColor.orange.cgColor
        
        titleLabel.textColor = .black
        titleLabel.font = .boldSystemFont(ofSize: 16)
        contentLabel.textColor = .gray
        contentLabel.font = .boldSystemFont(ofSize: 14)
        dateLabel.textColor = .gray
        dateLabel.font = .boldSystemFont(ofSize: 14)
    }
    
    func configureData(title: String, content: String, date: Date) {
        titleLabel.text = title
        contentLabel.text = content
        dateLabel.text = updateDateLabel(date: date)
    }
    
    private func updateDateLabel(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = "yyyy.MM.dd (EEEE)"
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
    
}
