//
//  DetailViewController.swift
//  ReminderProject
//
//  Created by 전준영 on 7/8/24.
//

import UIKit
import SnapKit

class DetailViewController: BaseViewController {
    
    let titleLabel = UILabel()
    let memoLabel = UILabel()
    let dateLabel = UILabel()
    let tagLabel = UILabel()
    let imageView = UIImageView()
    let deleteButton = UIButton()
    
    var listItems: ListTable? {
        didSet{
            configureData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureHierarchy() {
        view.addSubview(titleLabel)
        view.addSubview(memoLabel)
        view.addSubview(dateLabel)
        view.addSubview(tagLabel)
        view.addSubview(imageView)
        view.addSubview(deleteButton)
    }
    
    override func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.top.leading.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        memoLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(3)
            make.leading.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(memoLabel.snp.bottom).offset(3)
            make.leading.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        tagLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(3)
            make.leading.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        imageView.snp.makeConstraints { make in
            make.top.equalTo(tagLabel.snp.bottom).offset(3)
            make.leading.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.size.equalTo(80)
        }
        
        deleteButton.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(44)
        }
    }
    
    override func configureView() {
        super.configureView()
        
        deleteButton.setTitle("삭제", for: .normal)
        deleteButton.setTitleColor(.white, for: .normal)
        deleteButton.backgroundColor = .red
    }
}

extension DetailViewController {
    
    func configureData() {
        guard let listItems = listItems else { return }
        titleLabel.text = listItems.memoTitle
        memoLabel.text = listItems.content
        dateLabel.text = updateDateLabel(date: listItems.lastDate ?? Date())
        tagLabel.text = listItems.tag
        imageView.image = loadImageToDocument(filename: "\(listItems.id)")
    }
    
}
