//
//  MainViewController.swift
//  ReminderProject
//
//  Created by 전준영 on 7/2/24.
//

import UIKit
import SnapKit
import RealmSwift

final class MainViewController: BaseViewController {
    
    let iconTypes: [IconTypes] = [.today, .schedule, .all, .flag, .complete]
    let realm = try! Realm()
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
    
    func collectionViewLayout() -> UICollectionViewLayout {
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeNavigationUI(title: "전체")
        configureCollection()
        
        setupToolBar()
        setupAppearance()
        setupToolBarButton()
        
        print(realm.configuration.fileURL)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }
    
    override func configureHierarchy() {
        view.addSubview(collectionView)
    }
    
    override func configureLayout() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        
    }
    
}

extension MainViewController {
    
    func setupToolBarButton() {
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let newTodo = UIBarButtonItem(title: "새로운 할 일", style: .plain, target: self, action: #selector(newTodoClicked))
        let listAdd = UIBarButtonItem(title: "목록 추가", style: .plain, target: self, action: nil)
        let barItems = [newTodo, flexibleSpace, flexibleSpace, flexibleSpace, listAdd]
        
        self.toolbarItems = barItems
    }
    
    func configureCollection() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: MainCollectionViewCell.identifier)
    }
    
    @objc func newTodoClicked() {
        let newListVC = NewListViewController()
        newListVC.delegates = self
        let nav = UINavigationController(rootViewController: newListVC)
        navigationController?.present(nav, animated: true)
    }

}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return iconTypes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.identifier, for: indexPath) as! MainCollectionViewCell
        cell.configureData(icon: iconTypes[indexPath.item])
        cell.layer.cornerRadius = 10
        cell.clipsToBounds = true
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
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
    }
    
}

extension MainViewController: PresentProtocol{
    func presentReload() {
        collectionView.reloadData()
    }
}
