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
    
    var viewType: IconTypes?
    
    let tableView = UITableView()
    var list: Results<ListTable>!
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeNavigationUI(title: viewType?.rawValue ?? "")
        filterList()
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

extension AllListViewController {
    func filterList(){
        switch viewType {
        case .today:
            list = realm.objects(ListTable.self).where {
                $0.lastDate == todayDate()
            }
        case .schedule:
            list = realm.objects(ListTable.self)
        case .all:
            list = realm.objects(ListTable.self)
        case .flag:
            list = realm.objects(ListTable.self).where {
                $0.flag == true
            }
        case .complete:
            list = realm.objects(ListTable.self)
        default:
            break
        }
        
    }
    
    func todayDate() -> String {
        var dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = "yyyy.MM.dd (EEEE)"
        var currentDateString = dateFormatter.string(from: Date())
        return currentDateString
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
        
        let flagAction = UIContextualAction(style: .normal, title: "깃발") { (action, view, completionHandler) in
            let listTable = self.list[indexPath.row]
            let realm = try! Realm()
            try! realm.write {
                listTable.flag = !(listTable.flag ?? false)
            }
            tableView.reloadData()
            completionHandler(true)
        }
        flagAction.backgroundColor = .orange
        
        let configuration = UISwipeActionsConfiguration(actions: [delete, flagAction])
        return configuration
    }
    
}
