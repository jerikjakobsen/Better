//
//  RoutineExerciseSessionView.swift
//  Better
//
//  Created by John Jakobsen on 5/8/24.
//

import Foundation
import UIKit

struct RoutineExerciseSessionViewModel {
    let exercise: Exercise
    let exerciseSessions: [ExerciseSession]
}

protocol RoutineExerciseSessionViewDelegate {
    func numberOfRows(_ tableview: UITableView) -> Int
    func exerciseSessionForRow(_ row: Int) -> ExerciseSession
    func didTapRow(_ tableview: UITableView, row: Int)
    func didTapStartButton(_ button: UIButton)
}

class RoutineExerciseSessionView: UIView, UITableViewDelegate, UITableViewDataSource {
    
    let _exerciseTitleLabel: UILabel
    let _startButton: UIButton
    let _tableView: UITableView
    let _tableViewHeader: RoutineDetailExerciseHeaderView
    let viewModel: RoutineExerciseSessionViewModel
    var delegate: RoutineExerciseSessionViewDelegate? = nil
    
    
    init(viewModel: RoutineExerciseSessionViewModel) {
        _exerciseTitleLabel = UILabel()
        _exerciseTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        _exerciseTitleLabel.font = Fonts.Montserrat_Medium
        _exerciseTitleLabel.textColor = Colors.blackTextColor
        _exerciseTitleLabel.text = viewModel.exercise.name
        
        _startButton = UIButton()
        _startButton.translatesAutoresizingMaskIntoConstraints = false
        _startButton.setImage(UIImage(named: "startButtonIcon"), for: .normal)
        var configuration = UIButton.Configuration.plain()
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        _startButton.configuration = configuration
        _startButton.backgroundColor = .white
        
        _tableView = UITableView()
        _tableView.translatesAutoresizingMaskIntoConstraints = false
        _tableView.separatorStyle = .none
        _tableView.rowHeight = UITableView.automaticDimension
        _tableView.estimatedRowHeight = 200
        _tableView.sectionHeaderTopPadding = 0
        
        _tableViewHeader = RoutineDetailExerciseHeaderView()
        _tableViewHeader.setTitle("Previous Sessions")
        
        self.viewModel = viewModel
        
        super.init(frame: CGRect())
        
        _tableView.register(RoutineExerciseSessionCell.self, forCellReuseIdentifier: "RoutineExerciseSessionCell")
        _tableView.delegate = self
        _tableView.dataSource = self
        
        self.backgroundColor = .white
        
        self.addSubview(_exerciseTitleLabel)
        self.addSubview(_startButton)
        self.addSubview(_tableView)
        
        self.autolayoutSubviews()
        _startButton.addTarget(self, action: #selector(self.didTapStartButton), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func autolayoutSubviews() {
        let constraints = [
            _exerciseTitleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            _exerciseTitleLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 30),
            _exerciseTitleLabel.leftAnchor.constraint(greaterThanOrEqualTo: self.leftAnchor),
            _exerciseTitleLabel.rightAnchor.constraint(lessThanOrEqualTo: self.rightAnchor),
            
            _startButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            _startButton.topAnchor.constraint(equalTo: _exerciseTitleLabel.bottomAnchor, constant: 20),
            _startButton.leftAnchor.constraint(greaterThanOrEqualTo: self.leftAnchor),
            _startButton.rightAnchor.constraint(lessThanOrEqualTo: self.rightAnchor),
            _startButton.widthAnchor.constraint(equalToConstant: 200),
            _startButton.heightAnchor.constraint(equalToConstant: 200),
            
            _tableView.leftAnchor.constraint(equalTo: self.leftAnchor),
            _tableView.rightAnchor.constraint(equalTo: self.rightAnchor),
            _tableView.topAnchor.constraint(equalTo: _startButton.bottomAnchor, constant: 20.0),
            _tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return delegate?.numberOfRows(_tableView) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: RoutineExerciseSessionCell = (_tableView.dequeueReusableCell(withIdentifier: "RoutineExerciseSessionCell") as? RoutineExerciseSessionCell) ?? RoutineExerciseSessionCell(style: .default, reuseIdentifier: "RoutineExerciseSessionCell")
        if let record = delegate?.exerciseSessionForRow(indexPath.row) {
            cell.setCellInfo(exerciseSession: record)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return _tableViewHeader
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.didTapRow(_tableView, row: indexPath.row)
    }
    
    @objc func didTapStartButton() {
        self.delegate?.didTapStartButton(_startButton)
    }
}
