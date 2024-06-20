//
//  RoutineDetailExerciseHeaderView.swift
//  Better
//
//  Created by John Jakobsen on 4/29/24.
//

import Foundation
import UIKit

class RoutineDetailExerciseHeaderView: UITableViewHeaderFooterView {
    let _titleLabel: UILabel
    let _seperatorView: UIView
    let _gradient: CAGradientLayer
    
    override init(reuseIdentifier: String?) {
        _titleLabel = UILabel()
        _titleLabel.font = Fonts.Montserrat_Medium_Large.bolder()
        _titleLabel.textColor = Colors.blackTextColor
        _titleLabel.translatesAutoresizingMaskIntoConstraints = false
        _titleLabel.text = "Exercises"
        
        _seperatorView = UIView()
        _seperatorView.translatesAutoresizingMaskIntoConstraints = false
        _seperatorView.backgroundColor = Colors.blackTextColor
        
        _gradient = CAGradientLayer()
        _gradient.colors = [UIColor.clear, UIColor.white]
        _gradient.locations = [0.0, 1.0]
        
        super.init(reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(_titleLabel)
        self.contentView.addSubview(_seperatorView)
        
        self._autolayoutSubviews()
        self.contentView.layer.insertSublayer(_gradient, at: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTitle(_ title: String) {
        self._titleLabel.text = title
    }
    
    func _autolayoutSubviews() {
        let constraints = [
            _titleLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 10),
            _titleLabel.rightAnchor.constraint(lessThanOrEqualTo: self.contentView.rightAnchor),
            _titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
            
            _seperatorView.topAnchor.constraint(equalTo: _titleLabel.bottomAnchor, constant: 10),
            _seperatorView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 10),
            _seperatorView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -10),
            _seperatorView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            _seperatorView.heightAnchor.constraint(equalToConstant: 1)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func activateGradient() {
        _gradient.frame = self.contentView.frame
        _gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        _gradient.endPoint = CGPoint(x: 0.0, y: 1.0)
    }
}
