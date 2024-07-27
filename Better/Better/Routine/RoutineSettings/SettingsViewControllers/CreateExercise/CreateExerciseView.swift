//
//  CreateExerciseView.swift
//  Better
//
//  Created by John Jakobsen on 7/20/24.
//

import Foundation
import UIKit

protocol CreateExerciseViewDelegate {
    func didTapAddMuscleGroup()
}

class CreateExerciseView: UIView {
    
    let scrollView: UIScrollView
    let contentView: UIView
    let stackView: UIStackView
    let exerciseNameTextField: UnderlinedTextField
    let exerciseDescriptionTextField: UnderlinedTextField
    let linkTextField: UnderlinedTextField
    let isPrivate: UIImageView
    let muscleGroupsView: MuscleGroupsView
    let addMuscleGroupButton: UIButton
    let saveButton: UIButton
    
    var delegate: CreateExerciseViewDelegate? = nil
    
    init() {
        
        self.exerciseNameTextField = UnderlinedTextField(placeholder: "Name")
        
        self.exerciseDescriptionTextField = UnderlinedTextField(placeholder: "Description")
        
        self.linkTextField = UnderlinedTextField(placeholder: "Link")
        
        self.isPrivate = UIImageView(image: UIImage(systemName: "questionmark.square"))
        self.isPrivate.translatesAutoresizingMaskIntoConstraints = false
        
        self.muscleGroupsView = MuscleGroupsView(muscleGroups: [])
        
        self.addMuscleGroupButton = UIButton()
        self.addMuscleGroupButton.translatesAutoresizingMaskIntoConstraints = false
        self.addMuscleGroupButton.setTitle("Add Muscle Group", for: .normal)
        self.addMuscleGroupButton.titleLabel?.font = Fonts.Montserrat_Small_Medium
        self.addMuscleGroupButton.setTitleColor(Colors.linkColor, for: .normal)
        
        self.saveButton = UIButton()
        self.saveButton.translatesAutoresizingMaskIntoConstraints = false
        self.saveButton.setTitle("Save", for: .normal)
        self.saveButton.titleLabel?.font = Fonts.Montserrat_Small_Medium
        self.saveButton.setTitleColor(Colors.linkColor, for: .normal)
        
        self.scrollView = UIScrollView()
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.scrollView.alwaysBounceVertical = true
        
        self.stackView = UIStackView(arrangedSubviews: [exerciseNameTextField, exerciseDescriptionTextField, linkTextField, isPrivate, muscleGroupsView, addMuscleGroupButton])
        self.stackView.axis = .vertical
        self.stackView.spacing = 30
        self.stackView.distribution = .fillProportionally
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        
        self.contentView = UIView()
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        
        self.scrollView.addSubview(self.contentView)
        
        self.contentView.addSubview(self.stackView)
        
        super.init(frame: CGRect())
        
        self.backgroundColor = .white
        
        self.addSubview(self.scrollView)
        
        self.addMuscleGroupButton.addTarget(self, action: #selector(self.didTapAddMuscleGroup), for: .touchUpInside)
                
        self.autolayoutSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func autolayoutSubviews() {
        NSLayoutConstraint.activate([
            scrollView.leftAnchor.constraint(equalTo: self.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: self.rightAnchor),
            scrollView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            
            contentView.leftAnchor.constraint(equalTo: self.scrollView.leftAnchor),
            contentView.rightAnchor.constraint(equalTo: self.scrollView.rightAnchor),
            contentView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor),
            contentView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
            contentView.heightAnchor.constraint(equalTo: self.scrollView.heightAnchor),
            contentView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor),
            
            stackView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
            stackView.topAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.topAnchor, constant: 30),
            stackView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: self.contentView.safeAreaLayoutGuide.bottomAnchor),
            stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            stackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8)
        ])
    }
    
    @objc func didTapAddMuscleGroup() {
        self.delegate?.didTapAddMuscleGroup()
    }
    
    public func exerciseNameText() -> String {
        return self.exerciseNameTextField.text ?? ""
    }
    
    public func exerciseDescriptionText() -> String {
        return self.exerciseDescriptionTextField.text ?? ""
    }
    
    public func exerciseLinkText() -> String {
        return self.linkTextField.text ?? ""
    }
    
    public func exerciseIsPrivate() -> Bool {
        return false
    }
    
    public func exerciseMuscleGroups() -> [MuscleGroup] {
        return self.muscleGroupsView._muscleGroups
    }
}

extension CreateExerciseView: AddMuscleGroupViewControllerDelegate {
    func didSelectMuscleGroup(_ muscleGroup: MuscleGroup) {
        self.muscleGroupsView.addMuscleGroup(muscleGroup: muscleGroup)
    }
}
