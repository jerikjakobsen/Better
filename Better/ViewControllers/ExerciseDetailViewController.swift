//
//  ExerciseDetailViewController.swift
//  Better
//
//  Created by John Jakobsen on 2/12/23.
//

import Foundation
import UIKit

protocol ExerciseDetailViewControllerDelegate {
    func didUpdateExercise()
}

class ExerciseDetailViewController: UIViewController, ExerciseDetailViewDelegate, ExerciseEditableCellDelegate {

    var _exerciseDetailView: ExerciseDetailView?
    var _exerciseRecords: [ExerciseRecord]?
    var _exercise: Exercise?
    let editableCell: ExerciseEditableCell!
    var delegate: ExerciseDetailViewControllerDelegate?
    init(exercise: Exercise) {
        _exerciseRecords = []
        _exercise = exercise
        editableCell = ExerciseEditableCell(style: .default, reuseIdentifier: "ExerciseEditableCell")
        editableCell.exercise = exercise
        super.init(nibName: nil, bundle: nil)
        editableCell.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _exerciseDetailView = ExerciseDetailView(exercise: self._exercise!, delegate: self)
        self.view.addSubview(_exerciseDetailView!)
        _autolayoutSubviews()
        
        Task {
            guard let eID = self._exercise!.id else {return}
            await ExerciseRecord.getAllExerciseRecordsFromFirebase(exerciseID: eID) {exerciseRecords, err in
                if err != nil {
                    let alert = UIAlertController(title: "Error", message: "Could not load records", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                    }))
                    self.present(alert, animated: true, completion: nil)
                } else {
                    self._exerciseRecords = exerciseRecords
                    self._exerciseDetailView?._exercisesTableView.reloadData()
                }
            }
            
        }
    }
    
    private func _autolayoutSubviews() {
        let constraints = [
            _exerciseDetailView!.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            _exerciseDetailView!.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            _exerciseDetailView!.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            _exerciseDetailView!.topAnchor.constraint(equalTo: self.view.topAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (_exerciseRecords?.count ?? 0) + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            return self.editableCell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ExerciseRecordCell") as? ExerciseRecordCell
            if _exerciseRecords != nil {
                cell?.setCellInfo(exerciseRecord: self._exerciseRecords![indexPath.row-1])
                return cell!
            }
        }
        return UITableViewCell()
    }
    
    func addRecord(exerciseRecord: ExerciseRecord) {
        Task {
            await exerciseRecord.saveToFirebase {err,docID in 
                if err != nil {
                    let alert = UIAlertController(title: "Error", message: "Could not upload record", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                    }))
                    self.present(alert, animated: true, completion: nil)
                } else {
                    self._exerciseRecords?.insert(exerciseRecord, at: 0)
                    self._exerciseDetailView?._exercisesTableView.reloadData()
                    
                    self.editableCell._repsTextField.placeholder = self.editableCell._repsTextField.text
                    self._exercise?.reps = self.editableCell._repsTextField.text
                    self.editableCell._repsTextField.text = ""
                    
                    self.editableCell._weightTextField.placeholder = self.editableCell._weightTextField.text
                    self._exercise?.weight = Float(self.editableCell._weightTextField.text!) ?? 0.0
                    self.editableCell._weightTextField.text = ""
                    
                    Task {
                        await self._exercise?.update { err in
                            if err != nil {
                                let alert = UIAlertController(title: "Error", message: "Failed to update exercise", preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                                }))
                                self.present(alert, animated: true, completion: nil)
                            } else {
                                self.delegate?.didUpdateExercise()
                            }
                        }
                    }
                    
                }
            }
        }
    }
    
}
