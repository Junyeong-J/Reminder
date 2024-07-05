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
    
    func saveImageToDocument(image: UIImage, filename: String) {
        
        guard let documentDirectory = FileManager.default.urls(
            for: .documentDirectory,
            in: .userDomainMask).first else { return }
        
        let fileURL = documentDirectory.appendingPathComponent("\(filename).jpg")
        guard let data = image.jpegData(compressionQuality: 0.5) else { return }
        
        do {
            try data.write(to: fileURL)
        } catch {
            print("file save error", error)
        }
    }
    
}
