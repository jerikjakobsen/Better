//
//  HomeViewController.swift
//  Better
//
//  Created by John Jakobsen on 4/29/24.
//

import Foundation
import UIKit

class HomeViewController: UIViewController, HomeViewDelegate {
    
    let viewModel: HomeViewModel
    let homeView: HomeView
    
    var nextTrainingRoutineId: String = ""
    var nextTrainingDayId: String = ""
    var lastTrainingID: String = ""
    
    init() {
        viewModel = .init(streak: 4, weight: 145.4, lastTraining: Date.now.addingTimeInterval(-15000), routineName: "Routine #1", nextDayName: "Day 4: Chest")
        homeView = HomeView(viewModel: viewModel)
        nextTrainingRoutineId = "123"
        nextTrainingDayId = "123"
        super.init(nibName: nil, bundle: nil)
        self.tabBarItem = .init(title: "", image: UIImage(named: "home"), selectedImage: UIImage(named: "home"))
        homeView.delegate = self
        self.view = homeView
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func didTapLastTraining() {
        
    }
    
    func didTapNextTraining() {
        guard let routineHomeNavController = self.tabBarController?.viewControllers?[0] as? UINavigationController else {
            return
        }
        routineHomeNavController.popToRootViewController(animated: false)
        guard let routineHomeVC = routineHomeNavController.viewControllers[0] as? RoutineHomeViewController else {
            return
        }
        routineHomeVC.navigateToDay(routineId: self.nextTrainingRoutineId, dayId: self.nextTrainingDayId)
        self.tabBarController?.selectedIndex = 0
    }
}
