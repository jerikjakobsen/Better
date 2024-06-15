//
//  RoutineSettingsViewController.swift
//  Better
//
//  Created by John Jakobsen on 6/14/24.
//

import Foundation
import UIKit

class RoutineSettingsViewController: UIViewController, RoutineSettingsViewDelegate {
    
    let _routineSettingsView: RoutineSettingsView
    
    init() {
        
        self._routineSettingsView = RoutineSettingsView()
        
        super.init(nibName: nil, bundle: nil)
        
        self.view = self._routineSettingsView
        self._routineSettingsView.backgroundColor = .white
        self._routineSettingsView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func didTapCreateNewRoutine() {
        print("create new routine")
    }
    
    func didTapEditRoutine() {
        print("edit routine")
    }
    
    func didTapCreateNewExercise() {
        print("create new exercise")
    }
    
    func didTapMainRoutineRow() {
        print("main routine")
    }
    
    func didTapChangeRestDaysRow() {
        print("change rest days")
    }
    
}
