//
//  NewListSettingTableViewCell.swift
//  ReminderProject
//
//  Created by 전준영 on 7/2/24.
//

import UIKit
import SnapKit

final class NewListSettingTableViewCell: BaseTableViewCell {
    
    let titleLabel = UILabel()
    let contentLabel = UILabel()
    
    override func configureHierarchy() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(contentLabel)
    }
    
    override func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.safeAreaLayoutGuide)
            make.leading.equalTo(contentView.safeAreaLayoutGuide).inset(20)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.safeAreaLayoutGuide)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(20)
        }
    }
    
    override func configureView() {
        
    }
    
    func configureData(list: NewList, contentList: String){
        titleLabel.text = list.rawValue
        contentLabel.text = contentList
    }
}
