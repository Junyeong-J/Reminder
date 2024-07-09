//
//  DateViewModel.swift
//  ReminderProject
//
//  Created by 전준영 on 7/9/24.
//

import Foundation

class DateViewModel {
    
    var outputDate: Observable<Date?> = Observable(nil)
    
    var inputDateTapped: Observable<Void?> = Observable(nil)
    
    init() {
        inputDateTapped.bind { _ in
            self.updateDateLabels()
        }
    }
    
    func setDate(date: Date) {
        outputDate.value = date
    }
    
    private func updateDateLabels() {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = "yyyy.MM.dd (EEEE)"
        let dateString = dateFormatter.string(from: outputDate.value ?? Date())
    }
    
}
