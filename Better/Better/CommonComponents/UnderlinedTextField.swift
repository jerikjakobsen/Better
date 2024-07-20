//
//  UnderlinedTextField.swift
//  Better
//
//  Created by John Jakobsen on 5/31/24.
//

import Foundation
import UIKit

protocol UnderlinedTextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField)
    func textFieldDidEndEditing(_ textField: UITextField)
}

extension UnderlinedTextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
}

class UnderlinedTextField: UITextField, UITextFieldDelegate {
    
    let fieldTextFieldUnderlineLayer: CALayer
    var underlinedDelegate: UnderlinedTextFieldDelegate? = nil
    
    override init(frame: CGRect) {
        self.fieldTextFieldUnderlineLayer = CALayer()
        super.init(frame: frame)
    }
    
    convenience init(placeholder: String = "") {
        self.init(frame: CGRect())
        self.placeholder = placeholder
        self.backgroundColor = .clear
        fieldTextFieldUnderlineLayer.masksToBounds = true
        fieldTextFieldUnderlineLayer.backgroundColor = Colors.greyBackgroundColor.cgColor
        fieldTextFieldUnderlineLayer.borderWidth = 0.0
        self.borderStyle = .none
        self.layer.addSublayer(fieldTextFieldUnderlineLayer)
        self.delegate = self
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        fieldTextFieldUnderlineLayer.frame = CGRect(x: 0.0, y: self.bounds.maxY, width: self.bounds.width, height: 1.0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.fieldTextFieldUnderlineLayer.backgroundColor = Colors.blackTextColor.cgColor
        self.underlinedDelegate?.textFieldDidBeginEditing(self)
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.fieldTextFieldUnderlineLayer.backgroundColor = Colors.greyBackgroundColor.cgColor
        self.underlinedDelegate?.textFieldDidEndEditing(self)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.resignFirstResponder()
        return true
    }
    
}
