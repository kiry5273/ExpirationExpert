//
//  DateUtil.swift
//  ios_app
//
//  Created by Kenneth Wu on 2022/12/20.
//

import Foundation
import CoreData
class DateUtil: NSObject {
    let dateFormatter: DateFormatter = DateFormatter()
    func _init_(){
        dateFormatter.dateFormat = "MM/dd/yyyy"
        dateFormatter.locale = Locale.ReferenceType.system
        dateFormatter.timeZone = TimeZone.ReferenceType.system
    }
    
    func date2StringFormatter(date: Date) -> String{
        _init_()
        return dateFormatter.string(from: date)
    }
    
    func string2DateFormatter(strDate: String) -> Date{
        _init_()
        return dateFormatter.date(from: strDate)!
    }
    
    func date2dateFormatter(date: Date) -> Date{
        return string2DateFormatter(strDate: date2StringFormatter(date: date))
    }
    
    func dateDiff(start: Date, end: Date) -> Int{
        let calender = Calendar.current
        let diff: DateComponents = calender.dateComponents([.day], from: date2dateFormatter(date: start), to: date2dateFormatter(date: end))
        return diff.day!
   }
}
