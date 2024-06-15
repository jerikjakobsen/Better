//
//  RoutineDoneDayDetailViewController.swift
//  Better
//
//  Created by John Jakobsen on 4/16/24.
//

import Foundation
import UIKit

class RoutineDoneDayDetailViewController: UIViewController, RoutineDayDetailViewDelegate {
    
    let _routine: Routine
    let _day: Day
    let _exercises: [Exercise] = [.init(name: "Lunges", id: "123", muscleGroups: [], reps: [10, 10, 10], weight: [5, 5, 5]),
                                  .init(name: "Dumbell Squats", id: "122", muscleGroups: [], timeToComplete: 168, reps: [8, 8 , 8], weight: [9, 9, 9], averageBreak: 79.2),
                                  .init(name: "Calf Raises", id: "232", muscleGroups: [], reps: [6, 6, 6], weight: [9, 9, 9]),
                                  .init(name: "Dumbell Kickbacks", id: "", muscleGroups: [], reps: [8, 8], weight: [20, 20])
    ]
    let _timeTaken: TimeInterval = 2718
    let _averageTimeToComplete: TimeInterval = 2828
    let _averageTimeBetweenExercises: TimeInterval = 138
    
    let _routineDayDetailView: RoutineDayDetailView
    
    init(routine: Routine, day: Day) {
        self._routine = routine
        self._day = day
        self._routineDayDetailView = RoutineDayDetailView(done: false, headerViewModel: .init(timeTaken: _timeTaken, averageTimeToComplete: _averageTimeToComplete, averageTimeBetweenExercises: _averageTimeBetweenExercises, muscleGroups: [
            .init(name: "Hamstrings", id: ""),
            .init(name: "Glutes", id: ""),
            .init(name: "Calves", id: "")
        ]))
        
        super.init(nibName: nil, bundle: nil)
        
        let titleView = UILabel()
        titleView.font = Fonts.Montserrat_Medium.bolder()
        titleView.textColor = Colors.blackTextColor
        titleView.text = day.name
        
        _routineDayDetailView.delegate = self
        
        self.navigationItem.titleView = titleView
        self.view = _routineDayDetailView
        
        _routineDayDetailView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.layoutIfNeeded()
        
        _routineDayDetailView._tableView.setContentOffset(.init(x: 0, y: -_routineDayDetailView._headerView.frame.height), animated: true)
        
        _routineDayDetailView._exerciseTitleHeader.activateGradient()
    }

    override func viewDidLayoutSubviews() {
        _routineDayDetailView._tableView.contentInset = .init(top: _routineDayDetailView._headerView.frame.height, left: 0, bottom: 0, right: 0)
    }
    
    func numberOfRows(_ tableview: UITableView) -> Int {
        return self._exercises.count
    }
    
    func exerciseForRow(_ row: Int) -> Exercise {
        return self._exercises[row]
    }
    
    func didTapStart() {
        let daySessionVC = RoutineDaySessionViewController(exercises: self._exercises, routine: self._routine, day: self._day)
        self.navigationController?.pushViewController(daySessionVC, animated: true)
        daySessionVC.tabBarController?.delegate = daySessionVC
    }
}
