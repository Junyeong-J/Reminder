//
//  TagViewController.swift
//  ReminderProject
//
//  Created by 전준영 on 7/3/24.
//

import UIKit
import SnapKit

final class TagViewController: BaseViewController {
    
    let tagTextField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureHierarchy() {
        view.addSubview(tagTextField)
    }
    
    override func configureLayout() {
        tagTextField.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(50)
        }
    }
    
    override func configureView() {
        super.configureView()
        tagTextField.placeholder = "태그 단어를 입력해주세요."
        tagTextField.borderStyle = .line
        
    }
    
}
