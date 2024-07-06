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
        list = viewType?.getFilter()
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
    
    private func sortList(title: String) {
        
        switch title {
        case "마감일순":
            list = list.filter("lastDate != nil").sorted(byKeyPath: "lastDate", ascending: true)
        case "제목순":
            list = list.sorted(byKeyPath: "memoTitle", ascending: true)
        case "우선순위 낮음만":
            list = list.filter("priority == 3")
        default:
            list = list.sorted(byKeyPath: "lastDate", ascending: true)
        }
        
        tableView.reloadData()
    }
    
    func makeNavigationUI(title: String) {
        navigationController?.isNavigationBarHidden = false
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithTransparentBackground()
        navigationBarAppearance.backgroundColor = .white
        
        UINavigationBar.appearance().standardAppearance = navigationBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
        
        navigationController?.navigationBar.standardAppearance = navigationBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navigationBarAppearance
        navigationController?.navigationBar.compactAppearance = navigationBarAppearance
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .darkGray
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "ellipsis.circle"),
                    menu: UIMenu(title: "", options: [], children: [
                    UIAction(title: "마감일순", image: UIImage(systemName: "calendar.badge.clock"), handler: { _ in
                        self.sortList(title: "마감일순")
                    }),
                    UIAction(title: "제목순", image: UIImage(systemName: "note.text"), handler: { _ in
                        self.sortList(title: "제목순")
                    }),
                    UIAction(title: "우선순위 낮음만", image: UIImage(systemName: "arrowshape.down"), handler: { _ in
                        self.sortList(title: "우선순위 낮음만")
                    })
                ]))
        
        navigationItem.title = title
    }
}

extension AllListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AllListTableViewCell.identifier) as! AllListTableViewCell
        cell.completeButton.tag = indexPath.row
        cell.configureData(data: list[indexPath.row])
        cell.completeButton.addTarget(self, action: #selector(completeButtonClicked), for: .touchUpInside)
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
            try! self.realm.write {
                listTable.flag = !(listTable.flag ?? false)
            }
            tableView.reloadData()
            completionHandler(true)
        }
        flagAction.backgroundColor = .orange
        
        let configuration = UISwipeActionsConfiguration(actions: [delete, flagAction])
        return configuration
    }
    
    @objc func completeButtonClicked(_ sender: UIButton) {
        let listTable = self.list[sender.tag]
        try! self.realm.write {
            listTable.completed = !(listTable.completed ?? false)
        }
        tableView.reloadData()
    }
    
}
