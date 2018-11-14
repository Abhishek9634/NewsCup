//
//  Date+Helper.swift
//  Guardian
//
//  Created by Ravindra Soni on 18/12/16.
//  Copyright © 2016 Nickelfox. All rights reserved.
//

import Foundation

enum DateFormat: String {
	
	case yyyyMMdd = "yyyy-MM-dd"
	case ddMMyyyy = "dd-MM-yyyy"
	
}

struct DateHelper {
	static let dateFormatter = DateFormatter()
	
	static var today: Date {
		return DateHelper.shortStringFormatter.date(from: DateHelper.shortStringFormatter.string(from: Date()))!
	}
	
	private static let internalDateFormatter = DateFormatter()
	
	static var shortStringFormatter: DateFormatter {
		let formatter = DateFormatter()
		formatter.dateFormat = "yyyy-MM-dd"
		return formatter
	}
	
	static func dateFormatter(format: DateFormat) -> DateFormatter {
		DateHelper.internalDateFormatter.dateFormat = format.rawValue
		return DateHelper.internalDateFormatter
	}
}

extension Date {
    
    var currentTime: String {
        return self.description(with: Locale.current)
    }
    
    func currentTime(_ format: String = "EE dd/MM/yyyy hh:mm:ss") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = Locale.current
        let dateString = formatter.string(from: self)
        return dateString
    }
}

extension Date {
    
    // -1 for previous, +1 for next & Empty for 0
    static func getDates(days: Int) -> [Date] {
        
        if days == 0 { return [] }
        
        let today = Date()
        var dates: [Date] = [today]
        let upperBound = abs(days)
        
        for i in 1..<upperBound {
            let factor = days > 0 ? i : -i
            if let date = Calendar.current.date(byAdding: .day,
                                                value: factor,
                                                to: today) {
                if days > 0 {
                    dates.append(date)
                } else {
                    dates.insert(date, at: 0)
                }
            }
        }
        return dates
    }
    
    static func getMonths(range: Int) -> [Date] {
        
        if range == 0 { return [] }
        
        let today = Date()
        var dates: [Date] = [today]
        let upperbound = abs(range)
        
        for i in 1..<upperbound {
            let factor = range > 0 ? i : -i
            if let month = Calendar.current.date(byAdding: .month,
                                                 value: factor,
                                                 to: today) {
                if range > 0 {
                    dates.append(month)
                } else {
                    dates.insert(month, at: 0)
                }
            }
        }
        return dates
    }
}

extension Date {
    
    private var currentWeek: [Date] {
        
        var arrThisWeek: [Date] = []
        
        for i in 0..<7 {
            arrThisWeek.append(Calendar.current.date(byAdding: .day,
                                                     value: i,
                                                     to: self.startOfWeek)!)
        }
        
        return arrThisWeek
    }
    
    private func previousWeek(date: Date) -> [Date] {
        
        var previousWeek: [Date] = []
        
        for i in 1...7 {
            previousWeek.append(Calendar.current.date(byAdding: .day,
                                                      value: -i,
                                                      to: date)!)
        }
        
        return previousWeek
    }
    
    private var startOfWeek: Date {
        let gregorian = Calendar(identifier: .gregorian)
        let component = gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear],
                                                 from: self)
        let sunday = gregorian.date(from: component)
        return gregorian.date(byAdding: .day, value: 1, to: sunday!)!
    }
    
    func getPreviousWeeks(range: Int) -> [(monday: Date, sunday: Date)] {
        
        var weeks: [(monday: Date, sunday: Date)] = []
        
        var sunday = self.currentWeek.first!
        let monday = self.currentWeek.last!
        weeks.append((monday: monday, sunday: sunday))
        sunday = self.startOfWeek

        for _ in 1..<range {
            let previousWeek = self.previousWeek(date: sunday)
            weeks.insert((monday: previousWeek.first!, sunday: previousWeek.last!), at: 0)
            sunday = previousWeek.last!
        }
        
        return weeks
    }
}
