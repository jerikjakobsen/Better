//
//  RoutineDaySessionViewController.swift
//  Better
//
//  Created by John Jakobsen on 5/3/24.
//

import Foundation
import UIKit

class RoutineDaySessionViewController: UIViewController, RoutineDaySessionViewDelegate {
    
    let _routineDaySessionView: RoutineDaySessionView
    let _exercises: [Exercise]
    let _day: Day
    let _routine: Routine
    
    init(exercises: [Exercise], routine: Routine, day: Day) {
        _routineDaySessionView = RoutineDaySessionView()
        _exercises = exercises
        _day = day
        _routine = routine
//        [.init(name: "Lunges", id: "123", muscleGroups: [],timeToComplete: 168, reps: [10, 10, 10], weight: [5, 5, 5], averageBreak: 79.2),
//                      .init(name: "Dumbell Squats", id: "122", muscleGroups: []),
//                      .init(name: "Calf Raises", id: "232", muscleGroups: []),
//                      .init(name: "Dumbell Kickbacks", id: "", muscleGroups: [])]
        
        super.init(nibName: nil, bundle: nil)
        
        self.view = _routineDaySessionView
        self._routineDaySessionView.delegate = self
        
        let titleView = UILabel()
        titleView.font = Fonts.Montserrat_Medium.bolder()
        titleView.textColor = Colors.blackTextColor
        titleView.text = day.name
        
        self.navigationItem.titleView = titleView
        self.navigationItem.setLeftBarButton(nil, animated: false)
        let quitButton = UIButton()
        quitButton.setTitle("Done", for: .normal)
        quitButton.setTitleColor(Colors.linkColor, for: .normal)
        quitButton.titleLabel?.font = Fonts.Montserrat_Small_Medium
        
        let quitButtonItem = UIBarButtonItem(customView: quitButton)
        self.navigationItem.setRightBarButton(quitButtonItem, animated: true)
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        quitButton.addTarget(self, action: #selector(self.didTapDone), for: .touchUpInside)
        Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
        _routineDaySessionView.delegate = self
        
        do {
            try TrainingSession.startCurrentTrainingSession(routine: routine, day: day)
        } catch {
            print("Unable to start session")
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func numberOfRows(_ tableview: UITableView) -> Int {
        return _exercises.count
    }
    
    func exerciseForRow(_ row: Int) -> Exercise {
        return _exercises[row]
    }
    
    func didTapRow(_ tableview: UITableView, row: Int) {
        let sess: ExerciseSession = .init(startTime: Date.now.addingTimeInterval(-15000), exercise: self._exercises[row])
        sess.averageBreak = 66.8
        sess.endTime = Date.now.addingTimeInterval(-15000 + 2462.2)
        sess.notes = "Need to increase the weight"
        sess.setSessions.append(.init(startTime: Date.now.addingTimeInterval(-15000), endTime: Date.now.addingTimeInterval(-15000 + 124.3), weight: 12.5, reps: 8))
        sess.setSessions.append(.init(startTime: Date.now.addingTimeInterval(-15000 + 124.3 + 60), endTime: Date.now.addingTimeInterval(-15000 + 124.3 + 60 + 136.2), weight: 12.5, reps: 8))
        let vc: RoutineExerciseSessionViewController = RoutineExerciseSessionViewController(exerciseSessions: [sess], exercise: self._exercises[row], routine: self._routine, day: _day)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func didTapDone() {
        print("Tapped Done")
    }
    
    @objc func updateCounter() {
        let timeInterval = (TrainingSession.current_training_session?.startTime.timeIntervalSinceNow ?? 0.0) * -1
        let hours = timeInterval.hours
        let minutes = timeInterval.minutes
        let seconds = timeInterval.seconds
        self._routineDaySessionView._timerLabel.text = String(format: "%02d : %02d : %02d", hours, minutes, seconds)
    }
}
