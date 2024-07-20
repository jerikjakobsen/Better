//
//  AddDayHeaderView.swift
//  Better
//
//  Created by John Jakobsen on 7/13/24.
//

import Foundation
import UIKit

protocol AddDayHeaderViewDelegate {
    func didTapAddDay()
}

class AddDayHeaderView: UIView {
    let addDayButton: UIButton
    var delegate: AddDayHeaderViewDelegate? = nil
    
    init() {
        
        addDayButton = UIButton()
        addDayButton.translatesAutoresizingMaskIntoConstraints = false
        addDayButton.setTitleColor(Colors.linkColor, for: .normal)
        addDayButton.setTitle("Add Day", for: .normal)
        addDayButton.titleLabel?.font = Fonts.Montserrat_Small_Medium
        
        super.init(frame: CGRect())
        
        self.addSubview(addDayButton)
        
        addDayButton.addTarget(self, action: #selector(self.didTapButton), for: .touchUpInside)
        
        self.autolayoutSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func autolayoutSubviews() {
        NSLayoutConstraint.activate([
            addDayButton.leftAnchor.constraint(greaterThanOrEqualTo: self.leftAnchor),
            addDayButton.topAnchor.constraint(greaterThanOrEqualTo: self.topAnchor),
            addDayButton.rightAnchor.constraint(lessThanOrEqualTo: self.rightAnchor),
            addDayButton.bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor),
            
            addDayButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            addDayButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
    }
    
    @objc func didTapButton() {
        self.delegate?.didTapAddDay()
    }
}
