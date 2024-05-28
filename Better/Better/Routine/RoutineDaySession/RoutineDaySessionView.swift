//
//  RoutineDaySessionView.swift
//  Better
//
//  Created by John Jakobsen on 5/3/24.
//

import Foundation
import UIKit

protocol RoutineDaySessionViewDelegate {
    func numberOfRows(_ tableview: UITableView) -> Int
    func exerciseForRow(_ row: Int) -> Exercise
    func didTapRow(_ tableview: UITableView, row: Int)
}

class RoutineDaySessionView: UIView, UITableViewDataSource, UITableViewDelegate {
    
    let _timerLabel: UILabel
    let _tableView: UITableView
    let _exerciseTitleHeader: RoutineDetailExerciseHeaderView
    var delegate: RoutineDaySessionViewDelegate? = nil
    
    init() {
        _timerLabel = UILabel()
        _timerLabel.translatesAutoresizingMaskIntoConstraints = false
        _timerLabel.textColor = Colors.blackTextColor
        _timerLabel.font = Fonts.Montserrat_Large.bold()
        _timerLabel.text = "00 : 00 : 00"
        
        _tableView = UITableView(frame: CGRect(), style: .plain)
        _tableView.translatesAutoresizingMaskIntoConstraints = false
        _tableView.separatorStyle = .none
        _tableView.rowHeight = UITableView.automaticDimension
        _tableView.estimatedRowHeight = 200
        //_tableView.sectionHeaderTopPadding = 0
        _tableView.backgroundColor = .systemBackground
        
        _tableView.register(RoutineDayDetailsExerciseCell.self, forCellReuseIdentifier: "RoutineDayDetailsExerciseCell")
        
        _exerciseTitleHeader = RoutineDetailExerciseHeaderView()
        super.init(frame: CGRect())
        self.backgroundColor = .systemBackground
        
        self.addSubview(_timerLabel)
        self.addSubview(_tableView)
        _tableView.dataSource = self
        _tableView.delegate = self
        autolayoutSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTimer(time: String) {
        _timerLabel.text = time
    }
    
    func autolayoutSubviews() {
        let constraints = [
            _timerLabel.leftAnchor.constraint(greaterThanOrEqualTo: self.leftAnchor),
            _timerLabel.rightAnchor.constraint(lessThanOrEqualTo: self.rightAnchor),
            _timerLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            _timerLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 60),
            
            _tableView.leftAnchor.constraint(equalTo: self.leftAnchor),
            _tableView.rightAnchor.constraint(equalTo: self.rightAnchor),
            _tableView.topAnchor.constraint(equalTo: _timerLabel.bottomAnchor, constant: 100),
            _tableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.delegate?.numberOfRows(_tableView) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let exercise = delegate?.exerciseForRow(indexPath.row) else {
            return UITableViewCell()
        }
        
        let exerciseCell = _tableView.dequeueReusableCell(withIdentifier: "RoutineDayDetailsExerciseCell") as? RoutineDayDetailsExerciseCell ?? RoutineDayDetailsExerciseCell(style: .default, reuseIdentifier: "RoutineDayDetailsExerciseCell")
        let numberOfRows = self.delegate?.numberOfRows(tableView) ?? 0
        
        exerciseCell.setCellInfo(exercise: exercise, isLastCell: numberOfRows-1 == indexPath.row)
        
        return exerciseCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.didTapRow(_tableView, row: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return _exerciseTitleHeader
    }
}
