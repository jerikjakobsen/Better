//
//  RoutineCreationViewController.swift
//  Better
//
//  Created by John Jakobsen on 4/9/23.
//

import Foundation
import UIKit

class RoutineCreationViewController: UIViewController, RoutineCreationViewDelegate {
    let routine: Routine
    init() {
        routine = Routine()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.routine.exerciseCountForSection(section: section)
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.routine.sessionCount() + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.section == self.routine.sessionCount()) {
            switch (indexPath.row) {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: "AddButtonCell")
                var content = UIListContentConfiguration.cell()
                content.text = "Add Exercise"
                cell?.contentConfiguration = content
                return cell!
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: "AddButtonCell")
                var content = UIListContentConfiguration.cell()
                content.text = "Add session"
                cell?.contentConfiguration = content
                return cell!
            default:
                return UITableViewCell()
            }
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExerciseCell", for: indexPath) as? ExerciseCell
        cell?.setCellInfo(exercise: self.routine.exerciseForRowAt(indexPath: indexPath)!)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.section == self.routine.sessionCount()) {
            switch (indexPath.row) {
            case 0:
                self.navigationController?.pushViewController(UIViewController(), animated: true)
            case 1:
                self.navigationController?.pushViewController(UIViewController(), animated: true)
            default:
                return
            }
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHandler) in
            self.routine.removeExercise(indexPath: indexPath)
                    tableView.deleteRows(at: [indexPath], with: .automatic)
                    completionHandler(true)
                }
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return indexPath.section < self.routine.sessionCount()
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        self.routine.moveExercise(from: sourceIndexPath, to: destinationIndexPath)
    }
}


