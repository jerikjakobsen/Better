//
//  RoutineExerciseSessionViewController.swift
//  Better
//
//  Created by John Jakobsen on 5/8/24.
//

import Foundation
import UIKit

class RoutineExerciseSessionViewController: UIViewController, RoutineExerciseSessionViewDelegate {
    
    let _routineExerciseSessionView: RoutineExerciseSessionView
    let _exerciseSessions: [ExerciseSession]
    let _exercise: Exercise
    let _routine: Routine
    let _day: Day
    
    init(exerciseSessions: [ExerciseSession], exercise: Exercise, routine: Routine, day: Day) {
        self._routineExerciseSessionView = RoutineExerciseSessionView(viewModel: .init(exercise: exercise, exerciseSessions: exerciseSessions))
        self._exerciseSessions = exerciseSessions
        self._exercise = exercise
        self._routine = routine
        self._day = day
        
        super.init(nibName: nil, bundle: nil)
        
        self.view = self._routineExerciseSessionView
        self._routineExerciseSessionView.delegate = self
        
        let titleView = UILabel()
        titleView.font = Fonts.Montserrat_Medium.bolder()
        titleView.textColor = Colors.blackTextColor
        titleView.text = day.name
        self.navigationItem.titleView = titleView
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func numberOfRows(_ tableview: UITableView) -> Int {
        return _exerciseSessions.count
    }
    
    func exerciseSessionForRow(_ row: Int) -> ExerciseSession {
        return _exerciseSessions[row]
    }
    
    func didTapRow(_ tableview: UITableView, row: Int) {
        let vc = ExerciseSessionPopUpViewController(exerciseSession: self._exerciseSessions[row])
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .coverVertical
        self.present(vc, animated: true)
    }
    
    func didTapStartButton(_ button: UIButton) {
        let vc = SessionInProgressViewController(exercise: self._exercise, day: _day)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
