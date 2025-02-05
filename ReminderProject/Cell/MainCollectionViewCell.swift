//
//  MainCollectionViewCell.swift
//  ReminderProject
//
//  Created by 전준영 on 7/2/24.
//

import UIKit
import SnapKit

final class MainCollectionViewCell: BaseCollectionViewCell {
    
    var iconImageView = IconImage()
    let titleLabel = UILabel()
    let countLabel = UILabel()
    
    override func configureHierarchy() {
        contentView.addSubview(iconImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(countLabel)
    }
    
    override func configureLayout() {
        iconImageView.snp.makeConstraints { make in
            make.top.leading.equalTo(contentView.safeAreaLayoutGuide).inset(10)
            make.size.equalTo(34)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.bottom.equalTo(contentView.safeAreaLayoutGuide).inset(10)
        }
        
        countLabel.snp.makeConstraints { make in
            make.top.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(10)
        }
    }
    
    override func configureUI() {
        contentView.backgroundColor = .gray
        titleLabel.textColor = .white
        titleLabel.font = .systemFont(ofSize: 17)
        
        countLabel.textColor = .white
        countLabel.font = .boldSystemFont(ofSize: 22)
    }
    
    func configureData(icon: IconTypes) {
        iconImageView.image = UIImage(systemName: icon.setImages())
        iconImageView.backgroundColor = icon.setColor()
        titleLabel.text = icon.rawValue
        countLabel.text = "\(icon.getCount())"
    }
    
    func configureMyData(folderData: Folder) {
        iconImageView.image = UIImage(systemName: "star")
        iconImageView.backgroundColor = .systemCyan
        titleLabel.text = folderData.name
        countLabel.text = "\(folderData.detail.count)"
    }
}
