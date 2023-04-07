//
//  ExerciseRecordCell.swift
//  Better
//
//  Created by John Jakobsen on 2/12/23.
//

import Foundation
import UIKit

class ExerciseRecordCell: UITableViewCell {
    
    let _weightLabel: UILabel!
    let _repsLabel: UILabel!
    let _dateLabel: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        _weightLabel = UILabel()
        _weightLabel.translatesAutoresizingMaskIntoConstraints = false
        _weightLabel.numberOfLines = 0
        
        _repsLabel = UILabel()
        _repsLabel.translatesAutoresizingMaskIntoConstraints = false
        _repsLabel.numberOfLines = 0
        
        _dateLabel = UILabel()
        _dateLabel.translatesAutoresizingMaskIntoConstraints = false
        _dateLabel.numberOfLines = 0
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(_weightLabel)
        self.contentView.addSubview(_repsLabel)
        self.contentView.addSubview(_dateLabel)
        
        _autolayoutSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func _autolayoutSubviews() {
        let constraints = [
            _weightLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 10),
            _weightLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
            _weightLabel.rightAnchor.constraint(lessThanOrEqualTo: _dateLabel.leftAnchor, constant: -10),
            
            _dateLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -10),
            _dateLabel.bottomAnchor.constraint(lessThanOrEqualTo: self.contentView.bottomAnchor, constant: -10),
            _dateLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
            
            _repsLabel.leftAnchor.constraint(equalTo: _weightLabel.leftAnchor),
            _repsLabel.rightAnchor.constraint(lessThanOrEqualTo: _dateLabel.rightAnchor, constant: -10),
            _repsLabel.topAnchor.constraint(equalTo: _weightLabel.bottomAnchor, constant: 10),
            _repsLabel.bottomAnchor.constraint(lessThanOrEqualTo: self.contentView.bottomAnchor, constant: -10)
        ]
        NSLayoutConstraint.activate(constraints)
        
    }
    
    func setCellInfo(exerciseRecord: ExerciseRecord) {
        _repsLabel.text = exerciseRecord.reps
        _weightLabel.text = String(format: "%.2f", exerciseRecord.weight ?? 0.0)
        _dateLabel.text = exerciseRecord.date?.formatted() ?? "Unknown"
    }
}
