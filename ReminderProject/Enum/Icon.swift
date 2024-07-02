//
//  Icon.swift
//  ReminderProject
//
//  Created by 전준영 on 7/2/24.
//

import UIKit

enum iconType: String {
    
    case today = "오늘"
    case schedule = "예정"
    case all = "전체"
    case flag = "깃발 표시"
    case complete = "완료됨"
    
    func setImages() -> String {
        switch self {
        case .today:
            return "14.square"
        case .schedule:
            return "calendar"
        case .all:
            return "tray.fill"
        case .flag:
            return "flag.fill"
        case .complete:
            return "checkmark"
        }
    }
    
    func setColor() -> UIColor {
        switch self {
        case .today:
            return .blue
        case .schedule:
            return .red
        case .all:
            return .darkGray
        case .flag:
            return .yellow
        case .complete:
            return .lightGray
        }
    }
}
