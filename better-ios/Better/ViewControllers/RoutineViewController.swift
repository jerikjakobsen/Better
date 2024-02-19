//
//  RoutineViewController.swift
//  Better
//
//  Created by John Jakobsen on 4/9/23.
//

import Foundation
import UIKit

class RoutineViewController: UIViewController, RoutineViewDelegate {
    func didTapChangeRoutine() {
        
    }
    
    func didTapCreateRoutine() {
        
    }
    
    func didTapUpdateRoutine() {
        
    }
    
    
    let routine: Routine
    let routineView: RoutineView
    
   init(routine: Routine) {
       self.routineView = RoutineView()
       self.routineView.setTitle(title: routine.name ?? "")
       self.routine = routine
       super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
