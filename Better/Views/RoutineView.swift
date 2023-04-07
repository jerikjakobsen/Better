//
//  RoutineView.swift
//  Better
//
//  Created by John Jakobsen on 4/3/23.
//

import Foundation
import UIKit

protocol RoutineViewProtocol {
    func changeRoutine(Routine) -> Void
}

class RoutineView: UIView {
    
    let currentRoutineLabel: UILabel = UILabel()
    let currentRoutineTitleLabel: UILabel = UILabel()
    let changeRoutineButton: UIButton = UIButton()
    let createRoutineButton: UIButton = UIButton()
    let stackView: UIStackView = UIStackView()
    let spacerView: UIView = UIView()
    let delegate: RoutineViewProtocol?
    
    override init(frame: CGRect) {
        
        currentRoutineLabel.text = "Current Routine"
        currentRoutineLabel.numberOfLines = 0
        
        currentRoutineTitleLabel.numberOfLines = 0
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        spacerView.translatesAutoresizingMaskIntoConstraints = false

        stackView.addArrangedSubview(spacerView)
        stackView.addArrangedSubview(currentRoutineLabel)
        stackView.addArrangedSubview(currentRoutineTitleLabel)
        stackView.addArrangedSubview(changeRoutineButton)
        stackView.addArrangedSubview(createRoutineButton)
        stackView.axis = .vertical
        stackView.alignment = .center
        
        super.init(frame: frame)
        
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
    
    func setTitle(title: String) {
        currentRoutineTitleLabel.text = title
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
