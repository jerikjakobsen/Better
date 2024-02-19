//
//  ExercisesViewController.swift
//  Better
//
//  Created by John Jakobsen on 2/10/23.
//

import Foundation
import UIKit

class ExercisesViewController: UIViewController, AddExerciseViewControllerDelegate, ExerciseDetailViewControllerDelegate {
    func didUpdateExercise() {
        self.exercisesView?._tableview.reloadData()
    }
    
    func addExercise(exercise: Exercise) {
        self._exercises?.append(exercise)
        self.exercisesView?._tableview.reloadData()
    }
    
    var _exercises: [Exercise]?
    var exercisesView: ExercisesView?
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(nibName: String?, bundle: Bundle?) {
        super.init(nibName: nibName, bundle: bundle)
    }
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus.app"), style: .plain , target: self, action: #selector(didTapAddExercise))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Routine", style: .plain , target: self, action: #selector(didTapAddExercise))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        exercisesView = ExercisesView(delegate: self)
        self.view.addSubview(exercisesView!)
        let exercisesViewConstraints = [
            view.leftAnchor.constraint(equalTo: exercisesView!.leftAnchor),
            view.rightAnchor.constraint(equalTo: exercisesView!.rightAnchor),
            view.bottomAnchor.constraint(equalTo: exercisesView!.bottomAnchor),
            view.topAnchor.constraint(equalTo: exercisesView!.topAnchor)
        ]
        NSLayoutConstraint.activate(exercisesViewConstraints)
        Task {
            await Exercise.getAllExercisesFromFirebase { exercises, err in
                if (err == nil && exercises != nil) {
                    self._exercises = exercises
                    self.exercisesView!._tableview.reloadData()
                }
            }
        }
    }
    
    @objc func didTapAddExercise() {
        let addExerciseVC = AddExerciseViewController(maxDay: _exercises?.count ?? 0)
        addExerciseVC.delegate = self
        self.navigationController?.pushViewController(addExerciseVC, animated: true)
    }
    
    @objc func didTapRoutine() {
        let vc = UIViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

// ------------------------------------------------------------------------------------------------------------

extension ExercisesViewController: ExercisesViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _exercises?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExerciseCell") as! ExerciseCell
        cell.setCellInfo(exercise: _exercises![indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self._exercises == nil {
            return
        }
        let ex = self._exercises![indexPath.row]
        let exerciseDetailVC = ExerciseDetailViewController(exercise: ex)
        exerciseDetailVC.delegate = self
        self.navigationController?.pushViewController(exerciseDetailVC, animated: true)
    }
//
//    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
//        let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
//
//        var contentConfiguration: UIListContentConfiguration = header.defaultContentConfiguration()
//
//        contentConfiguration.textProperties.font = FontConstants.LabelTitle1
//        contentConfiguration.text = "Day \(section+1)"
//
//        header.contentConfiguration = contentConfiguration
//    }
}
