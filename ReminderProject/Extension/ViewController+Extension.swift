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

}
