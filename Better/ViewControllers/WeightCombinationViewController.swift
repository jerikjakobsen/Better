//
//  WeightCombinationViewController.swift
//  Better
//
//  Created by John Jakobsen on 3/5/23.
//

import Foundation
import UIKit

class WeightCombinationViewController: UIViewController {

    convenience init() {
        self.init(nibName: nil, bundle: nil)
        self.tabBarItem = .init(title: "Weight Combinations", image: .init(systemName: "pencil.circle"), selectedImage: .init(systemName: "pencil.circle.fill"))
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let label = UILabel();
        label.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBackground
        label.numberOfLines = 0
        label.text = """
            5.0 [1.25]
            8.5 [3.0]
            11.0 [1.25, 3.0]
            12.5 [5.0]
            15.0 [1.25, 5.0]
            17.5 [7.5]
            18.5 [3.0, 5.0]
            20.0 [1.25, 7.5]
            21.0 [1.25, 3.0, 5.0]
            23.5 [3.0, 7.5]
            26.0 [1.25, 3.0, 7.5]
            27.5 [5.0, 7.5]
            30.0 [1.25, 5.0, 7.5]
            33.5 [3.0, 5.0, 7.5]
            36.0 [1.25, 3.0, 5.0, 7.5]
            """
        self.view.addSubview(label)
        let constraints = [
            label.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20),
            label.rightAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20),
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            label.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
