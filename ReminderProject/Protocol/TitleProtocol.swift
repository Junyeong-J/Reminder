//
//  TitleProtocol.swift
//  ReminderProject
//
//  Created by 전준영 on 7/3/24.
//

import Foundation

protocol TitleProtocol: AnyObject {
    func titleOrContentSet(title: String, content: String)
}

protocol LastDateProtocol: AnyObject {
    func lastDateSet(date: Date)
}
