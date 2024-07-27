//
//  CreateExerciseViewController.swift
//  Better
//
//  Created by John Jakobsen on 7/20/24.
//

import Foundation
import UIKit

class CreateExerciseViewController: UIViewController {
    let createExerciseView: CreateExerciseView
    
    init() {
        self.createExerciseView = CreateExerciseView()
        
        super.init(nibName: nil, bundle: nil)
        
        self.view = createExerciseView
        
        self.createExerciseView.delegate = self
        
        self.navigationItem.setLeftChevronButton(viewController: self)
        self.navigationItem.setTitle(title: "New Exercise")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension CreateExerciseViewController: CreateExerciseViewDelegate {
    func didTapAddMuscleGroup() {
        let vc = AddMuscleGroupViewController()
        vc.delegate = self.createExerciseView
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
