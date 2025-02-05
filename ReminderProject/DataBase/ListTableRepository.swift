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
    
    func fetchFolder() -> [Folder] {
        let value = realm.objects(Folder.self)
        return Array(value)
    }
    
    func detectRealmURL() {
        print(realm.configuration.fileURL ?? "")
    }
    
    func fetchItemsDate(startDate: Date, endDate: Date) -> Results<ListTable> {
        return realm.objects(ListTable.self).filter("lastDate >= %@ AND lastDate < %@", startDate, endDate)
    }
    
    func createCatalog(_ data: Folder) {
        do {
            try realm.write {
                realm.add(data)
                print("Realm Create Succeed")
            }
        } catch {
            print("Realm Error")
        }
        
    }
    
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
    
    func createMyItem(_ data: ListTable, folder: Folder) {
        do {
            try realm.write{
                folder.detail.append(data)
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
    
    func deleteItemList(_ item: ListTable, folder: Folder) {
        try! self.realm.write {
            if let index = folder.detail.firstIndex(of: item) {
                folder.detail.remove(at: index)
            }
            self.realm.delete(item)
        }
    }

    
    func deleteMyFolder(_ folder: Folder) {
        do {
            try realm.write {
                realm.delete(folder.detail)
                realm.delete(folder)
                print("Folder Reomve Succeed")
            }
        }catch{
            print("Folder Reomve Failed")
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
