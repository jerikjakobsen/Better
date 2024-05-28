//
//  ExerciseSessionPopUpRowView.swift
//  Better
//
//  Created by John Jakobsen on 5/20/24.
//

import Foundation
import UIKit

class ExerciseSessionPopUpRowView: UIView {
    let _leftLabel: UILabel
    let _rightLabel: UILabel
    
    init(leftText: String, rightText: String, font: UIFont) {
        _leftLabel = UILabel()
        _leftLabel.text = leftText
        _leftLabel.font = font
        _leftLabel.textColor = Colors.blackTextColor
        _leftLabel.translatesAutoresizingMaskIntoConstraints = false
        
        _rightLabel = UILabel()
        _rightLabel.text = rightText
        _rightLabel.font = font
        _rightLabel.textColor = Colors.blackTextColor
        _rightLabel.translatesAutoresizingMaskIntoConstraints = false
        
        super.init(frame: CGRect())
        
        self.addSubview(_leftLabel)
        self.addSubview(_rightLabel)
        
        self.autolayoutSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func autolayoutSubviews() {
        let constraints = [
            _leftLabel.leftAnchor.constraint(equalTo: self.leftAnchor),
            _leftLabel.topAnchor.constraint(equalTo: self.topAnchor),
            _leftLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            _rightLabel.leftAnchor.constraint(greaterThanOrEqualTo: _leftLabel.rightAnchor, constant: 10),
            _rightLabel.topAnchor.constraint(equalTo: self.topAnchor),
            _rightLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            _rightLabel.rightAnchor.constraint(equalTo: self.rightAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}
