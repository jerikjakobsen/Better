//
//  UITextFieldExtension.swift
//  Better
//
//  Created by John Jakobsen on 2/18/23.
//

import Foundation
import UIKit

class InsetTextField: UITextField {
    var textPadding = UIEdgeInsets(
            top: 5,
            left: 10,
            bottom: 5,
            right: 10
        )
    override func textRect(forBounds bounds: CGRect) -> CGRect {
            let rect = super.textRect(forBounds: bounds)
            return rect.inset(by: textPadding)
        }

        override func editingRect(forBounds bounds: CGRect) -> CGRect {
            let rect = super.editingRect(forBounds: bounds)
            return rect.inset(by: textPadding)
        }
}
