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
            return #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        case .schedule:
            return #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        case .all:
            return #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        case .flag:
            return #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        case .complete:
            return #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        }
    }
    
    func getFilter() -> Results<ListTable> {
        let realm = try! Realm()
        let calendar = Calendar.current
        let yesterday = calendar.date(byAdding: .day, value: -1, to: Date())
        let tomorrow = calendar.date(byAdding: .day, value: +1, to: Date())
        switch self {
        case .today:
            return realm.objects(ListTable.self).where {
                $0.lastDate > yesterday && $0.lastDate < tomorrow
            }
        case .schedule:
            return realm.objects(ListTable.self).where {
                $0.lastDate > Date()
            }.sorted(byKeyPath: "lastDate", ascending: true)
        case .all:
            return realm.objects(ListTable.self).where {
                $0.completed == false
            }.sorted(byKeyPath: "lastDate", ascending: true)
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
        let calendar = Calendar.current
        let yesterday = calendar.date(byAdding: .day, value: -1, to: Date())
        let tomorrow = calendar.date(byAdding: .day, value: +1, to: Date())
        let realm = try! Realm()
        switch self {
        case .today:
            count = realm.objects(ListTable.self).where {
                $0.lastDate > yesterday && $0.lastDate < tomorrow
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
