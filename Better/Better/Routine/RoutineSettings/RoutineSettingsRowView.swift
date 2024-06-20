//
//  RoutineSettingsRowView.swift
//  Better
//
//  Created by John Jakobsen on 6/14/24.
//

import Foundation
import UIKit

class RoutineSettingsRowView: UIView {
    
    let leftLabel: UILabel
    var rightView: UIView
    let stackView: UIStackView
    
    init(text: String, rightView: UIView) {
        
        self.leftLabel = UILabel()
        self.leftLabel.text = text
        self.leftLabel.font = Fonts.Montserrat_Small_Medium.bold()
        self.leftLabel.textColor = Colors.blackTextColor
        
        self.rightView = rightView
        self.stackView = UIStackView(arrangedSubviews: [self.leftLabel, self.rightView])
        self.stackView.axis = .horizontal
        self.stackView.spacing = 10
        self.stackView.alignment = .fill
        self.stackView.distribution = .equalSpacing
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        
        super.init(frame: CGRect())
        
        self.addSubview(stackView)
        
        self.autolayoutSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func autolayoutSubviews() {
        let constraints = [
            stackView.leftAnchor.constraint(equalTo: self.leftAnchor),
            stackView.rightAnchor.constraint(equalTo: self.rightAnchor),
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}
