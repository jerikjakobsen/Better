//
//  RoutineHomeHeaderSectionView.swift
//  Better
//
//  Created by John Jakobsen on 4/11/24.
//

import Foundation
import UIKit

struct RoutineHomeHeaderSectionViewModel {
    let routineNumber: Int
    let availableRestDays: Int
    let daysDone: Int
    let totalDays: Int
}

class RoutineHomeHeaderSectionView: UITableViewHeaderFooterView {
    
    let _routineNumberLabel: UILabel
    let _routinesDoneLabel: UILabel
    let _availableRestDaysLabel: UILabel
    let _daysDoneLabel: UILabel
    
    override init(reuseIdentifier: String?) {
        _routineNumberLabel = UILabel()
        _routinesDoneLabel = UILabel()
        _availableRestDaysLabel = UILabel()
        _daysDoneLabel = UILabel()
        
        _routineNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        _routineNumberLabel.font = Fonts.Montserrat_Large.bold()
        _routineNumberLabel.textColor = Colors.blackTextColor
        
        _routinesDoneLabel.translatesAutoresizingMaskIntoConstraints = false
        _routinesDoneLabel.font = Fonts.Montserrat_Small_Medium
        _routinesDoneLabel.text = "Routines Done"
        _routinesDoneLabel.textColor = Colors.blackTextColor
        
        _availableRestDaysLabel.translatesAutoresizingMaskIntoConstraints = false
        _availableRestDaysLabel.font = Fonts.Montserrat_Small_Medium
        _availableRestDaysLabel.textColor = Colors.blackTextColor
        
        _daysDoneLabel.translatesAutoresizingMaskIntoConstraints = false
        _daysDoneLabel.font = Fonts.Montserrat_Small_Medium
        _daysDoneLabel.textColor = Colors.blackTextColor
        
        super.init(reuseIdentifier: reuseIdentifier)
        
        self.addSubview(_routineNumberLabel)
        self.addSubview(_routinesDoneLabel)
        self.addSubview(_availableRestDaysLabel)
        self.addSubview(_daysDoneLabel)
        
        self._autolayoutSubviews()
    }
    
    convenience init(reuseIdentifier: String?, viewModel: RoutineHomeHeaderSectionViewModel) {
        self.init(reuseIdentifier: reuseIdentifier)
        
        _routineNumberLabel.text = "\(viewModel.routineNumber)"
        _availableRestDaysLabel.text = "\(viewModel.availableRestDays) Available Rest Days"
        _daysDoneLabel.text = "\(viewModel.daysDone)/\(viewModel.totalDays) Done"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func _autolayoutSubviews() {
        let constraints = [
            _routineNumberLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 30),
            _routineNumberLabel.leftAnchor.constraint(greaterThanOrEqualTo: self.leftAnchor, constant: 20),
            _routineNumberLabel.rightAnchor.constraint(lessThanOrEqualTo: self.rightAnchor, constant: -20),
            _routineNumberLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            _routinesDoneLabel.topAnchor.constraint(equalTo: _routineNumberLabel.bottomAnchor, constant: 5),
            _routinesDoneLabel.leftAnchor.constraint(greaterThanOrEqualTo: self.leftAnchor, constant: 20),
            _routinesDoneLabel.rightAnchor.constraint(lessThanOrEqualTo: self.rightAnchor, constant: -20),
            _routinesDoneLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            _availableRestDaysLabel.topAnchor.constraint(equalTo: _routinesDoneLabel.bottomAnchor, constant: 20),
            _availableRestDaysLabel.leftAnchor.constraint(greaterThanOrEqualTo: self.leftAnchor, constant: 20),
            _availableRestDaysLabel.rightAnchor.constraint(lessThanOrEqualTo: self.rightAnchor, constant: -20),
            _availableRestDaysLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            _daysDoneLabel.topAnchor.constraint(equalTo: _availableRestDaysLabel.bottomAnchor, constant: 30),
            _daysDoneLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15),
            _daysDoneLabel.rightAnchor.constraint(lessThanOrEqualTo: self.rightAnchor, constant: -20),
            _daysDoneLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
