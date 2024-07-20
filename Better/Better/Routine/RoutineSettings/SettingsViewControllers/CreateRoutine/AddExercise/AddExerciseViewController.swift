//
//  AddExerciseViewController.swift
//  Better
//
//  Created by John Jakobsen on 7/15/24.
//

import Foundation
import UIKit

protocol AddExerciseViewControllerDelegate {
    func didSelectExercise(_ exercise: Exercise, at dayRow: Int)
}

class AddExerciseViewController: UIViewController, AddExerciseViewDelegate {

    let addExerciseView: AddExerciseView
    var searchedExercises: [Exercise]
    let fullExerciseList: [Exercise]
    let dayRow: Int
    public var delegate: AddExerciseViewControllerDelegate? = nil
    
    init(dayRow: Int) {
        self.addExerciseView = AddExerciseView()
        
        self.fullExerciseList = [
            .init(name: "Lunges", id: "", muscleGroups: []), .init(name: "Dumbell Squats", id: "", muscleGroups: []), .init(name: "Calf Raises", id: "", muscleGroups: []),
            .init(name: "Bicep Curls", id: "", muscleGroups: []), .init(name: "Tricep Extensions", id: "", muscleGroups: []),
            .init(name: "Dumbell Chest Press", id: "", muscleGroups: []),
            .init(name: "Leg Lifts", id: "", muscleGroups: []), .init(name: "Sit Ups", id: "", muscleGroups: []),
            .init(name: "Running", id: "", muscleGroups: [])
        ]
        
        self.searchedExercises = fullExerciseList
        
        self.dayRow = dayRow
        
        super.init(nibName: nil, bundle: nil)
        
        self.navigationItem.setLeftChevronButton(viewController: self)
        
        addExerciseView.delegate = self
        self.view = addExerciseView
        
    }
    
    func numberOfExercises() -> Int {
        return self.searchedExercises.count
    }
    
    func exerciseTitleForRowAt(_ row: Int) -> String {
        return self.searchedExercises[row].name
    }
    
    func searchTextDidChangeTo(_ text: String) {
        let processedSearchText = text.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        if processedSearchText == "" {
            self.searchedExercises = self.fullExerciseList
            self.addExerciseView.reloadExercises()
            return
        }
        self.searchedExercises = self.fullExerciseList.filter { exercise in
            return exercise.name.lowercased().contains(processedSearchText)
        }
        self.addExerciseView.reloadExercises()
    }
    
    func didSelectExerciseAt(_ row: Int) {
        self.delegate?.didSelectExercise(self.searchedExercises[row], at: self.dayRow)
        self.navigationController?.popViewController(animated: true)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
