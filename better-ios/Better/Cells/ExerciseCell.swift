//
//  ExerciseCell.swift
//  Better
//
//  Created by John Jakobsen on 2/10/23.
//

import Foundation
import UIKit

class ExerciseCell: UITableViewCell {
    private let _nameLabel: UILabel!
    private let _typeLabel: UILabel!
    private let _weightLabel: UILabel!
    private let _repsLabel: UILabel!
    var _exercise: Exercise?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        _nameLabel = UILabel()
        _nameLabel.translatesAutoresizingMaskIntoConstraints = false
        _nameLabel.numberOfLines = 0
        _nameLabel.font = FontConstants.LabelTitle1
        
        _typeLabel = UILabel()
        _typeLabel.translatesAutoresizingMaskIntoConstraints = false
        _typeLabel.numberOfLines = 0
        _typeLabel.font = FontConstants.Label2Emphasized
        
        _weightLabel = UILabel()
        _weightLabel.translatesAutoresizingMaskIntoConstraints = false
        _weightLabel.numberOfLines = 0
        _weightLabel.font = FontConstants.LabelRegular2
        
        _repsLabel = UILabel()
        _repsLabel.translatesAutoresizingMaskIntoConstraints = false
        _repsLabel.numberOfLines = 0
        _repsLabel.font = FontConstants.LabelRegular2
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(_nameLabel)
        self.contentView.addSubview(_typeLabel)
        self.contentView.addSubview(_weightLabel)
        self.contentView.addSubview(_repsLabel)
        _autolayoutSubViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCellInfo(exercise: Exercise) {
        _exercise = exercise
        _nameLabel.text = exercise.name
        var typeText = ""
        for type in exercise.type {
            typeText += "\(type?.rawValue ?? ""), "
        }
        _typeLabel.text = String(typeText.prefix(typeText.count-2))
        _weightLabel.text = String(format: "%.2f lbs", exercise.weight ?? 0.0)
        _repsLabel.text = exercise.reps
    }
    
    private func _autolayoutSubViews() {
        let _nameLabelConstraints = [
            _nameLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 10),
            _nameLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
            _nameLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: 10)
        ]
        NSLayoutConstraint.activate(_nameLabelConstraints)
        
        let _typeLabelConstraints = [
            _typeLabel.leftAnchor.constraint(equalTo: _nameLabel.leftAnchor),
            _typeLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: 10),
            _typeLabel.topAnchor.constraint(equalTo: _nameLabel.bottomAnchor, constant: 10),
        ]
        NSLayoutConstraint.activate(_typeLabelConstraints)
        
        let _weightLabelConstraints = [
            _weightLabel.leftAnchor.constraint(equalTo: _nameLabel.leftAnchor),
            _weightLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: 10),
            _weightLabel.topAnchor.constraint(equalTo: _typeLabel.bottomAnchor, constant: 10),
        ]
        NSLayoutConstraint.activate(_weightLabelConstraints)
        
        let _repsLabelConstraints = [
            _repsLabel.leftAnchor.constraint(equalTo: _nameLabel.leftAnchor),
            _repsLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: 10),
            _repsLabel.topAnchor.constraint(equalTo: _weightLabel.bottomAnchor, constant: 10),
            _repsLabel.bottomAnchor.constraint(lessThanOrEqualTo: self.contentView.bottomAnchor, constant: -10)
        ]
        NSLayoutConstraint.activate(_repsLabelConstraints)
    }
}
