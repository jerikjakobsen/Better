//
//  RoutineSelectionOptionCell.swift
//  Better
//
//  Created by John Jakobsen on 4/13/24.
//

import Foundation
import UIKit

class RoutineSelectionOptionCell: UITableViewCell {
    var nameLabel: UILabel
    var row: Int? = nil
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        self.nameLabel = UILabel()
        self.nameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.nameLabel.font = Fonts.Montserrat_Small_Medium
        self.nameLabel.numberOfLines = 0
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(nameLabel)
        _autolayoutSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCellInfo(name: String, row: Int) {
        self.nameLabel.text = name
        self.row = row
    }
    
    private func _autolayoutSubviews() {
        let constraints = [
            nameLabel.leftAnchor.constraint(greaterThanOrEqualTo: self.contentView.leftAnchor),
            nameLabel.rightAnchor.constraint(lessThanOrEqualTo: self.contentView.rightAnchor),
            nameLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5),
            nameLabel.bottomAnchor.constraint(lessThanOrEqualTo: self.contentView.bottomAnchor, constant: -5),
            nameLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}
