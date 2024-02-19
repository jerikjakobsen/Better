//
//  MuscleGroupCell.swift
//  Better
//
//  Created by John Jakobsen on 2/17/23.
//

import Foundation
import UIKit

class MuscleGroupCell: UITableViewCell {
    let _label: UILabel!
    private let _checkedImageView: UIImageView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        _checkedImageView = UIImageView(image: UIImage(systemName: "checkmark"))
        _checkedImageView.translatesAutoresizingMaskIntoConstraints = false
        _checkedImageView.isHidden = true
        _label = UILabel()
        _label.translatesAutoresizingMaskIntoConstraints = false
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(_checkedImageView)
        contentView.addSubview(_label)
        let constraints = [
            _label.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            _label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            _label.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -10),
            _label.rightAnchor.constraint(lessThanOrEqualTo: _checkedImageView.leftAnchor, constant: -10),
            
            _checkedImageView.topAnchor.constraint(equalTo: _label.topAnchor),
            _checkedImageView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -10),
            _checkedImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func toggleActiveState(active: Bool) {
        _checkedImageView.isHidden = !active
    }
    
    func setCellInfo(text: String, selected: Bool) {
        _label.text = text
        toggleActiveState(active: selected)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
