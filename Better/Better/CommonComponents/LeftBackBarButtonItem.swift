//
//  LeftBackBarButtonItem.swift
//  Better
//
//  Created by John Jakobsen on 7/19/24.
//

import Foundation
import UIKit

class LeftBackBarButtonItem: UIBarButtonItem {
    let quitButton: UIButton
    var viewController: UIViewController? = nil
    var navigationController: UINavigationController? = nil
    
    convenience init(navigationController: UINavigationController) {
        self.init()
        self.navigationController = navigationController
    }
    
    convenience init(viewController: UIViewController) {
        self.init()
        self.viewController = viewController
    }
    
    override init() {
        self.quitButton = UIButton()
        self.quitButton.setImage(UIImage(systemName: "chevron.left")?.withTintColor(Colors.linkColor, renderingMode: .alwaysOriginal), for: .normal)
        var configuration = UIButton.Configuration.plain()
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 50)
        self.quitButton.configuration = configuration
        
        super.init()
        self.customView = quitButton
        
        self.quitButton.addTarget(self, action: #selector(self.backButtonAction), for: .touchUpInside)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func backButtonAction() {
        if let navController = self.navigationController {
            navController.popViewController(animated: true)
        } else {
            self.viewController?.navigationController?.popViewController(animated: true)
        }
    }
}
