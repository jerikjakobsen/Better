//
//  ExerciseCreationTitleCell.swift
//  Better
//
//  Created by John Jakobsen on 7/5/24.
//

import Foundation
import UIKit

class ExerciseCreationTitleCell: UITableViewCell {
    
    let exerciseTitleLabel: UILabel
    
    static let reuseIdentifier: String = "ExerciseCreationTitleCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        exerciseTitleLabel = UILabel()
        exerciseTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        exerciseTitleLabel.font = Fonts.Montserrat_Small_Medium
        exerciseTitleLabel.textColor = Colors.blackTextColor
        exerciseTitleLabel.numberOfLines = 0
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(exerciseTitleLabel)
        
        self.selectionStyle = .none
        self.backgroundColor = .white
        
        autolayoutSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func autolayoutSubviews() {
        NSLayoutConstraint.activate([
            exerciseTitleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 30),
            exerciseTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            exerciseTitleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            exerciseTitleLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    func setCellInfo(title: String) {
        exerciseTitleLabel.text = title
    }
    
}
