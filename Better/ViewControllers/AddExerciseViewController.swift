//
//  AddExerciseViewController.swift
//  Better
//
//  Created by John Jakobsen on 2/13/23.
//

import Foundation
import UIKit

protocol AddExerciseViewControllerDelegate {
    func addExercise(exercise: Exercise)
}

class AddExerciseViewController: UIViewController, AddExerciseViewDelegate, MuscleGroupSelectorViewControllerDelegate {
    func didDismissMGController(selectedGroups: [String]) {
        self._selectedGroups = selectedGroups
        var groupsText = ""
        for group in selectedGroups {
            groupsText += group + ", "
        }
        if groupsText.count > 2 {
            self._view._groupPickerLabel.text = String(groupsText.prefix(groupsText.count-2))
        }
    }
    
    @objc func addExercise() {
        let exercise = Exercise(name: _view.nameString, type: _selectedGroups, weight: _view.weightFloat, reps: _view.repsString, day: _selectedDay, link: _view.linkString)
        Task {
            await exercise.saveToFirebase { err, docID in
                if err != nil {
                    let alert = UIAlertController(title: "Error", message: "Could not upload exercise", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                    }))
                    self.present(alert, animated: true, completion: nil)
                } else {
                    exercise.id = docID
                    self.delegate?.addExercise(exercise: exercise)
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
    
    func didSelectMuscleGroupSelector() {
        let vc = MuscleGroupSelectorViewController(selectedGroups: _selectedGroups)
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return _maxDay + 1
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        _selectedDay = row
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (row >= _maxDay) {
            return "Add New Day"
        } else {
            return String(row + 1)
        }
    }
    
    var delegate: AddExerciseViewControllerDelegate?
    let _view: AddExerciseView!
    let _maxDay: Int!
    var _selectedGroups: [String]!
    var _selectedDay: Int!
    init(maxDay: Int) {
        _view = AddExerciseView()
        _maxDay = maxDay
        _selectedGroups = []
        _selectedDay = 0
        super.init(nibName: nil, bundle: nil)
        overrideUserInterfaceStyle = .light
        view.backgroundColor = .systemBackground
        _view.delegate = self
        self.view.addSubview(_view)
        let constraints = [
            view.leftAnchor.constraint(equalTo: _view.leftAnchor),
            view.rightAnchor.constraint(equalTo: _view.rightAnchor),
            view.bottomAnchor.constraint(equalTo: _view.bottomAnchor),
            view.topAnchor.constraint(equalTo: _view.topAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain , target: self, action: #selector(addExercise))
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        self.view.endEditing(true)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
