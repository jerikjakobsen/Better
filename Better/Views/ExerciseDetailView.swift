//
//  ExerciseDetailView.swift
//  Better
//
//  Created by John Jakobsen on 2/11/23.
//

import Foundation
import UIKit

protocol ExerciseDetailViewDelegate: UITableViewDelegate, UITableViewDataSource {}

class ExerciseDetailView: UIView {
    
    let _exercisesTableView: UITableView!
    var _exercise: Exercise?
    var _delegate: ExerciseDetailViewDelegate?
    var delegate: ExerciseDetailViewDelegate? {
        get {
            return _delegate
        }
        set (newVal) {
            self._delegate = newVal
            self._exercisesTableView.delegate = newVal
            self._exercisesTableView.dataSource = newVal
        }
    }
    
    override init(frame: CGRect) {
        _exercisesTableView = UITableView()
        super.init(frame: frame)
        self.addSubview(_exercisesTableView)
        self._exercisesTableView.translatesAutoresizingMaskIntoConstraints = false
        self.translatesAutoresizingMaskIntoConstraints = false
        _exercisesTableView.rowHeight = UITableView.automaticDimension
        _exercisesTableView.estimatedRowHeight = 200
        _exercisesTableView.sectionHeaderTopPadding = 0
        _exercisesTableView.register(ExerciseRecordCell.self, forCellReuseIdentifier: "ExerciseRecordCell")
        _exercisesTableView.register(ExerciseEditableCell.self, forCellReuseIdentifier: "ExerciseEditableCell")
        _autolayoutSubviews()
    }
    
    convenience init(exercise: Exercise, delegate: ExerciseDetailViewDelegate) {
        self.init(frame: CGRect())
        _exercise = exercise
        self.delegate = delegate
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func _autolayoutSubviews() {
        let constraints = [
            _exercisesTableView.leftAnchor.constraint(equalTo: self.leftAnchor),
            _exercisesTableView.rightAnchor.constraint(equalTo: self.rightAnchor),
            _exercisesTableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            _exercisesTableView.topAnchor.constraint(equalTo: self.topAnchor)
            ]
        NSLayoutConstraint.activate(constraints)
    }
}
