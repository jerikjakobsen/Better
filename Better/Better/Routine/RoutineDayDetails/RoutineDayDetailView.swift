//
//  RoutineDoneDayDetailView.swift
//  Better
//
//  Created by John Jakobsen on 4/16/24.
//

import Foundation
import UIKit

protocol RoutineDayDetailViewDelegate {
    func numberOfRows(_ tableview: UITableView) -> Int
    func exerciseForRow(_ row: Int) -> Exercise
    func didTapStart()
}

extension RoutineDayDetailViewDelegate {
    func didTapStart() {
        print("Did not implement didTapStart")
    }
}

class RoutineDayDetailView: UIView, UITableViewDelegate, UITableViewDataSource {
    
    let _tableView: UITableView
    let _stackView: UIStackView
    let _timeTakenLabel: PaddedLabel
    let _startButton: UIButton?
    let _headerView: RoutineDayDetailsHeaderView
    let _backgroundView: UIView
    let _exerciseTitleHeader: RoutineDetailExerciseHeaderView
    var delegate: RoutineDayDetailViewDelegate? = nil
    
    init(done: Bool, headerViewModel: RoutineDayDetailsHeaderViewModel) {
        _tableView = UITableView(frame: CGRect(), style: .grouped)
        _tableView.translatesAutoresizingMaskIntoConstraints = false
        _tableView.separatorStyle = .none
        _tableView.rowHeight = UITableView.automaticDimension
        _tableView.estimatedRowHeight = 200
        _tableView.sectionHeaderTopPadding = 0
        
        _exerciseTitleHeader = RoutineDetailExerciseHeaderView()
        
        _headerView = RoutineDayDetailsHeaderView(done: done, viewModel: headerViewModel)
        _headerView.translatesAutoresizingMaskIntoConstraints = false
        
        _backgroundView = UIView()
        _backgroundView.backgroundColor = .white
        _backgroundView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        _tableView.backgroundView = _backgroundView
        _backgroundView.addSubview(_headerView)
        _backgroundView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        if !done {
            _startButton = UIButton()
            _startButton?.translatesAutoresizingMaskIntoConstraints = false
            _startButton?.setImage(UIImage(named: "startButtonIcon"), for: .normal)
            var configuration = UIButton.Configuration.plain()
            configuration.contentInsets = NSDirectionalEdgeInsets(top: 40, leading: 0, bottom: 40, trailing: 0)
            _startButton?.configuration = configuration
            _startButton?.backgroundColor = .white
        } else {
            _startButton = nil
        }
        
        _timeTakenLabel = PaddedLabel(insets: .init(top: 40, left: 0, bottom: 40, right: 0))
        _timeTakenLabel.font = Fonts.Montserrat_Large.bolder()
        _timeTakenLabel.textColor = Colors.blackTextColor
        _timeTakenLabel.textAlignment = .center
        
        _stackView = UIStackView(arrangedSubviews: [
            _startButton ?? _timeTakenLabel,
            _tableView
        ])
        _stackView.translatesAutoresizingMaskIntoConstraints = false
        _stackView.axis = .vertical
        _stackView.alignment = .fill
        _stackView.spacing = 10
        
        super.init(frame: CGRect())
        
        _startButton?.addTarget(self, action: #selector(self.didTapStartButton), for: .touchUpInside)
        self._timeTakenLabel.text = String(format: "%02d : %02d : %02d", headerViewModel.timeTaken.hours, headerViewModel.timeTaken.minutes, headerViewModel.timeTaken.seconds)
        
        _tableView.delegate = self
        _tableView.dataSource = self
        _tableView.register(RoutineDayDetailsExerciseCell.self, forCellReuseIdentifier: "RoutineDayDetailsExerciseCell")
        
        self.backgroundColor = .white
        self.addSubview(_stackView)
        self.autolayoutSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func autolayoutSubviews() {
        let constraints = [
            _stackView.leftAnchor.constraint(equalTo: self.leftAnchor),
            _stackView.rightAnchor.constraint(equalTo: self.rightAnchor),
            _stackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            _stackView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            
            _headerView.leftAnchor.constraint(equalTo: _backgroundView.leftAnchor),
            _headerView.rightAnchor.constraint(equalTo: _backgroundView.rightAnchor),
            _headerView.topAnchor.constraint(equalTo: _backgroundView.topAnchor),
            _headerView.bottomAnchor.constraint(lessThanOrEqualTo: _backgroundView.bottomAnchor),
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        _startButton?.heightAnchor.constraint(equalToConstant: 240).isActive = true
        _startButton?.heightAnchor.constraint(equalToConstant: 240).isActive = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.delegate?.numberOfRows(tableView) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: RoutineDayDetailsExerciseCell = tableView.dequeueReusableCell(withIdentifier: "RoutineDayDetailsExerciseCell") as? RoutineDayDetailsExerciseCell ?? RoutineDayDetailsExerciseCell(style: .default, reuseIdentifier: "RoutineDayDetailsExerciseCell")
        if let exercise = self.delegate?.exerciseForRow(indexPath.row) {
            let numberOfRows = self.delegate?.numberOfRows(tableView) ?? 0
            cell.setCellInfo(exercise: exercise, isLastCell: numberOfRows - 1 == indexPath.row)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return _exerciseTitleHeader
    }
    
    @objc func didTapStartButton() {
        self.delegate?.didTapStart()
    }
}
