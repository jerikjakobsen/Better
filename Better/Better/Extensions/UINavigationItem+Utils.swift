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
}
