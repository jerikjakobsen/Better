//
//  BetterAlertController.swift
//  Better
//
//  Created by John Jakobsen on 6/10/24.
//

import Foundation
import UIKit

class BetterAlertController: UIViewController {
    
    let alertView: BetterAlertView
    
    init(title: String, defaultFont: UIFont, defaultColor: UIColor) {
        
        alertView = BetterAlertView(title: title, defaultFont: defaultFont, defaultColor: defaultColor)
        alertView.translatesAutoresizingMaskIntoConstraints = false
        
        super.init(nibName: nil, bundle: nil)
        
        self.view.addSubview(alertView)
        
        self.modalPresentationStyle = .overCurrentContext
        self.modalTransitionStyle = .coverVertical
        
        self.autolayoutSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func autolayoutSubviews() {
        let constraints = [
            alertView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            alertView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            alertView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6),
            alertView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func addAction(title: String, color: UIColor? = nil, font: UIFont? = nil, action: ( (UIAction) -> Void)? = nil) {
        func actionHandler(handlerAction: UIAction) {
            self.dismiss(animated: true)
            if let nonNilAction = action {
                nonNilAction(handlerAction)
            }
            
        }
        self.alertView.addAction(title: title, color: color, font: font, action: actionHandler)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.alertView.addLayer()
    }
}
