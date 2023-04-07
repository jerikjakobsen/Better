//
//  WeightRecordCell.swift
//  Better
//
//  Created by John Jakobsen on 2/18/23.
//

import Foundation
import UIKit

class WeightRecordCell: UITableViewCell {
    let _weightLabel: UILabel!
    let _dateLabel: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        _weightLabel = UILabel()
        _weightLabel.translatesAutoresizingMaskIntoConstraints = false
        
        _dateLabel = UILabel()
        _dateLabel.translatesAutoresizingMaskIntoConstraints = false
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(_weightLabel)
        contentView.addSubview(_dateLabel)
        
        let constraints = [
            _weightLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            _weightLabel.rightAnchor.constraint(lessThanOrEqualTo: _dateLabel.leftAnchor, constant: -10),
            _weightLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            _weightLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -10),
            
            _dateLabel.topAnchor.constraint(equalTo: _weightLabel.topAnchor),
            _dateLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            _dateLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -10),
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func setCellInfo(record: WeightRecord) {
        _weightLabel.text = String(format: "%.2f lbs", record.weight)
        _dateLabel.text = record.date.formatted(date: .abbreviated, time: .omitted)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
