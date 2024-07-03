//
//  RealmModel.swift
//  ReminderProject
//
//  Created by 전준영 on 7/3/24.
//

import Foundation
import RealmSwift

class ListTable: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted(indexed: true) var memoTitle: String
    @Persisted var content: String?
    @Persisted var lastDate: String?
    @Persisted var tag: String?
    @Persisted var priority: String?
    @Persisted var regdate: Date

    
    convenience init(memoTitle: String, content: String?, lastDate: String?,
                     tag: String?, priority: String?, regdate: Date) {
        self.init()
        self.memoTitle = memoTitle
        self.content = content
        self.lastDate = lastDate
        self.tag = tag
        self.priority = priority
        self.regdate = regdate
    }
    
}
