//
//  IconImage.swift
//  ReminderProject
//
//  Created by 전준영 on 7/2/24.
//

import UIKit

class IconImage: UIImageView {
    
    init() {
        super.init(frame: .zero)
        
        let configuration = UIImage.SymbolConfiguration(pointSize: 15)
        let sfImage = UIImage(systemName: "", withConfiguration: configuration)
        image = sfImage
        contentMode = .center
        tintColor = .white
        backgroundColor = .white
        layer.cornerRadius = 17
        clipsToBounds = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
