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
    let priorityLabel = UILabel()
    let titleLabel = UILabel()
    let contentLabel = UILabel()
    let dateLabel = UILabel()
    let hashTagLabel = UILabel()
    
    override func configureHierarchy() {
        contentView.addSubview(completeButton)
        contentView.addSubview(priorityLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(contentLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(hashTagLabel)
    }
    
    override func configureLayout() {
        
        completeButton.snp.makeConstraints { make in
            make.leading.equalTo(contentView.safeAreaLayoutGuide).inset(20)
            make.centerY.equalTo(contentView.safeAreaLayoutGuide)
            make.size.equalTo(20)
        }
        
        priorityLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).inset(20)
            make.leading.equalTo(completeButton.snp.trailing).offset(10)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).inset(20)
            make.leading.equalTo(priorityLabel.snp.trailing).offset(1)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(2)
            make.leading.equalTo(completeButton.snp.trailing).offset(10)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(contentLabel.snp.bottom).offset(2)
            make.leading.equalTo(completeButton.snp.trailing).offset(10)
        }
        
        hashTagLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel)
            make.leading.equalTo(dateLabel.snp.trailing).offset(1)
        }
    }
    
    override func configureView() {
        
        completeButton.backgroundColor = .clear
        completeButton.layer.cornerRadius = 10
        completeButton.layer.borderWidth = 2
        completeButton.layer.borderColor = UIColor.orange.cgColor
        
        priorityLabel.textColor = .blue
        priorityLabel.font = .boldSystemFont(ofSize: 14)
        titleLabel.textColor = .black
        titleLabel.font = .boldSystemFont(ofSize: 16)
        contentLabel.textColor = .gray
        contentLabel.font = .boldSystemFont(ofSize: 14)
        dateLabel.textColor = .gray
        dateLabel.font = .boldSystemFont(ofSize: 14)
        
        hashTagLabel.textColor = .blue
        hashTagLabel.font = .boldSystemFont(ofSize: 14)
    }
    
    func configureData(data: ListTable) {
        priorityLabel.text = setPriority(priority: data.priority ?? 0)
        titleLabel.text = data.memoTitle
        contentLabel.text = data.content
        dateLabel.text = updateDateLabel(date: data.lastDate)
        hashTagLabel.text = hashTagSet(tag: data.tag)
        
        if let completed = data.completed {
            if completed {
                completeButton.backgroundColor = .orange
            } else {
                completeButton.backgroundColor = .clear
                completeButton.layer.cornerRadius = 10
                completeButton.layer.borderWidth = 2
                completeButton.layer.borderColor = UIColor.orange.cgColor
            }
        } else {
            completeButton.backgroundColor = .clear
            completeButton.layer.cornerRadius = 10
            completeButton.layer.borderWidth = 2
            completeButton.layer.borderColor = UIColor.orange.cgColor
        }
        
    }
    
    private func updateDateLabel(date: Date?) -> String {
        guard let date = date else {
            return ""
        }
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = "yyyy.MM.dd (EEEE)"
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
    
    private func hashTagSet(tag: String?) -> String {
        guard let tags = tag, !tags.isEmpty else {
            return ""
        }
        return "#\(tags)"
    }
    
    private func setPriority(priority: Int) -> String {
        
        switch priority {
        case 1:
            return "!!!"
        case 2:
            return "!!"
        case 3:
            return "!"
        default:
            return ""
        }
        
    }
    
}
