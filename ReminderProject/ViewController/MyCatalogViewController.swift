//
//  MyCatalogViewController.swift
//  ReminderProject
//
//  Created by 전준영 on 7/8/24.
//

import UIKit
import SnapKit

class MyCatalogViewController: BaseViewController {
    
    let tableView = UITableView()
    
    var folder: Folder?
    var list: [ListTable] = []
    let repository = ListTableRepository()
    weak var delegates: PresentProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        naviUI()
        
        if let folder = folder {
            let value = folder.detail
            list = Array(value)
        }
    }
    
    override func configureHierarchy() {
        view.addSubview(tableView)
    }
    
    override func configureLayout() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        super.configureView()
        tableView.rowHeight = 130
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AllListTableViewCell.self, forCellReuseIdentifier: AllListTableViewCell.identifier)
    }
    
}

extension MyCatalogViewController {
    func naviUI() {
        if let folder = folder {
            navigationItem.title = folder.name
        }
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "ellipsis.circle"),
                                                                 menu: UIMenu(title: "", options: [], children: [
                                                                    UIAction(title: "메뉴 추가", image: UIImage(systemName: "plus"), handler: { _ in
                                                                        self.rightBarButtonItemClicked()
                                                                    }),
                                                                    UIAction(title: "삭제", image: UIImage(systemName: "trash"), handler: { _ in
                                                                        self.deleteFolder()
                                                                    })
                                                                 ]))
    }
    
    @objc func rightBarButtonItemClicked() {
        let vc = NewListViewController()
        vc.delegates = self
        vc.viewType = .myCatalog
        vc.folder = folder
        let nav = UINavigationController(rootViewController: vc)
        navigationController?.present(nav, animated: true)
    }
    
    @objc func deleteFolder() {
        guard let folder = folder else { return }
        repository.deleteMyFolder(folder)
        navigationController?.popViewController(animated: true)
    }



}

extension MyCatalogViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AllListTableViewCell.identifier) as! AllListTableViewCell
        let data = list[indexPath.row]
        cell.configureData(data: data)
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "삭제") { (action, view, completionHandler) in
            let itemData = self.list[indexPath.row]
            self.removeImageFromDocument(filename: "\(itemData.id)")
            if let folder = self.folder {
                self.repository.deleteItemList(itemData, folder: folder)
            } else {
                print("folder Error")
            }
            
            self.list.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
            completionHandler(true)
        }
        
        let configuration = UISwipeActionsConfiguration(actions: [delete])
        return configuration
    }
    
    
}

extension MyCatalogViewController: PresentProtocol{
    func presentReload() {
        if let folder = folder {
            let value = folder.detail
            list = Array(value)
        }
        tableView.reloadData()
    }
}
