//
//  RoutineExerciseSessionCell.swift
//  Better
//
//  Created by John Jakobsen on 5/8/24.
//

import Foundation
import UIKit

class RoutineExerciseSessionCell: UITableViewCell {
    var exerciseSession: ExerciseSession? = nil
    let _weightLabel: UILabel
    let _repsLabel: UILabel
    let _dateLabel: UILabel
    let _notesImage: UIImageView

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        _weightLabel = UILabel()
        _weightLabel.translatesAutoresizingMaskIntoConstraints = false
        _weightLabel.font = Fonts.Montserrat_Small.bold()
        _weightLabel.textColor = Colors.blackTextColor
        
        _repsLabel = UILabel()
        _repsLabel.translatesAutoresizingMaskIntoConstraints = false
        _repsLabel.font = Fonts.Montserrat_Small.bold()
        _repsLabel.textColor = Colors.blackTextColor
        
        _dateLabel = UILabel()
        _dateLabel.translatesAutoresizingMaskIntoConstraints = false
        _dateLabel.font = Fonts.Montserrat_Small.bold()
        _dateLabel.textColor = Colors.blackTextColor
        
//        _durationLabel = UILabel()
//        _durationLabel.translatesAutoresizingMaskIntoConstraints = false
//        _durationLabel.font = Fonts.Montserrat_Small
//        _durationLabel.textColor = Colors.blackTextColor
        let docImage = UIImage(systemName: "doc.text")?.withTintColor(Colors.blackTextColor, renderingMode: .alwaysOriginal)
        _notesImage = UIImageView(image: docImage)
        _notesImage.translatesAutoresizingMaskIntoConstraints = false
        
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(_weightLabel)
        self.contentView.addSubview(_repsLabel)
        self.contentView.addSubview(_dateLabel)
        self.contentView.addSubview(_notesImage)
        //self.contentView.addSubview(_durationLabel)
        
        self.autolayoutSubviews()
        
        self.selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func autolayoutSubviews() {
        let constraints = [
            _weightLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.22),
            _weightLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 25),
            _weightLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            _weightLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -10),
            
            _repsLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.22),
            _repsLabel.leftAnchor.constraint(equalTo: _weightLabel.rightAnchor, constant: 10),
            _repsLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            _repsLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -10),
            
            _dateLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.25),
            _dateLabel.leftAnchor.constraint(equalTo: _repsLabel.rightAnchor, constant: 10),
            _dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            _dateLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -10),
            
            _notesImage.widthAnchor.constraint(equalToConstant: 17),
            _notesImage.heightAnchor.constraint(equalToConstant: 22),
            _notesImage.leftAnchor.constraint(greaterThanOrEqualTo: _dateLabel.rightAnchor, constant: 10),
            _notesImage.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -25),
            _notesImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            _notesImage.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -10)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func setCellInfo(exerciseSession: ExerciseSession) {
        self.exerciseSession = exerciseSession
        _dateLabel.text = exerciseSession.startTime.relativeTime()
        _repsLabel.text = String(format: "%.1f Reps", exerciseSession.averageReps)
        _weightLabel.text = String(format: "%.1f lbs", exerciseSession.averageWeight)
        _notesImage.isHidden = exerciseSession.notes == nil
    }
}
