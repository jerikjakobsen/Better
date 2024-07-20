//
//  CreateRoutineViewController.swift
//  Better
//
//  Created by John Jakobsen on 6/20/24.
//

import Foundation
import UIKit

class CreateRoutineViewController: UIViewController {
    let createRoutineView: CreateRoutineView
    
    var dayTitles: [String]
    var dayOpenStatus: [Bool] = []
    var exercises: [[Exercise]]
    var movedTableView: Bool = false
    
    init() {
        createRoutineView = CreateRoutineView()
        self.dayTitles = [
                "Day 1: Legs",
                "Day 2: Arms",
                "Day 3: Back",
                "Day 4: Chest",
                "Day 5: Core",
                "Day 6: Cardio"
        ]
        self.dayOpenStatus = [Bool](repeating: true, count: self.dayTitles.count)
        
        self.exercises = [
            [.init(name: "Lunges", id: "", muscleGroups: []), .init(name: "Dumbell Squats", id: "", muscleGroups: []), .init(name: "Calf Raises", id: "", muscleGroups: [])],
            [.init(name: "Bicep Curls", id: "", muscleGroups: []), .init(name: "Tricep Extensions", id: "", muscleGroups: [])],
            [],
            [.init(name: "Dumbell Chest Press", id: "", muscleGroups: [])],
            [.init(name: "Leg Lifts", id: "", muscleGroups: []), .init(name: "Sit Ups", id: "", muscleGroups: [])],
            [.init(name: "Running", id: "", muscleGroups: [])]
        ]
        
        super.init(nibName: nil, bundle: nil)
        
        self.view = createRoutineView
        self.createRoutineView.delegate = self
        self.view.backgroundColor = .white
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        self.navigationItem.setLeftChevronButton(viewController: self)
        
        let titleView = UILabel()
        titleView.font = Fonts.Montserrat_Small_Medium.bold()
        titleView.textColor = Colors.blackTextColor
        titleView.text = "Create New Routine"
        self.navigationItem.titleView = titleView
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func keyboardWillShow(sender: NSNotification) {
        guard let userInfo = sender.userInfo,
                      let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
                      let currentTextField = UIResponder.currentFirst() as? UITextField else { return }
        
        let keyboardTopY = keyboardFrame.cgRectValue.origin.y
        let convertedTextFieldFrame = view.convert(currentTextField.frame, from: currentTextField.superview)
        let textFieldBottomY = convertedTextFieldFrame.origin.y + convertedTextFieldFrame.size.height

        // if textField bottom is below keyboard bottom - bump the frame up
        if textFieldBottomY > keyboardTopY {
            movedTableView = true
            let bumpAmount = textFieldBottomY - keyboardTopY + 40
            self.createRoutineView.moveTableViewBy(bumpAmount)
        }
    }
    
    @objc func keyboardWillHide(sender: NSNotification) {
        if movedTableView {
            //self.createRoutineView.resetTableViewPosition()
            movedTableView = false
        }
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
}

extension CreateRoutineViewController: CreateRoutineViewDelegate {
    func dayNameForCellAt(_ row: Int) -> String {
        return self.dayTitles[row]
    }
    
    func numberOfDays() -> Int {
        return self.dayTitles.count
    }
    
    func numberOfExercisesForDay(_ day: Int) -> Int {
        return self.exercises[day].count
    }
    
    func exerciseForDay(_ day: Int, exerciseIdx: Int) -> Exercise {
        return self.exercises[day][exerciseIdx]
    }
    
    func didDeleteDayAt(_ row: Int) {
        // Make sure you handle self.dayOpenStatus
        self.dayTitles.remove(at: row)
        self.dayOpenStatus.remove(at: row)
        self.exercises.remove(at: row)
    }
    
    func didAddDay(name: String) {
        // Make sure you handle self.dayOpenStatus
        self.dayTitles.append(name)
        self.dayOpenStatus.append(true)
        self.exercises.append([])
    }
    
    func didMoveDayFrom(_ sourceIdx: Int, to destinationIdx: Int) {
        // Make sure you handle self.dayOpenStatus
    }
    
    func didDeleteExercise(_ exerciseRow: Int, from dayRow: Int) {
        self.exercises[dayRow].remove(at: exerciseRow)
    }
    
    func didAddExercise(to dayRow: Int) {
        let vc = AddExerciseViewController(dayRow: dayRow)
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func didTapSave(routineName: String) {
        
    }
    
    func reloadDays() {
        
    }
    
    
    func didEditTitleForDay(_ day: Int, title: String) {
        self.dayTitles[day] = title
    }
    
    func didTapOpen(dayRow: Int, noChange: Bool) {
        if !noChange {
            self.dayOpenStatus[dayRow] = !self.dayOpenStatus[dayRow]
        }
    }
    
    func isDayOpen(dayRow: Int) -> Bool {
        guard dayRow < self.dayTitles.count else {
            return false
        }
        return self.dayOpenStatus[dayRow]
    }
    
    @objc func didTapBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension CreateRoutineViewController: AddExerciseViewControllerDelegate {
    func didSelectExercise(_ exercise: Exercise, at dayRow: Int) {
        self.exercises[dayRow].append(exercise)
        self.createRoutineView.addExerciseToDay(dayRow)
    }
}
