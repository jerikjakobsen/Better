//
//  RoutineDayDetailsHeaderSectionView.swift
//  Better
//
//  Created by John Jakobsen on 4/17/24.
//

import Foundation
import UIKit

struct RoutineDayDetailsHeaderViewModel {
    let timeTaken: TimeInterval
    let averageTimeToComplete: TimeInterval
    let averageTimeBetweenExercises: TimeInterval
    let muscleGroups: [MuscleGroup]
}

class RoutineDayDetailsHeaderView: UIView {
    let _averageTimeToCompleteLabel: ExerciseStatRowView
    let _averageTimeBetweenExercisesLabel: ExerciseStatRowView
    let _muscleGroupsView: MuscleGroupsView
    let _stackview: UIStackView
    
    init(done: Bool, viewModel: RoutineDayDetailsHeaderViewModel) {
        
        _averageTimeToCompleteLabel = ExerciseStatRowView(font: Fonts.Montserrat_Small_Medium)
        _averageTimeToCompleteLabel.translatesAutoresizingMaskIntoConstraints = false
        
        _averageTimeBetweenExercisesLabel = ExerciseStatRowView(font: Fonts.Montserrat_Small_Medium)
        _averageTimeBetweenExercisesLabel.translatesAutoresizingMaskIntoConstraints = false
 
        _muscleGroupsView = MuscleGroupsView(muscleGroups: viewModel.muscleGroups)
        _muscleGroupsView.translatesAutoresizingMaskIntoConstraints = false

        _stackview = UIStackView(arrangedSubviews: [
            _averageTimeToCompleteLabel,
            _averageTimeBetweenExercisesLabel,
            _muscleGroupsView
        ])

        _stackview.translatesAutoresizingMaskIntoConstraints = false
        _stackview.axis = .vertical
        _stackview.alignment = .fill
        _stackview.distribution = .fillProportionally
        _stackview.spacing = 10
        _stackview.backgroundColor = .white
        
        super.init(frame: CGRect())
        
        self.backgroundColor = .white
        self._averageTimeToCompleteLabel.setInfo(leftTitle: "Average Time to Complete", rightTitle: String(format: "%.1f mins", viewModel.averageTimeToComplete/(1000*60)))
        self._averageTimeBetweenExercisesLabel.setInfo(leftTitle: "Average Time Between Exercises", rightTitle: String(format: "%.1f mins", viewModel.averageTimeBetweenExercises/(1000*60)))
        self.addSubview(_stackview)
        
        self._autolayoutSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func _autolayoutSubviews() {
        let constraints = [
            _stackview.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 30),
            _stackview.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -30),
            _stackview.topAnchor.constraint(equalTo: self.topAnchor),
            _stackview.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}
