//
//  NewListViewController.swift
//  ReminderProject
//
//  Created by 전준영 on 7/2/24.
//

import UIKit
import PhotosUI
import SnapKit
import RealmSwift
import Toast

final class NewListViewController: BaseViewController {
    
    let list: [NewList] = [.time, .tag, .priority, .image]
    var lastDate: Date?
    var contentList = ["", "", "", ""]
    
    var titleText: String?
    var memoText: String?
    var photoImage: UIImage?
    
    let tableView = UITableView()
    weak var delegates: PresentProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newListNaviUI()
        configureTableView()
        
        NotificationCenter.default.addObserver(self, selector: #selector(priorityReceivedNotification), name: NSNotification.Name("priorityReceived"), object: nil)
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
        view.backgroundColor = .white
    }
    
    @objc func priorityReceivedNotification(notification: NSNotification) {
        if let result = notification.userInfo?["content"] as? String {
            print(result)
            contentList[2] = result
            tableView.reloadData()
        }
    }
    
}

extension NewListViewController {
    private func newListNaviUI() {
        self.title = "새로운 할 일"
        
        let cancel = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(cancelTapped))
        navigationItem.leftBarButtonItem = cancel
        
        let add = UIBarButtonItem(title: "추가", style: .plain, target: self, action: #selector(addTapped))
        navigationItem.rightBarButtonItem = add
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(NewListTitleTableViewCell.self, forCellReuseIdentifier: NewListTitleTableViewCell.identifier)
        tableView.register(NewListSettingTableViewCell.self, forCellReuseIdentifier: NewListSettingTableViewCell.identifier)
    }
    
    @objc private func cancelTapped() {
        dismiss(animated: true)
    }
    
    @objc private func addTapped() {
        guard let titleText = titleText, !titleText.isEmpty,
              let memoText = memoText else {
            self.view.makeToast("제목을 입력해 주세요")
            return
        }
        
        let realm = try! Realm()
        let data = ListTable(memoTitle: titleText, content: memoText, lastDate: lastDate, tag: contentList[1], priority: contentList[2], regdate: Date())
        
        try! realm.write {
            realm.add(data)
            print("Realm Create Succeed")
        }
        
        if let image = photoImage{
            saveImageToDocument(image: image, filename: "\(data.id)")
        }
        
        delegates?.presentReload()
        dismiss(animated: true)
    }
    
    
}

extension NewListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 150
        } else if indexPath.row == 4 && photoImage != nil {
            return 100 // 이미지가 선택되었을 때 4번 인덱스의 높이를 100으로 설정
        } else {
            return 44
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 + list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: NewListTitleTableViewCell.identifier, for: indexPath) as! NewListTitleTableViewCell
            cell.delegate = self
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: NewListSettingTableViewCell.identifier, for: indexPath) as! NewListSettingTableViewCell
            let image = (indexPath.row == 4) ? photoImage : nil
            cell.configureData(list: list[indexPath.row - 1], contentList: contentList[indexPath.row - 1], image: image)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1 {
            let vc = DateViewController()
            vc.delegate = self
            navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.row == 2 {
            let vc = TagViewController()
            vc.tagLabel = { value in
                self.contentList[indexPath.row - 1] = value
                self.tableView.reloadData()
            }
            navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.row == 3 {
            let vc = PriorityViewController()
            NotificationCenter.default.post(name: NSNotification.Name("sendPriority"), object: nil, userInfo: ["priority": contentList[indexPath.row - 1]])
            navigationController?.pushViewController(vc, animated: true)
        } else {
            var configuration = PHPickerConfiguration()
            configuration.filter = .any(of: [.images, .screenshots])
            let picker = PHPickerViewController(configuration: configuration)
            picker.delegate = self
            present(picker, animated: true)
        }
        
    }
    
}

extension NewListViewController: TitleProtocol, LastDateProtocol {
    func lastDateSet(date: Date) {
        self.lastDate = date
        self.contentList[0] = updateDateLabel(date: date)
        self.tableView.reloadData()
    }
    
    func titleOrContentSet(title: String, content: String) {
        self.titleText = title
        self.memoText = content
    }
    
    private func updateDateLabel(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = "yyyy.MM.dd (EEEE)"
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
    
}

extension NewListViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        if let itemProvider = results.first?.itemProvider, itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) { image, error in
                DispatchQueue.main.async {
                    self.photoImage = image as? UIImage
                    self.tableView.reloadRows(at: [IndexPath(row: 4, section: 0)], with: .automatic)
                }
            }
        }
        picker.dismiss(animated: true)
    }
}
