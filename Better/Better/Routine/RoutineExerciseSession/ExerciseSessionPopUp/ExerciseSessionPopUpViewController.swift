//
//  ExerciseSessionPopUpViewController.swift
//  Better
//
//  Created by John Jakobsen on 5/20/24.
//

import Foundation
import UIKit

class ExerciseSessionPopUpViewController: UIViewController {
    let exerciseSessionPopUpView: ExerciseSessionPopUpView
    let exerciseSession: ExerciseSession
    
    init(exerciseSession: ExerciseSession) {
        self.exerciseSessionPopUpView = ExerciseSessionPopUpView(viewModel:
                .init(titleContent: "\(exerciseSession.startTime.dateStringWithRespectToYear())",
                      durationContent: String(format: "%.1f mins", exerciseSession.duration?.doubleMinutes ?? 0.0),
                      repsRowContent: exerciseSession.setSessions.map({ setSession in
                                            return "\(setSession.reps)"
                                        }).joined(separator: " | "),
                      weightRowContent: exerciseSession.setSessions.map({ setSession in
                                            return "\(setSession.weight)"
                                        }).joined(separator: " | "),
                      averageBreakContent: String(format: "%.1f mins", exerciseSession.averageBreak?.doubleMinutes ?? 0.0),
                      notesContent: exerciseSession.notes ?? "No notes"))
        self.exerciseSession = exerciseSession
        
        super.init(nibName: nil, bundle: nil)
        
        self.exerciseSessionPopUpView.layer.cornerRadius = 10
        self.exerciseSessionPopUpView.layer.masksToBounds = false
        self.exerciseSessionPopUpView.layer.shadowColor = UIColor.black.cgColor
        self.exerciseSessionPopUpView.layer.shadowOpacity = 0.30
        self.exerciseSessionPopUpView.layer.shadowOffset = .zero
        self.exerciseSessionPopUpView.layer.shadowRadius = 10
        self.exerciseSessionPopUpView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.exerciseSessionPopUpView)
        
        self.autolayoutSubviews()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap))
        self.view.addGestureRecognizer(tap)
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func autolayoutSubviews() {
        let constraints = [
            exerciseSessionPopUpView.leftAnchor.constraint(greaterThanOrEqualTo: self.view.leftAnchor),
            exerciseSessionPopUpView.rightAnchor.constraint(lessThanOrEqualTo: self.view.rightAnchor),
            exerciseSessionPopUpView.topAnchor.constraint(greaterThanOrEqualTo: self.view.topAnchor),
            exerciseSessionPopUpView.bottomAnchor.constraint(lessThanOrEqualTo: self.view.bottomAnchor),
            exerciseSessionPopUpView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            exerciseSessionPopUpView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -150),
            exerciseSessionPopUpView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8),
            exerciseSessionPopUpView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.4)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    @objc private func handleTap() {
        self.dismiss(animated: true)
    }
}
