//
//  ExerciseStatRowView.swift
//  Better
//
//  Created by John Jakobsen on 4/17/24.
//

import Foundation
import UIKit

enum ChangeType {
    case GreenUp
    case GreenDown
    case RedUp
    case RedDown
    case None
}

class ExerciseStatRowView: UIView {
    let _leftLabel: UILabel
    let _rightLabel: UILabel
    let _changeImageView: UIImageView
    var _changeType: ChangeType
    var _noneChangeConstraints: [NSLayoutConstraint] = []
    var _changeConstraints: [NSLayoutConstraint] = []
    
    init(changeType: ChangeType = .None, font: UIFont) {
        _changeType = changeType
        
        _leftLabel = UILabel()
        _leftLabel.translatesAutoresizingMaskIntoConstraints = false
        _leftLabel.font = font
        _leftLabel.textColor = Colors.blackTextColor
        _leftLabel.numberOfLines = 0
        _leftLabel.textAlignment = .left
        
        _rightLabel = UILabel()
        _rightLabel.translatesAutoresizingMaskIntoConstraints = false
        _rightLabel.font = font
        _rightLabel.textColor = Colors.blackTextColor
        _rightLabel.numberOfLines = 0
        _rightLabel.textAlignment = .right
        
        _changeImageView = UIImageView()
        _changeImageView.translatesAutoresizingMaskIntoConstraints = false
        
        switch changeType {
        case .GreenDown:
            _changeImageView.image = UIImage(named: "greendown")
        case .GreenUp:
            _changeImageView.image = UIImage(named: "greenup")
        case .RedDown:
            _changeImageView.image = UIImage(named: "reddown")
        case .RedUp:
            _changeImageView.image = UIImage(named: "redup")
        case .None:
            _changeImageView.isHidden = true
        }
        
        super.init(frame: CGRect())
                
        self.addSubview(_leftLabel)
        self.addSubview(_rightLabel)
        self.addSubview(_changeImageView)
        
        _noneChangeConstraints = [
            _rightLabel.rightAnchor.constraint(equalTo: self.rightAnchor)
        ]
        
        _changeConstraints = [
            _changeImageView.leftAnchor.constraint(equalTo: _rightLabel.rightAnchor, constant: 12),
            _changeImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            _changeImageView.bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor),
            _changeImageView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0),
            _changeImageView.widthAnchor.constraint(equalToConstant: 16),
            _changeImageView.heightAnchor.constraint(equalToConstant: 16)
        ]
        
        self.autolayoutSubviews(changeType: changeType)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func autolayoutSubviews(changeType: ChangeType) {
        let constraints = [
            _leftLabel.leftAnchor.constraint(equalTo: self.leftAnchor),
            _leftLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            _leftLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            _leftLabel.widthAnchor.constraint(lessThanOrEqualTo: self.widthAnchor, multiplier: 0.6),
            
            _rightLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            _rightLabel.bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor),
            _rightLabel.leftAnchor.constraint(greaterThanOrEqualTo: _leftLabel.rightAnchor, constant: 10),
        ]
        // 10 16 10
        NSLayoutConstraint.activate(constraints)
        
        if (changeType == .None) {
            NSLayoutConstraint.deactivate(_changeConstraints)
            NSLayoutConstraint.activate(_noneChangeConstraints)
        } else {
            NSLayoutConstraint.deactivate(_noneChangeConstraints)
            NSLayoutConstraint.activate(_changeConstraints)
        }
    }
    
    func setInfo(leftTitle: String, rightTitle: String) {
        self._leftLabel.text = leftTitle
        self._rightLabel.text = rightTitle
    }
}
