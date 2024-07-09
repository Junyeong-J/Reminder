//
//  DateViewModel.swift
//  ReminderProject
//
//  Created by 전준영 on 7/9/24.
//

import Foundation

class DateViewModel {
    
    var outputDate: Observable<Date?> = Observable(nil)
    var outputDateString: Observable<String> = Observable("")
    var inputDateTapped: Observable<Date?> = Observable(nil)
    
    init() {
        inputDateTapped.bind { date in
            self.outputDate.value = date
            self.updateDateLabels()
        }
    }
    
    private func updateDateLabels() {
        guard let date = outputDate.value else { return }
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = "yyyy.MM.dd (EEEE)"
        let dateString = dateFormatter.string(from: date)
        outputDateString.value = dateString
    }
    
}
