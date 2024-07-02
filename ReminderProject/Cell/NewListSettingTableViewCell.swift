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
    
    override func configureHierarchy() {
        contentView.addSubview(titleLabel)
    }
    
    override func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.safeAreaLayoutGuide)
            make.leading.equalTo(contentView.safeAreaLayoutGuide).inset(20)
        }
    }
    
    override func configureView() {
        
    }
    
    func configureData(list: NewList){
        titleLabel.text = list.rawValue
    }
}
