//
//  SceneDelegate.swift
//  Better
//
//  Created by John Jakobsen on 4/11/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let tabBarController = UITabBarController()
        tabBarController.tabBar.backgroundColor = .white
        let Home = UIViewController()
        let _timeTaken: TimeInterval = 2718
        let _averageTimeToComplete: TimeInterval = 2828
        let _averageTimeBetweenExercises: TimeInterval = 138
        Home.view = UIView()
        let header = RoutineDayDetailsHeaderView(done: false, viewModel: .init(timeTaken: _timeTaken, averageTimeToComplete: _averageTimeToComplete, averageTimeBetweenExercises: _averageTimeBetweenExercises, muscleGroups: [
            .init(name: "Hamstrings", id: ""),
            .init(name: "Glutes", id: ""),
            .init(name: "Calves", id: ""),
            .init(name: "Biceps", id: ""),
            .init(name: "Triceps", id: "")
        ]))
        header.translatesAutoresizingMaskIntoConstraints = false
//        let rowView = ExerciseStatRowView(font: Fonts.Montserrat_Small_Medium)
//        rowView.setInfo(leftTitle: "Testing a super long left title", rightTitle: "weight 0000000")
//        rowView.translatesAutoresizingMaskIntoConstraints = false
        Home.view.addSubview(header)
        //Home.view.addSubview(rowView)
        let constraints = [
            header.leftAnchor.constraint(equalTo: Home.view.leftAnchor),
            header.rightAnchor.constraint(equalTo: Home.view.rightAnchor),
            header.topAnchor.constraint(equalTo: Home.view.safeAreaLayoutGuide.topAnchor),
            header.bottomAnchor.constraint(lessThanOrEqualTo: Home.view.bottomAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
        Home.tabBarItem = .init(title: "", image: UIImage(named: "home"), selectedImage: UIImage(named: "home"))
        
        let Weights = UIViewController()
        Weights.tabBarItem = .init(title: "", image: UIImage(named: "weight-scale"), selectedImage: UIImage(named: "weight-scale"))
        let routineHomeNavigationController = UINavigationController(rootViewController: RoutineHomeViewController())
        routineHomeNavigationController.navigationBar.backgroundColor = .white
        tabBarController.setViewControllers([
            routineHomeNavigationController,
            UINavigationController(rootViewController: Home),
            UINavigationController(rootViewController: Weights)
        ], animated: true)
        
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

