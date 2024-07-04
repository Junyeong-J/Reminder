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
            UIAction(title: "마감일순", image: UIImage(systemName: "calendar.badge.clock"), handler: { _ in }),
            UIAction(title: "제목순", image: UIImage(systemName: "note.text"), handler: { _ in }),
            UIAction(title: "우선순위 낮음만", image: UIImage(systemName: "arrowshape.down"), handler: { _ in }),
            ]))
        
        navigationItem.title = title
    }
    
    
}
