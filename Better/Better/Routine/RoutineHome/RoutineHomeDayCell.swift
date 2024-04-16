//
//  RoutineHomeDayCell.swift
//  Better
//
//  Created by John Jakobsen on 4/12/24.
//

import Foundation
import UIKit

struct RoutineHomeDayCellViewModel {
    let day_id: String
    let day_name: String
    let is_completed: Bool
}

class RoutineHomeDayCell: UITableViewCell {
    
    let _dayNameLabel: UILabel!
    let _completedStatusImageView: UIImageView!
    var _viewModel: RoutineHomeDayCellViewModel? = nil
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        _dayNameLabel = UILabel()
        _dayNameLabel.translatesAutoresizingMaskIntoConstraints = false
        _dayNameLabel.font = Fonts.Montserrat_Small_Medium
        
        _completedStatusImageView = UIImageView()
        _completedStatusImageView.translatesAutoresizingMaskIntoConstraints = false
        _completedStatusImageView.image = UIImage(named: "check")
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        self.contentView.addSubview(_dayNameLabel)
        self.contentView.addSubview(_completedStatusImageView)
        self._autolayoutSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCellInfo(viewModel: RoutineHomeDayCellViewModel) {
        self._viewModel = viewModel
        self._dayNameLabel.text = viewModel.day_name
        self._completedStatusImageView.isHidden = !viewModel.is_completed
    }
    
    private func _autolayoutSubviews() {
        let constraints = [
            _dayNameLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 10),
            _dayNameLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 20),
            _dayNameLabel.bottomAnchor.constraint(lessThanOrEqualTo: self.contentView.bottomAnchor, constant: 20),
            _dayNameLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            
            _completedStatusImageView.leftAnchor.constraint(greaterThanOrEqualTo: _dayNameLabel.rightAnchor, constant: 20),
            _completedStatusImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant:   20),
            _completedStatusImageView.bottomAnchor.constraint(lessThanOrEqualTo: self.contentView.bottomAnchor, constant: 20),
            _completedStatusImageView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -10),
            _completedStatusImageView.widthAnchor.constraint(equalToConstant: 20),
            _completedStatusImageView.heightAnchor.constraint(equalToConstant: 20),
            _completedStatusImageView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}
