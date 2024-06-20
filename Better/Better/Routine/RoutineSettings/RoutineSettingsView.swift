//
//  RoutineSettingsView.swift
//  Better
//
//  Created by John Jakobsen on 6/14/24.
//

import Foundation
import UIKit

protocol RoutineSettingsViewDelegate {
    func didTapCreateNewRoutine()
    func didTapEditRoutine()
    func didTapCreateNewExercise()
    func didTapMainRoutineRow()
    func didTapChangeRestDaysRow()
}

class RoutineSettingsView: UIView {
    
    let _stackView: UIStackView
    let createNewRoutineRow: RoutineSettingsRowView
    let editRoutineRow: RoutineSettingsRowView
    let createNewExerciseRow: RoutineSettingsRowView
    let mainRoutineRow: RoutineSettingsRowView
    let changeRestDaysRow: RoutineSettingsRowView
    
    var delegate: RoutineSettingsViewDelegate? = nil
    
    init() {
        
        let createNewRoutineButton = RightChevronButton()
        createNewRoutineRow = RoutineSettingsRowView(text: "Create New Routine", rightView: createNewRoutineButton)
        
        let editRoutineButton = RightChevronButton()
        editRoutineRow = RoutineSettingsRowView(text: "Edit Routine", rightView: editRoutineButton)
        
        let createNewExerciseButton = RightChevronButton()
        createNewExerciseRow = RoutineSettingsRowView(text: "Create New Exercise", rightView: createNewExerciseButton)
        
        let mainRoutineButton = RightChevronButton()
        mainRoutineRow = RoutineSettingsRowView(text: "Main Routine", rightView: mainRoutineButton)
        
        let changeRestDayButton = RightChevronButton()
        changeRestDaysRow = RoutineSettingsRowView(text: "Change Rest Days", rightView: changeRestDayButton)
        
        self._stackView = UIStackView(arrangedSubviews: [createNewRoutineRow, editRoutineRow, createNewExerciseRow, mainRoutineRow, changeRestDaysRow])
        self._stackView.axis = .vertical
        self._stackView.spacing = 30
//        self._stackView.alignment = .fill
        self._stackView.distribution = .fillProportionally
        _stackView.translatesAutoresizingMaskIntoConstraints = false
        
        super.init(frame: CGRect())
        createNewRoutineButton.setButtonAction {
            self.delegate?.didTapCreateNewRoutine()
        }
        
        editRoutineButton.setButtonAction {
            self.delegate?.didTapEditRoutine()
        }
        
        createNewExerciseButton.setButtonAction {
            self.delegate?.didTapCreateNewExercise()
        }
        
        mainRoutineButton.setButtonAction {
            self.delegate?.didTapMainRoutineRow()
        }
        
        changeRestDayButton.setButtonAction {
            self.delegate?.didTapChangeRestDaysRow()
        }

        self.addSubview(self._stackView)
        
        self.autolayoutSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func autolayoutSubviews() {
        let constraints = [
            _stackView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            _stackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 30),
            _stackView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
            _stackView.bottomAnchor.constraint(lessThanOrEqualTo: self.safeAreaLayoutGuide.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}
