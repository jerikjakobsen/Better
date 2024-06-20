//
//  ExerciseSessionPopUpView.swift
//  Better
//
//  Created by John Jakobsen on 5/20/24.
//

import Foundation
import UIKit

struct ExerciseSessionPopUpViewModel {
    let titleContent: String
    let durationContent: String
    let repsRowContent: String
    let weightRowContent: String
    let averageBreakContent: String
    let notesContent: String
}

class ExerciseSessionPopUpView: UIView {
    let _titleLabel: UILabel
    let _durationLabel: UILabel
    let _repsRow: ExerciseSessionPopUpRowView
    let _weightRow: ExerciseSessionPopUpRowView
    let _averageBreakRow: ExerciseSessionPopUpRowView
    let _rowStackview: UIStackView
    let _notesTitleLabel: UILabel
    let _notesContentLabel: UILabel
    
    init(viewModel: ExerciseSessionPopUpViewModel) {
        _titleLabel = UILabel()
        _titleLabel.translatesAutoresizingMaskIntoConstraints = false
        _titleLabel.font = Fonts.Montserrat_Small_Medium.bold()
        _titleLabel.textColor = Colors.blackTextColor
        _titleLabel.text = viewModel.titleContent
        
        _durationLabel = UILabel()
        _durationLabel.translatesAutoresizingMaskIntoConstraints = false
        _durationLabel.font = Fonts.Montserrat_Small.bold()
        _durationLabel.textColor = Colors.blackTextColor
        _durationLabel.text = viewModel.durationContent
        
        _repsRow = ExerciseSessionPopUpRowView(leftText: "Reps", rightText: viewModel.repsRowContent, font: Fonts.Montserrat_Small)
        //_repsRow.translatesAutoresizingMaskIntoConstraints = false
        
        _weightRow = ExerciseSessionPopUpRowView(leftText: "Weight (lbs)", rightText: viewModel.weightRowContent, font: Fonts.Montserrat_Small)
        //_weightRow.translatesAutoresizingMaskIntoConstraints = false
        
        _averageBreakRow = ExerciseSessionPopUpRowView(leftText: "Average Break", rightText: viewModel.averageBreakContent, font: Fonts.Montserrat_Small)
        
        _rowStackview = UIStackView(arrangedSubviews: [_repsRow, _weightRow, _averageBreakRow])
        _rowStackview.axis = .vertical
        _rowStackview.alignment = .fill
        _rowStackview.spacing = 6
        _rowStackview.translatesAutoresizingMaskIntoConstraints = false
        
        _notesTitleLabel = UILabel()
        _notesTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        _notesTitleLabel.font = Fonts.Montserrat_Small.bold()
        _notesTitleLabel.textColor = Colors.blackTextColor
        _notesTitleLabel.text = "Notes"
        
        _notesContentLabel = UILabel()
        _notesContentLabel.translatesAutoresizingMaskIntoConstraints = false
        _notesContentLabel.font = Fonts.Montserrat_Small
        _notesContentLabel.textColor = Colors.blackTextColor
        _notesContentLabel.text = viewModel.notesContent
        
        super.init(frame: CGRect())
        
        self.addSubview(_titleLabel)
        self.addSubview(_durationLabel)
        self.addSubview(_rowStackview)
        self.addSubview(_notesTitleLabel)
        self.addSubview(_notesContentLabel)
        
        self.backgroundColor = .white
        
        self.autolayoutSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func autolayoutSubviews() {
        let constraints = [
            _titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15),
            _titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
            _titleLabel.rightAnchor.constraint(lessThanOrEqualTo: self.rightAnchor, constant: -10),
            
            _durationLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15),
            _durationLabel.topAnchor.constraint(equalTo: _titleLabel.bottomAnchor, constant: 10),
            _durationLabel.rightAnchor.constraint(lessThanOrEqualTo: self.rightAnchor, constant: -10),
            
            _rowStackview.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 25),
            _rowStackview.topAnchor.constraint(equalTo: _durationLabel.bottomAnchor, constant: 15),
            _rowStackview.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -25),
            
            _notesTitleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 25),
            _notesTitleLabel.rightAnchor.constraint(lessThanOrEqualTo: self.rightAnchor, constant: -15),
            _notesTitleLabel.topAnchor.constraint(equalTo: _rowStackview.bottomAnchor, constant: 15),
            
            _notesContentLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 40),
            _notesContentLabel.topAnchor.constraint(equalTo: _notesTitleLabel.bottomAnchor, constant: 10),
            _notesContentLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15),
            _notesContentLabel.bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor, constant: -10)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
}
