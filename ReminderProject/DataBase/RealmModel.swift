//
//  RealmModel.swift
//  ReminderProject
//
//  Created by 전준영 on 7/3/24.
//

import Foundation
import RealmSwift

class Folder: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var name: String
    @Persisted var regdate: Date
    
    @Persisted var detail: List<ListTable>
    
    convenience init(name: String) {
        self.init()
        self.name = name
    }
}


class ListTable: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted(indexed: true) var memoTitle: String
    @Persisted var content: String?
    @Persisted var lastDate: Date?
    @Persisted var tag: String?
    @Persisted var priority: Int?
    @Persisted var flag: Bool?
    @Persisted var completed: Bool?
    @Persisted var regdate: Date
    
    
    convenience init(memoTitle: String, content: String?, lastDate: Date?,
                     tag: String?, priority: Int?, regdate: Date) {
        self.init()
        self.memoTitle = memoTitle
        self.content = content
        self.lastDate = lastDate
        self.tag = tag
        self.priority = priority
        self.flag = false
        self.completed = false
        self.regdate = regdate
    }
    
}
