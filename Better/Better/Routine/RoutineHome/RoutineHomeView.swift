//
//  RoutineHomeView.swift
//  Better
//
//  Created by John Jakobsen on 4/11/24.
//

import Foundation
import UIKit

protocol RoutineHomeViewDelegate: UITableViewDelegate, UITableViewDataSource {}

class RoutineHomeView: UITableView {
    
    convenience init() {
        self.init(frame: CGRect())
        self.translatesAutoresizingMaskIntoConstraints = false
                
        self.separatorStyle = .none
        self.rowHeight = UITableView.automaticDimension
        self.estimatedRowHeight = 200
        self.sectionHeaderTopPadding = 0
        
        self.register(RoutineHomeDayCell.self, forCellReuseIdentifier: "DayCell")

    }
    
}
