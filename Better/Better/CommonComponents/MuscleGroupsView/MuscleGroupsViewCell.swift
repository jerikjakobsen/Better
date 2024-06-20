//
//  MuscleGroupViewCell.swift
//  Better
//
//  Created by John Jakobsen on 4/16/24.
//

import Foundation
import UIKit

class MuscleGroupsViewCell: UICollectionViewCell {
    let _titleLabel: UILabel
    
    override init(frame: CGRect) {
        self._titleLabel = UILabel()
        self._titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self._titleLabel.font = Fonts.Montserrat_Small_Medium
        self._titleLabel.textColor = Colors.greyTextColor
        self._titleLabel.numberOfLines = 1
        self._titleLabel.textAlignment = .center
        
        super.init(frame: frame)
        
        self.contentView.addSubview(self._titleLabel)
        self._autolayoutSubviews()
        self.contentView.backgroundColor = Colors.greyBackgroundColor
        self.contentView.layer.cornerRadius = 5
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCellInfo(title: String) {
        self._titleLabel.text = title
    }
    
    private func _autolayoutSubviews() {
        let constraints = [
            _titleLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 10),
            _titleLabel.rightAnchor.constraint(lessThanOrEqualTo: self.contentView.rightAnchor, constant: -10),
            _titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 7.5),
            _titleLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -7.5),
            _titleLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 50),
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}
