//
//  NewListTableViewCell.swift
//  ReminderProject
//
//  Created by 전준영 on 7/2/24.
//

import UIKit
import SnapKit

final class NewListTitleTableViewCell: BaseTableViewCell {
    
    weak var delegate: TitleProtocol?
    
    let textView = UIView()
    let titleTextField = UITextField()
    let memoTextField = UITextField()
    
    override func configureHierarchy() {
        contentView.addSubview(textView)
        textView.addSubview(titleTextField)
        textView.addSubview(memoTextField)
        
        titleTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        memoTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
    }
    
    override func configureLayout() {
        textView.snp.makeConstraints { make in
            make.top.bottom.equalTo(contentView.safeAreaLayoutGuide).inset(5)
            make.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(10)
        }
        
        titleTextField.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(textView)
            make.height.equalTo(44)
        }
        
        memoTextField.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom)
            make.horizontalEdges.bottom.equalTo(textView)
        }
        
    }
    
    override func configureView() {
        textView.backgroundColor = .red
        titleTextField.backgroundColor = .blue
        memoTextField.backgroundColor = .brown
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        delegate?.titleOrContentSet(title: titleTextField.text ?? "", content: memoTextField.text ?? "")
    }
    
}
