//
//  ExercisesView.swift
//  Better
//
//  Created by John Jakobsen on 2/10/23.
//

import Foundation
import UIKit

protocol ExercisesViewDelegate: UITableViewDelegate, UITableViewDataSource {}

class ExercisesView: UIView {
    let _tableview: UITableView!
    var _delegate: ExercisesViewDelegate?
    var delegate: ExercisesViewDelegate? {
        get {
            return _delegate
        }
        set (newVal) {
            _delegate = newVal
            _tableview.delegate = newVal
            _tableview.dataSource = newVal
        }
    }
    
    convenience init(delegate: ExercisesViewDelegate) {
        self.init(frame: CGRect())
        self.addSubview(_tableview)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.delegate = delegate
        self._autolayoutSubViews()
        _tableview.separatorStyle = .none
        _tableview.translatesAutoresizingMaskIntoConstraints = false
        _tableview.rowHeight = UITableView.automaticDimension
        _tableview.estimatedRowHeight = 200
        _tableview.sectionHeaderTopPadding = 0
    }
    
    override init(frame: CGRect) {
        _tableview = UITableView()
        _tableview.translatesAutoresizingMaskIntoConstraints = false
        _tableview.register(ExerciseCell.self, forCellReuseIdentifier: "ExerciseCell")

        super.init(frame: frame)
    }
    
    private func _autolayoutSubViews() {
        let _tableviewConstraints = [
            _tableview.leftAnchor.constraint(equalTo: self.leftAnchor),
            _tableview.rightAnchor.constraint(equalTo: self.rightAnchor),
            _tableview.topAnchor.constraint(equalTo: self.topAnchor),
            _tableview.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ]
        NSLayoutConstraint.activate(_tableviewConstraints)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
