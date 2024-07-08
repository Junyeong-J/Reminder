//
//  CatalogViewController.swift
//  ReminderProject
//
//  Created by 전준영 on 7/8/24.
//

import UIKit
import SnapKit

class CatalogViewController: BaseViewController {
    
    let repository = ListTableRepository()
    weak var delegates: PresentProtocol?
    let textField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newListNaviUI()
    }
    
    override func configureHierarchy() {
        view.addSubview(textField)
    }
    
    override func configureLayout() {
        textField.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.height.equalTo(44)
        }
    }
    
    override func configureView() {
        super.configureView()
        
        textField.placeholder = "목록 제목"
        textField.layer.borderColor = UIColor.systemGray.cgColor
        textField.layer.cornerRadius = 5
        textField.layer.borderWidth = 0.5
    }
    
}

extension CatalogViewController {
    
    private func newListNaviUI() {
        self.title = "새로운 목록"
        
        let cancel = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(cancelTapped))
        navigationItem.leftBarButtonItem = cancel
        
        let add = UIBarButtonItem(title: "추가", style: .plain, target: self, action: #selector(addTapped))
        navigationItem.rightBarButtonItem = add
    }
    
    @objc private func cancelTapped() {
        dismiss(animated: true)
    }
    
    @objc private func addTapped() {
        if let catalogText = textField.text {
            let data = Folder(name: catalogText)
            repository.createCatalog(data)
        }
        
        delegates?.presentReload()
        dismiss(animated: true)
    }
    
}
