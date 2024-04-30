//
//  RoutineDayDetailsExerciseCell.swift
//  Better
//
//  Created by John Jakobsen on 4/17/24.
//

import Foundation
import UIKit

class RoutineDayDetailsExerciseCell: UITableViewCell {
    let _stackView: UIStackView
    let _titleLabel: UILabel
    let _doneImageView: UIImageView
    let _seperatorView: UIView
    
    let _timeToCompleteRow: ExerciseStatRowView
    let _averageBreakRow: ExerciseStatRowView
    let _repsRow: ExerciseStatRowView
    let _weightRow: ExerciseStatRowView
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        _titleLabel = UILabel()
        _titleLabel.translatesAutoresizingMaskIntoConstraints = false
        _titleLabel.font = Fonts.Montserrat_Small_Medium.bold()
        _titleLabel.textAlignment = .left
        
        _seperatorView = UIView()
        _seperatorView.backgroundColor = Colors.blackTextColor
        _seperatorView.translatesAutoresizingMaskIntoConstraints = false
        
        _timeToCompleteRow = ExerciseStatRowView(changeType: .GreenDown, font: Fonts.Montserrat_Small)
        _averageBreakRow = ExerciseStatRowView(changeType: .GreenUp ,font: Fonts.Montserrat_Small)
        _repsRow = ExerciseStatRowView(changeType: .RedUp, font: Fonts.Montserrat_Small)
        _weightRow = ExerciseStatRowView(changeType: .RedDown, font: Fonts.Montserrat_Small)
        
        _stackView = UIStackView(arrangedSubviews: [
            _timeToCompleteRow,
            _averageBreakRow,
            _repsRow,
            _weightRow
        ])
        _stackView.translatesAutoresizingMaskIntoConstraints = false
        _stackView.axis = .vertical
        _stackView.alignment = .fill
        _stackView.spacing = 5
        
        _doneImageView = UIImageView(image: UIImage(named: "check"))
        _doneImageView.translatesAutoresizingMaskIntoConstraints = false
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(_titleLabel)
        self.contentView.addSubview(_stackView)
        self.contentView.addSubview(_doneImageView)
        self.contentView.addSubview(_seperatorView)
        
        self.selectionStyle = .none
        
        self._autolayoutSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func _autolayoutSubviews() {
        let constraints = [
            _titleLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 30),
            _titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
            
            _doneImageView.topAnchor.constraint(greaterThanOrEqualTo: self.contentView.topAnchor),
            _doneImageView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -20),
            _doneImageView.leftAnchor.constraint(greaterThanOrEqualTo: _titleLabel.rightAnchor, constant: 10),
            _doneImageView.centerYAnchor.constraint(equalTo: _titleLabel.centerYAnchor),
            _doneImageView.heightAnchor.constraint(equalToConstant: 16),
            _doneImageView.widthAnchor.constraint(equalToConstant: 16),
            
            _stackView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 40),
            _stackView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -20),
            _stackView.topAnchor.constraint(equalTo: _titleLabel.bottomAnchor, constant: 10),
            
            _seperatorView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 30),
            _seperatorView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -30),
            _seperatorView.topAnchor.constraint(equalTo: _stackView.bottomAnchor, constant: 20),
            _seperatorView.bottomAnchor.constraint(lessThanOrEqualTo: self.contentView.bottomAnchor, constant: -10),
            _seperatorView.heightAnchor.constraint(equalToConstant: 1)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func setCellInfo(exercise: Exercise, isLastCell: Bool) {
        
        self._titleLabel.text = exercise.name
        
        if let timeToComplete = exercise.timeToComplete {
            _timeToCompleteRow.setInfo(leftTitle: "Time to Complete", rightTitle: String(format: "%.2f mins", timeToComplete/(1000*60))
)
        } else {
            _timeToCompleteRow.isHidden = true
        }
        
        
        if let averageBreak = exercise.averageBreak {
            _averageBreakRow.setInfo(leftTitle: "Average Break", rightTitle: String(format: "%.2f mins", averageBreak))
        } else {
            _averageBreakRow.isHidden = true
        }
        
        if let reps = exercise.reps {
            _repsRow.setInfo(leftTitle: "Reps", rightTitle: reps.map({ rep in
                return "\(rep)"
            }).joined(separator: " "))
        } else {
            _repsRow.isHidden = true
        }
        
        if let weight = exercise.weight {
            _weightRow.setInfo(leftTitle: "Weight", rightTitle: weight.map({ weight in
                return "\(weight)"
            }).joined(separator: " "))
        } else {
            _weightRow.isHidden = true
        }
        
        _seperatorView.isHidden = isLastCell
    }
}
