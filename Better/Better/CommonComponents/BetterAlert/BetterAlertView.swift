//
//  BetterAlertView.swift
//  Better
//
//  Created by John Jakobsen on 6/10/24.
//

import Foundation
import UIKit

class BetterAlertView: UIView {
    
    let titleLabel: UILabel
    let stackView: UIStackView
    let titleView: UIView
    let defaultColor: UIColor
    let defaultFont: UIFont
    
    init(title: String, defaultFont: UIFont, defaultColor: UIColor) {
        self.titleView = UIView()
        self.titleView.translatesAutoresizingMaskIntoConstraints = false
        
        self.titleLabel = UILabel()
        self.titleLabel.font = defaultFont
        self.titleLabel.textColor = defaultColor
        self.titleLabel.text = title
        self.titleLabel.numberOfLines = 0
        self.titleLabel.textAlignment = .center
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.titleView.addSubview(titleLabel)
        
        self.stackView = UIStackView()
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        self.stackView.axis = .horizontal
        self.stackView.alignment = .fill
        //self.stackView.distribution = .fillEqually
        
        self.defaultFont = defaultFont
        self.defaultColor = defaultColor
        
        super.init(frame: CGRect())
        
        self.addSubview(titleView)
        self.addSubview(stackView)
        
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.30
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = 10
        
        self.backgroundColor = .white
        
        self.autolayoutSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func addAction(title: String, color: UIColor? = nil, font: UIFont? = nil, action: @escaping (UIAction) -> Void) {
        let button = UIButton(primaryAction: UIAction(handler: action))
        button.setTitle(title, for: .normal)
        button.setTitleColor(color ?? defaultColor, for: .normal)
        button.titleLabel?.font = font ?? defaultFont
        button.titleLabel?.textAlignment = .center
        
        if (stackView.subviews.count > 0) {
            let seperatorView = UIView()
            seperatorView.translatesAutoresizingMaskIntoConstraints = false
            seperatorView.backgroundColor = Colors.greyBackgroundColor
            seperatorView.widthAnchor.constraint(equalToConstant: 1).isActive = true
            stackView.addArrangedSubview(seperatorView)
            seperatorView.heightAnchor.constraint(equalTo: stackView.heightAnchor).isActive = true
            
        }
        self.stackView.addArrangedSubview(button)
        if let firstButton = stackView.arrangedSubviews.first as? UIButton {
            if (stackView.subviews.count > 1) {
                button.widthAnchor.constraint(equalTo: firstButton.widthAnchor).isActive = true
            }
        }
    }
    
    func autolayoutSubviews() {
        let constraints = [
            titleView.leftAnchor.constraint(equalTo: self.leftAnchor),
            titleView.rightAnchor.constraint(equalTo: self.rightAnchor),
            titleView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.75),
            titleView.topAnchor.constraint(equalTo: self.topAnchor),
            
            titleLabel.centerXAnchor.constraint(equalTo: titleView.centerXAnchor),
            titleLabel.leftAnchor.constraint(greaterThanOrEqualTo: titleView.leftAnchor),
            titleLabel.rightAnchor.constraint(lessThanOrEqualTo: titleView.rightAnchor),
            titleLabel.widthAnchor.constraint(equalTo: titleView.widthAnchor, multiplier: 0.9),
            titleLabel.topAnchor.constraint(equalTo: titleView.topAnchor, constant: 20),
            titleLabel.bottomAnchor.constraint(lessThanOrEqualTo: titleView.bottomAnchor),
            
            stackView.leftAnchor.constraint(equalTo: self.leftAnchor),
            stackView.topAnchor.constraint(equalTo: titleView.bottomAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            stackView.rightAnchor.constraint(equalTo: self.rightAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func addLayer() {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: titleView.frame.height - 1, width: titleView.frame.width, height: 1.0)
        bottomLine.backgroundColor = Colors.greyBackgroundColor.cgColor
        titleView.layer.addSublayer(bottomLine)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.addLayer()
        
        
    }
}
