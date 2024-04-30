//
//  TimeInterval+Operations.swift
//  Better
//
//  Created by John Jakobsen on 4/18/24.
//

import Foundation

extension TimeInterval {
    
    // Note: TimeInterval is in seconds
    
    static func fromMilliseconds(milliseconds: Double) -> TimeInterval {
        return  milliseconds / 1000
    }
    
    var milliseconds: Int {
        return Int((truncatingRemainder(dividingBy: 1)) * 1000)
    }

    var seconds: Int {
        return Int(self) % 60
    }

    var minutes: Int {
        return (Int(self) / 60 ) % 60
    }

    var hours: Int {
        return Int(self) / 3600
    }
}
