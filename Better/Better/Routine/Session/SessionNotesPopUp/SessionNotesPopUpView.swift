//
//  SessionNotesPopUpView.swift
//  Better
//
//  Created by John Jakobsen on 6/9/24.
//

import Foundation
import UIKit

class SessionNotesPopUpView: UIView {
    let titleLabel: UILabel
    public let textView: UITextView
    
    init(note: String) {
        titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = note.count != 0 ? "Edit Note" : "New Note"
        titleLabel.font = Fonts.Montserrat_Small_Medium.bold()
        titleLabel.textColor = Colors.blackTextColor
        
        textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = note
        textView.font = Fonts.Montserrat_Small_Medium
        textView.textColor = Colors.blackTextColor
        textView.layer.borderColor = Colors.greyBackgroundColor.cgColor
        textView.layer.borderWidth = 1
        textView.layer.cornerRadius = 10
        textView.clipsToBounds = true
        
        super.init(frame: CGRect())
        
        self.backgroundColor = .white
        
        self.addSubview(titleLabel)
        self.addSubview(textView)
        
        self.autolayoutSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func autolayoutSubviews() {
        let constraints = [
            titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            titleLabel.rightAnchor.constraint(lessThanOrEqualTo: self.rightAnchor, constant: -10),
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
            
            textView.leftAnchor.constraint(equalTo: titleLabel.leftAnchor),
            textView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
            textView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
            textView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
}
