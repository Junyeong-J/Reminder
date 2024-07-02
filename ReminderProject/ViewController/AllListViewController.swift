//
//  AllListViewController.swift
//  ReminderProject
//
//  Created by 전준영 on 7/3/24.
//

import UIKit
import SnapKit
import RealmSwift

final class AllListViewController: BaseViewController {
    
    let tableView = UITableView()
    var list: Results<ListTable>!
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeNavigationUI()
        list = realm.objects(ListTable.self)
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
        
        tableView.rowHeight = 100
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AllListTableViewCell.self, forCellReuseIdentifier: AllListTableViewCell.identifier)
    }
    
}

extension AllListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AllListTableViewCell.identifier) as! AllListTableViewCell
        let data = list[indexPath.row]
        cell.configureData(title: data.memoTitle, content: data.content ?? "", date: data.lastDate ?? "")
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "삭제") { (action, view, completionHandler) in
            try! self.realm.write {
                self.realm.delete(self.list[indexPath.row])
            }
            tableView.reloadData()
            completionHandler(true)
        }
        let configuration = UISwipeActionsConfiguration(actions: [delete])
        configuration.performsFirstActionWithFullSwipe = true
        return configuration
    }
    
}
