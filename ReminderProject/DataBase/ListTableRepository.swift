//
//  ListTableRepository.swift
//  ReminderProject
//
//  Created by 전준영 on 7/8/24.
//

import Foundation
import RealmSwift

final class ListTableRepository {
    
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
    
    func deleteIdItem(_ item: ListTable) {
        if let objectToDelete = realm.object(ofType: ListTable.self, forPrimaryKey: item.id) {
            try! realm.write {
                realm.delete(objectToDelete)
            }
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
