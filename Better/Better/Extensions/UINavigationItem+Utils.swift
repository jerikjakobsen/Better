//
//  UINavigationItem+Utils.swift
//  Better
//
//  Created by John Jakobsen on 7/19/24.
//

import Foundation
import UIKit

extension UINavigationItem {
    func setLeftChevronButton(viewController: UIViewController) {
        let quitButtonItem = LeftBackBarButtonItem(viewController: viewController)
        self.setLeftBarButton(quitButtonItem, animated: true)
        self.setHidesBackButton(true, animated: false)
    }
    
    func setLeftChevronButton(navigationController: UINavigationController) {
        let quitButtonItem = LeftBackBarButtonItem(navigationController: navigationController)
        self.setLeftBarButton(quitButtonItem, animated: true)
        self.setHidesBackButton(true, animated: false)
    }
    
    func setTitle(title: String) {
        let titleView = UILabel()
        titleView.font = Fonts.Montserrat_Small_Medium.bold()
        titleView.textColor = Colors.blackTextColor
        titleView.text = title
        self.titleView = titleView
    }
}
