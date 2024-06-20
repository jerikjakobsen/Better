//
//  SessionNotesPopUpViewController.swift
//  Better
//
//  Created by John Jakobsen on 6/9/24.
//

import Foundation
import UIKit

protocol SessionNotesPopUpViewControllerDelegate {
    func updateNotes(note: String)
}

class SessionNotesPopUpViewController: UIViewController {
    
    let _sessionNotesPopUpView: SessionNotesPopUpView
    var delegate: SessionNotesPopUpViewControllerDelegate? = nil
    
    init(note: String) {
        self._sessionNotesPopUpView = SessionNotesPopUpView(note: note)
        self._sessionNotesPopUpView.translatesAutoresizingMaskIntoConstraints = false
        
        super.init(nibName: nil, bundle: nil)
        
        self._sessionNotesPopUpView.layer.cornerRadius = 10
        self._sessionNotesPopUpView.layer.masksToBounds = false
        self._sessionNotesPopUpView.layer.shadowColor = UIColor.black.cgColor
        self._sessionNotesPopUpView.layer.shadowOpacity = 0.30
        self._sessionNotesPopUpView.layer.shadowOffset = .zero
        self._sessionNotesPopUpView.layer.shadowRadius = 10
        
        self.view = UIView()
        self.view.addSubview(_sessionNotesPopUpView)
        
        self.autolayoutSubviews()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap))
        self.view.addGestureRecognizer(tap)
    }
    
    func autolayoutSubviews() {
        let constraints = [
            _sessionNotesPopUpView.leftAnchor.constraint(greaterThanOrEqualTo: self.view.leftAnchor),
            _sessionNotesPopUpView.rightAnchor.constraint(lessThanOrEqualTo: self.view.rightAnchor),
            _sessionNotesPopUpView.topAnchor.constraint(greaterThanOrEqualTo: self.view.topAnchor),
            _sessionNotesPopUpView.bottomAnchor.constraint(lessThanOrEqualTo: self.view.bottomAnchor),
            _sessionNotesPopUpView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            _sessionNotesPopUpView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -100),
            _sessionNotesPopUpView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8),
            _sessionNotesPopUpView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.4)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func handleTap() {
        self.delegate?.updateNotes(note: self._sessionNotesPopUpView.textView.text)
        self.dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        self._sessionNotesPopUpView.textView.becomeFirstResponder()
    }
}
