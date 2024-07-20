//
//  SingleActionCell.swift
//  Better
//
//  Created by John Jakobsen on 7/8/24.
//

import Foundation
import UIKit

//protocol SingleActionCellDelegate {
//    func didTapSingleAction(indexPath: IndexPath)
//}

class SingleActionCell: UITableViewCell {
    let label: UILabel
//    var delegate: SingleActionCellDelegate? = nil
    
    static let reuseIdentifier: String = "SingleActionCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        label = UILabel()
        label.font = Fonts.Montserrat_Small_Medium
        label.textColor = Colors.linkColor
        label.translatesAutoresizingMaskIntoConstraints = false
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        self.backgroundColor = .white

        self.contentView.addSubview(label)
        self.autolayoutSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func autolayoutSubviews() {
        NSLayoutConstraint.activate([
            label.leftAnchor.constraint(greaterThanOrEqualTo: contentView.leftAnchor, constant: 10),
            label.rightAnchor.constraint(lessThanOrEqualTo: contentView.rightAnchor, constant: -10),
            label.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: 10),
            label.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -10),
            
            label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    func setTitle(_ title: String) {
        self.label.text = title
    }
}
