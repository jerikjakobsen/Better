//
//  RoutineCreationView.swift
//  Better
//
//  Created by John Jakobsen on 4/9/23.
//

import Foundation
import UIKit

protocol RoutineCreationViewDelegate: UITableViewDelegate, UITableViewDataSource {

}

class RoutineCreationView: UIView {
    let _tableview: UITableView = UITableView()
    var _delegate: RoutineCreationViewDelegate?
    var delegate: RoutineCreationViewDelegate? {
        get {
            return _delegate
        }
        set (newVal) {
            self._delegate = newVal
            self._tableview.delegate = newVal
            self._tableview.dataSource = newVal
        }
    }
    
    init() {
        _tableview.separatorStyle = .none
        _tableview.translatesAutoresizingMaskIntoConstraints = false
        _tableview.rowHeight = UITableView.automaticDimension
        _tableview.estimatedRowHeight = 200
        _tableview.sectionHeaderTopPadding = 0
        _tableview.register(UITableViewCell.self, forCellReuseIdentifier: "AddButtonCell")
        _tableview.register(ExerciseCell.self, forCellReuseIdentifier: "ExerciseCell")

        super.init(frame: CGRect())
        
        NSLayoutConstraint.activate([
            _tableview.leftAnchor.constraint(equalTo: self.leftAnchor),
            _tableview.rightAnchor.constraint(equalTo: self.rightAnchor),
            _tableview.topAnchor.constraint(equalTo: self.topAnchor),
            _tableview.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
