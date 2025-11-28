//
//  DateFilterType.swift
//  IncomeApp
//
//  Created by yiyuan hu on 9/16/25.
//
import Foundation

enum DateFilterType: Int, CaseIterable, Identifiable{
    var id: Self {
        return self
    }
    
    case today
    case last7days
    case thisWeek
    case lastWeek
    case thisMonth
    case lastMonth
    case thisYear
    case lastYear
    case all
    
    var name: String{
        switch self {
        case .today:
            return "Today"
        case .last7days:
            return "Last 7 days"
        case .thisWeek:
            return "This Week"
        case .lastWeek:
            return "Last Week"
        case .thisMonth:
            return "This Month"
        case .lastMonth:
            return "Last Month"
        case .thisYear:
            return "This Year"
        case .lastYear:
            return "Last Year"
        case .all:
            return "All"
        }
    }
    
    func shouldInclude(date: Date) -> Bool {
        let calendar = Calendar.current
        let now = Date()
        
        switch self {
        case .today:
            return calendar.isDateInToday(date)
            
        case .last7days:
            if let last7days = calendar.date(byAdding: .day, value: -7, to: now) {
                return date >= last7days && date <= now
            }
            return false
            
        case .thisWeek:
            return calendar.isDate(date, equalTo: now, toGranularity: .weekOfYear)
        case .lastWeek:
            if let lastWeek = calendar.date(byAdding: .weekOfYear, value: -1, to: now) {
                return calendar.isDate(date, equalTo: lastWeek, toGranularity: .weekOfYear)
            }
            return false
            

        case .thisMonth:
            return calendar.isDate(date, equalTo: now, toGranularity: .month)
        case .lastMonth:
            if let lastMonth = calendar.date(byAdding: .month, value: -1, to: now){
                return calendar.isDate(date, equalTo: lastMonth, toGranularity: .month)
            }
            return false
            
        case .thisYear:
            return calendar.isDate(date, equalTo: now, toGranularity: .year)
        case .lastYear:
            if let lastYear = calendar.date(byAdding: .year, value: -1, to: now){
                return calendar.isDate(date, equalTo: lastYear, toGranularity: .year)
            }
            return false
            
        case .all:
            return true
        }
    }
    
}

