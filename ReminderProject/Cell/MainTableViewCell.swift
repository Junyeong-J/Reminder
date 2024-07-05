//
//  MainTableViewCell.swift
//  ReminderProject
//
//  Created by 전준영 on 7/5/24.
//

import UIKit
import SnapKit

class MainTableViewCell: BaseTableViewCell {
    
    let titleLabel = UILabel()
    let dateLabel = UILabel()
    
    override func configureHierarchy() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(dateLabel)
    }
    
    override func configureLayout() {
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.safeAreaLayoutGuide)
            make.leading.equalTo(contentView.safeAreaLayoutGuide).inset(10)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.safeAreaLayoutGuide)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(10)
        }
    }
    
    override func configureView() {
        
        titleLabel.textColor = .black
        titleLabel.font = .boldSystemFont(ofSize: 15)
        
        dateLabel.textColor = .gray
        dateLabel.font = .boldSystemFont(ofSize: 13)
    }
    
    func configureData(title: String, date: Date) {
        titleLabel.text = title
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
