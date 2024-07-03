//
//  ViewController+Extension.swift
//  ReminderProject
//
//  Created by 전준영 on 7/2/24.
//

import UIKit

extension UIViewController {
    
    func setupToolBar() {
        navigationController?.isToolbarHidden = false
    }
    
    func setupAppearance() {
        
        let appearance = UIToolbarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        navigationController?.toolbar.scrollEdgeAppearance = appearance
    }
    
    func setupToolBarButton() {
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let newTodo = UIBarButtonItem(title: "새로운 할 일", style: .plain, target: self, action: #selector(newTodoClicked))
        let listAdd = UIBarButtonItem(title: "목록 추가", style: .plain, target: self, action: nil)
        let barItems = [newTodo, flexibleSpace, flexibleSpace, flexibleSpace, listAdd]
        
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
        
        let list = UIBarButtonItem(image: UIImage(systemName: "ellipsis.circle"), style: .plain, target: self, action: nil)
        navigationItem.rightBarButtonItem = list
        navigationItem.title = title
    }
    
    
    
    
    @objc func newTodoClicked() {
        let vc = UINavigationController(rootViewController: NewListViewController())
        navigationController?.present(vc, animated: true)
    }
    
}
