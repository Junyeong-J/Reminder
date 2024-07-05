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
    let photoImageView = UIImageView()
    
    override func configureHierarchy() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(contentLabel)
        contentView.addSubview(photoImageView)
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
        
        photoImageView.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.safeAreaLayoutGuide)
            make.size.equalTo(80)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(10)
        }
    }
    
    override func configureView() {
        photoImageView.contentMode = .scaleAspectFill
        photoImageView.layer.cornerRadius = 10
        photoImageView.clipsToBounds = true
        photoImageView.isHidden = true
    }
    
    func configureData(list: NewList, contentList: String, image: UIImage?){
        titleLabel.text = list.rawValue
        contentLabel.text = contentList
        
        if let image = image {
            photoImageView.image = image
            photoImageView.isHidden = false
        } else {
            photoImageView.isHidden = true
        }
    }
}
