//
//  Icon.swift
//  ReminderProject
//
//  Created by 전준영 on 7/2/24.
//

import UIKit
import RealmSwift

enum IconTypes: String {
    
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
    
    func getFilter() -> Results<ListTable> {
        let realm = try! Realm()
        
        switch self {
        case .today:
            return realm.objects(ListTable.self).where {
                $0.lastDate == Date()
            }
        case .schedule:
            return realm.objects(ListTable.self).where {
                $0.lastDate > Date()
            }
        case .all:
            return realm.objects(ListTable.self).where {
                $0.completed == false
            }
        case .flag:
            return realm.objects(ListTable.self).where {
                $0.flag == true
            }
        case .complete:
            return realm.objects(ListTable.self).where {
                $0.completed == true
            }
        }
    }
    
    func getCount() -> Int {
        var count = 0
        let realm = try! Realm()
        switch self {
        case .today:
            count = realm.objects(ListTable.self).where {
                $0.lastDate == Date()
            }.count
        case .schedule:
            count = realm.objects(ListTable.self).where {
                $0.lastDate > Date()
            }.count
        case .all:
            count = realm.objects(ListTable.self).where {
                $0.completed == false
            }.count
        case .flag:
            count = realm.objects(ListTable.self).where {
                $0.flag == true
            }.count
        case .complete:
            count = realm.objects(ListTable.self).where {
                $0.completed == true
            }.count
        }
        
        return count
    }
    
    func todayDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = "yyyy.MM.dd (EEEE)"
        let currentDateString = dateFormatter.string(from: Date())
        return currentDateString
    }
}
