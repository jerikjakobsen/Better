//
//  RightChevronButton.swift
//  Better
//
//  Created by John Jakobsen on 6/14/24.
//

import Foundation
import UIKit

typealias RightChevronButtonAction = () -> Void

class RightChevronButton: UIButton {
    
    var buttonAction: RightChevronButtonAction? = nil
    
    init(action: RightChevronButtonAction? = nil) {
        self.buttonAction = action
        super.init(frame: CGRect())
        self.buttonAction = action
        
        self.setImage(UIImage(systemName: "chevron.right")?.withTintColor(Colors.linkColor, renderingMode: .alwaysOriginal), for: .normal)
        self.addTarget(self, action: #selector(self.didTapButton), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setButtonAction(action: @escaping RightChevronButtonAction) {
        self.buttonAction = action
    }
    
    @objc func didTapButton() {
        if let notNilAction = buttonAction {
            notNilAction()
        }
    }
}
