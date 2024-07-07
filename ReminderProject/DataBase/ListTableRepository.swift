//
//  ListTableRepository.swift
//  ReminderProject
//
//  Created by 전준영 on 7/8/24.
//

import Foundation
import RealmSwift

final class LikeListTableRepository {
    
    private let realm = try! Realm()
    
    func createItem(_ data: ListTable) {
        do {
            try realm.write {
                realm.add(data)
                print("Realm Create Succeed")
            }
        } catch {
            print("Realm Error")
        }
        
    }
    
    func fetchAll() -> Results<ListTable> {
        return realm.objects(ListTable.self).sorted(byKeyPath: "regdate", ascending: false)
    }
    
    func deleteAll() {
        let allItems = realm.objects(ListTable.self)
        do {
            try realm.write {
                realm.delete(allItems)
            }
        } catch {
            print("Realm Error")
        }
    }
    
}
