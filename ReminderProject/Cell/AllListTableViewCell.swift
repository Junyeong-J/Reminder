//
//  AllListTableViewCell.swift
//  ReminderProject
//
//  Created by 전준영 on 7/3/24.
//

import UIKit
import SnapKit

final class AllListTableViewCell: BaseTableViewCell {
 
    let titleLabel = UILabel()
    let contentLabel = UILabel()
    
    override func configureHierarchy() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(contentLabel)
    }
    
    override func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.top.leading.equalTo(contentView.safeAreaLayoutGuide).inset(20)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(2)
            make.leading.equalTo(contentView.safeAreaLayoutGuide).inset(20)
        }
    }
    
    override func configureView() {
        titleLabel.textColor = .black
        titleLabel.font = .boldSystemFont(ofSize: 16)
        titleLabel.textColor = .gray
        titleLabel.font = .boldSystemFont(ofSize: 14)
    }
    
    func configureData(title: String, content: String) {
        titleLabel.text = title
        contentLabel.text = content
    }
}
