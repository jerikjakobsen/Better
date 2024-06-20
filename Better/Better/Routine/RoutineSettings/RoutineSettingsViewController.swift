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
        
        let quitButton = UIButton()
        quitButton.setImage(UIImage(systemName: "chevron.left")?.withTintColor(Colors.linkColor, renderingMode: .alwaysOriginal), for: .normal)
        quitButton.addTarget(self, action: #selector(self.didTapBackButton), for: .touchUpInside)
        
        let quitButtonItem = UIBarButtonItem(customView: quitButton)
        self.navigationItem.setLeftBarButton(quitButtonItem, animated: true)
        self.navigationItem.setHidesBackButton(true, animated: false)
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
    
    @objc func didTapBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
}
