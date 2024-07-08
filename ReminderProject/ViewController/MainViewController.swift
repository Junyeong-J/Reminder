//
//  MainViewController.swift
//  ReminderProject
//
//  Created by 전준영 on 7/2/24.
//

import UIKit
import SnapKit
import RealmSwift
import FSCalendar

final class MainViewController: BaseViewController {
    
    let iconTypes: [IconTypes] = [.today, .schedule, .all, .flag, .complete]
    var list: Results<ListTable>?
    var folderList: [Folder] = []
    let repository = ListTableRepository()
    
    private let calendarView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.masksToBounds = false
        view.layer.shadowOffset = CGSize(width: 0, height: 4)
        view.layer.shadowRadius = 5
        view.layer.shadowOpacity = 0.3
        return view
    }()
    
    private lazy var calendar : FSCalendar = {
        let calendar = FSCalendar(frame: .zero)
        calendar.scope = .month
        calendar.locale = Locale(identifier: "ko_KR")
        calendar.delegate = self
        calendar.dataSource = self
        return calendar
    }()
    
    private let listView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.masksToBounds = false
        view.layer.shadowOffset = CGSize(width: 0, height: 4)
        view.layer.shadowRadius = 5
        view.layer.shadowOpacity = 0.3
        return view
    }()
    
    lazy var mainCollectionView = UICollectionView(frame: .zero, collectionViewLayout: mainCollectionViewLayout())
    
    func mainCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let sectionSpacing: CGFloat = 16
        let cellSpacing: CGFloat = 16
        let width = UIScreen.main.bounds.width - (sectionSpacing * 2) - (cellSpacing)
        layout.itemSize = CGSize(width: width/2, height: width/4)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = cellSpacing
        layout.minimumInteritemSpacing = cellSpacing
        layout.sectionInset = UIEdgeInsets(top: sectionSpacing, left: sectionSpacing, bottom: sectionSpacing, right: sectionSpacing)
        return layout
    }
    
    let listTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeNavigationUI(title: "전체")
        configureCollectionAndTable()
        
        setupToolBar()
        setupAppearance()
        setupToolBarButton()
        
        fetchList()
        repository.detectRealmURL()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mainCollectionView.reloadData()
    }
    
    override func configureHierarchy() {
        view.addSubview(mainCollectionView)
        view.addSubview(calendarView)
        calendarView.addSubview(calendar)
        view.addSubview(listView)
        listView.addSubview(listTableView)
    }
    
    override func configureLayout() {
        mainCollectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        calendarView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.size.equalTo(250)
        }
        
        calendar.snp.makeConstraints { make in
            make.edges.equalTo(calendarView.safeAreaLayoutGuide)
        }
        
        listView.snp.makeConstraints { make in
            make.top.equalTo(calendarView.snp.bottom).offset(20)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide).inset(10)
        }
        
        listTableView.snp.makeConstraints { make in
            make.edges.equalTo(listView)
        }
    }
    
    override func configureView() {
        self.calendarView.alpha = 0
        calendarView.isHidden = true
        
        self.listView.alpha = 0
        listView.isHidden = true
    }
    
}

extension MainViewController {
    
    func setupToolBarButton() {
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let newTodo = UIBarButtonItem(title: "새로운 할 일", style: .plain, target: self, action: #selector(newTodoClicked))
        let catalogAdd = UIBarButtonItem(title: "목록 추가", style: .plain, target: self, action: #selector(catalogClicked))
        let barItems = [newTodo, flexibleSpace, flexibleSpace, flexibleSpace, catalogAdd]
        self.toolbarItems = barItems
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
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "calendar"), style: .plain, target: self, action: #selector(calendarClicked))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "ellipsis.circle"),
                                                                 menu: nil)
        
        navigationItem.title = title
    }
    
    func configureCollectionAndTable() {
        mainCollectionView.delegate = self
        mainCollectionView.dataSource = self
        listTableView.delegate = self
        listTableView.dataSource = self
        
        mainCollectionView.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: MainCollectionViewCell.identifier)
        listTableView.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.identifier)
    }
    
    func fetchList() {
        folderList = repository.fetchFolder()
    }
    
    @objc func newTodoClicked() {
        let newListVC = NewListViewController()
        newListVC.delegates = self
        newListVC.viewType = .origine
        let nav = UINavigationController(rootViewController: newListVC)
        navigationController?.present(nav, animated: true)
    }
    
    @objc func catalogClicked() {
        let catalogVC = CatalogViewController()
        catalogVC.delegates = self
        let nav = UINavigationController(rootViewController: catalogVC)
        navigationController?.present(nav, animated: true)
    }
    
    @objc func calendarClicked() {
        if calendarView.isHidden {
            UIView.animate(withDuration: 0.5, animations: {
                self.calendarView.alpha = 1
            })
            calendarView.isHidden = false
        } else {
            UIView.animate(withDuration: 0.5, animations: {
                self.calendarView.alpha = 0
                self.listView.alpha = 0
            })
            calendarView.isHidden = true
            listView.isHidden = true
        }
    }
    
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return iconTypes.count
        } else {
            return folderList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.identifier, for: indexPath) as! MainCollectionViewCell
        if indexPath.section == 0 {
            cell.configureData(icon: iconTypes[indexPath.item])
        } else {
            cell.configureMyData(folderData: folderList[indexPath.item])
        }
        cell.layer.cornerRadius = 10
        cell.clipsToBounds = true
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            switch indexPath.item {
            case 0:
                let vc = AllListViewController()
                vc.viewType = .today
                navigationController?.pushViewController(vc, animated: true)
            case 1:
                let vc = AllListViewController()
                vc.viewType = .schedule
                navigationController?.pushViewController(vc, animated: true)
            case 2:
                let vc = AllListViewController()
                vc.viewType = .all
                navigationController?.pushViewController(vc, animated: true)
            case 3:
                let vc = AllListViewController()
                vc.viewType = .flag
                navigationController?.pushViewController(vc, animated: true)
            case 4:
                let vc = AllListViewController()
                vc.viewType = .complete
                navigationController?.pushViewController(vc, animated: true)
            default:
                break
            }
        } else {
            let vc = MyCatalogViewController()
            vc.folder = folderList[indexPath.item]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}

extension MainViewController: PresentProtocol{
    func presentReload() {
        fetchList()
        mainCollectionView.reloadData()
    }
}

extension MainViewController: FSCalendarDelegate, FSCalendarDataSource {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Seoul")
        _ = dateFormatter.string(from: date)
        
        let calendar = Calendar.current
        let yesterday = calendar.startOfDay(for: date)
        guard let tomorrow = calendar.date(byAdding: .day, value: 1, to: yesterday) else { return }
        list = repository.fetchItemsDate(startDate: yesterday, endDate: tomorrow)
        
        self.listView.alpha = 1
        listView.isHidden = false
        
        listTableView.reloadData()
    }
    
    
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.identifier, for: indexPath) as! MainTableViewCell
        
        let data = list?[indexPath.row]
        cell.configureData(title: data?.memoTitle ?? "", date: data?.lastDate ?? Date())
        
        return cell
    }
}
