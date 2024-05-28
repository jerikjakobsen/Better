//
//  Date+Operations.swift
//  Better
//
//  Created by John Jakobsen on 5/1/24.
//

import Foundation

extension Date {
    func greeting() -> String {
        let cal = Calendar.current
        let hour = cal.component(.hour, from: self)
        if (hour < 4 || hour >= 18) {
            return "Good Evening"
        } else if (5 <= hour || hour <= 12) {
            return "Good Morning"
        } else if (13 <= hour || hour < 18) {
            return "Good Afternoon"
        }
        return "Good Day"
    }
    
    func relativeTime() -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full

        let relativeDate = formatter.localizedString(for: self, relativeTo: Date.now)
        return relativeDate
    }
    
    func dateStringWithRespectToYear() -> String {
        let currentComponents = Calendar.current.dateComponents([.day,.month,.year], from: Date.now)
        let components = Calendar.current.dateComponents([.day,.month,.year], from: self)
        var isCurrentYear = false
        if let year = components.year, let currentYear = currentComponents.year {
            isCurrentYear = year == currentYear
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d\(isCurrentYear ? "" : ", 'yy")"
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "h:mm a"
        return "\(dateFormatter.string(from: self)) at \(timeFormatter.string(from: self))"
    }
}
