//
//  RoutineView.swift
//  Better
//
//  Created by John Jakobsen on 4/3/23.
//

import Foundation
import UIKit

protocol RoutineViewDelegate {
    func didTapChangeRoutine() -> Void
    func didTapCreateRoutine() -> Void
    func didTapUpdateRoutine() -> Void
}

class RoutineView: UIView {
    
    let currentRoutineLabel: UILabel = UILabel()
    let currentRoutineTitleLabel: UILabel = UILabel()
    let changeRoutineButton: UIButton = UIButton()
    let createRoutineButton: UIButton = UIButton()
    let updateRoutineButton: UIButton = UIButton()
    let stackView: UIStackView = UIStackView()
    let spacerView: UIView = UIView()
    var delegate: RoutineViewDelegate?
    
    override init(frame: CGRect) {
        
        currentRoutineLabel.text = "Current Routine"
        currentRoutineLabel.numberOfLines = 0
        
        currentRoutineTitleLabel.numberOfLines = 0
        
        changeRoutineButton.setTitle("Change Routine", for: .normal)
        createRoutineButton.setTitle("Create Routine", for: .normal)
        updateRoutineButton.setTitle("Update Routine", for: .normal)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        spacerView.translatesAutoresizingMaskIntoConstraints = false

        stackView.addArrangedSubview(spacerView)
        stackView.addArrangedSubview(currentRoutineLabel)
        stackView.addArrangedSubview(currentRoutineTitleLabel)
        stackView.addArrangedSubview(changeRoutineButton)
        stackView.addArrangedSubview(createRoutineButton)
        stackView.addArrangedSubview(updateRoutineButton)
        stackView.axis = .vertical
        stackView.alignment = .center
        
        super.init(frame: frame)
        
        changeRoutineButton.addTarget(self, action: #selector(didTapChangeRoutineButton), for: .touchUpInside)
        createRoutineButton.addTarget(self, action: #selector(didTapCreateRoutineButton), for: .touchUpInside)
        updateRoutineButton.addTarget(self, action: #selector(didTapUpdateRoutineButton), for: .touchUpInside)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.leftAnchor.constraint(equalTo: self.leftAnchor),
            stackView.rightAnchor.constraint(equalTo: self.rightAnchor),
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            spacerView.heightAnchor.constraint(equalToConstant: 200)
        ])
        
    }
    @objc
    func didTapChangeRoutineButton() {
        delegate?.didTapChangeRoutine()
    }
    
    @objc
    func didTapCreateRoutineButton() {
        delegate?.didTapCreateRoutine()
    }
    
    @objc
    func didTapUpdateRoutineButton() {
        delegate?.didTapUpdateRoutine()
    }
    
    func setTitle(title: String) {
        currentRoutineTitleLabel.text = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
