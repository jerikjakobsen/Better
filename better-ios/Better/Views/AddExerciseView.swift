//
//  AddExerciseView.swift
//  Better
//
//  Created by John Jakobsen on 2/13/23.
//

import Foundation
import UIKit
import NotificationCenter

protocol AddExerciseViewDelegate {
    func didSelectMuscleGroupSelector() -> Void
}

class AddExerciseView: UIView, UIPickerViewDataSource, UIPickerViewDelegate, UIScrollViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return MuscleGroup.allCases.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return MuscleGroup.allCases[row].rawValue
    }

    let _nameTextField: UITextField!
    var nameString: String {
        return _nameTextField.text ?? ""
    }
    let _groupPickerLabel: UILabel!
    let _muscleGroupLabel: UILabel
    let _weightTextField: UITextField!
    var weightFloat: Float {
        return Float(_weightTextField.text ?? "0.0") ?? 0.0
    }
    let _repsTextField: UITextField!
    var repsString: String {
        return _repsTextField.text ?? ""
    }
    let _linkTextField: UITextField!
    var linkString: String {
        return _linkTextField.text ?? ""
    }
    let _scrollView: UIScrollView!
    let _wrapperView: UIView!
    var _delegate: AddExerciseViewDelegate?
    var delegate: AddExerciseViewDelegate {
        get {
            return _delegate!
        }
        set (newVal) {
            _delegate = newVal
        }
    }
    
    init() {
        
        _wrapperView = UIView()
        _wrapperView.translatesAutoresizingMaskIntoConstraints = false
        
        _scrollView = UIScrollView()
        _scrollView.translatesAutoresizingMaskIntoConstraints = false
        _scrollView.bounces = true
        _scrollView.isScrollEnabled = true
        
        _nameTextField = InsetTextField()
        _nameTextField.translatesAutoresizingMaskIntoConstraints = false
        _nameTextField.backgroundColor = .secondarySystemBackground
        _nameTextField.placeholder = "Exercise Name"
        
        _muscleGroupLabel = UILabel()
        _muscleGroupLabel.text = "Muscle Groups"
        _muscleGroupLabel.translatesAutoresizingMaskIntoConstraints = false
        _muscleGroupLabel.numberOfLines = 0
        _muscleGroupLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
        _muscleGroupLabel.isUserInteractionEnabled = true
        
        _groupPickerLabel = UILabel()
        _groupPickerLabel.translatesAutoresizingMaskIntoConstraints = false
        _groupPickerLabel.isUserInteractionEnabled = true
        _groupPickerLabel.numberOfLines = 0
        _groupPickerLabel.textAlignment = .center
        _groupPickerLabel.font = UIFont.systemFont(ofSize: 12.0)
        
        _weightTextField = InsetTextField()
        _weightTextField.translatesAutoresizingMaskIntoConstraints = false
        _weightTextField.backgroundColor = .secondarySystemBackground
        _weightTextField.placeholder = "Starting Weight"
        _weightTextField.keyboardType = .decimalPad
        
        _repsTextField = InsetTextField()
        _repsTextField.translatesAutoresizingMaskIntoConstraints = false
        _repsTextField.backgroundColor = .secondarySystemBackground
        _repsTextField.placeholder = "Starting Reps"
        _repsTextField.keyboardType = .numbersAndPunctuation
        _repsTextField.keyboardType = .numbersAndPunctuation
        
        _linkTextField = InsetTextField()
        _linkTextField.translatesAutoresizingMaskIntoConstraints = false
        _linkTextField.backgroundColor = .secondarySystemBackground
        _linkTextField.placeholder = "Link"
        
        super.init(frame: CGRect())
        self.translatesAutoresizingMaskIntoConstraints = false
        _wrapperView.addSubview(_nameTextField)
        _wrapperView.addSubview(_muscleGroupLabel)
        _wrapperView.addSubview(_groupPickerLabel)
        _wrapperView.addSubview(_weightTextField)
        _wrapperView.addSubview(_repsTextField)
        _wrapperView.addSubview(_linkTextField)
        _scrollView.addSubview(_wrapperView)
        self.addSubview(_scrollView)
        _autolayoutSubviews()
        _scrollView.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:UIResponder.keyboardWillHideNotification, object: nil)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        _scrollView.addGestureRecognizer(tap)
        
        let groupPickerLabelTap = UITapGestureRecognizer(target: self, action: #selector(self.handleGroupPickerLabelTap(_:)))
        let muscleGroupLabelTap = UITapGestureRecognizer(target: self, action: #selector(self.handleGroupPickerLabelTap(_:)))
        _groupPickerLabel.addGestureRecognizer(groupPickerLabelTap)
        _muscleGroupLabel.addGestureRecognizer(muscleGroupLabelTap)
    }
    
    @objc func handleGroupPickerLabelTap(_ sender: UITapGestureRecognizer? = nil) {
        delegate.didSelectMuscleGroupSelector()
        print("tapped")
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        _scrollView.endEditing(true)
    }
    
    @objc func keyboardWillShow(notification:NSNotification) {

        guard let userInfo = notification.userInfo else { return }
        var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.convert(keyboardFrame, from: nil)

        var contentInset:UIEdgeInsets = self._scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height + 20
        _scrollView.contentInset = contentInset
    }

    @objc func keyboardWillHide(notification:NSNotification) {
        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        _scrollView.contentInset = contentInset
    }
    
    private func _autolayoutSubviews() {
        let HorizontalConstraints = [
            _scrollView.leftAnchor.constraint(equalTo: self.leftAnchor),
            _scrollView.rightAnchor.constraint(equalTo: self.rightAnchor),
            
            _wrapperView.leftAnchor.constraint(equalTo: _scrollView.leftAnchor),
            _wrapperView.rightAnchor.constraint(equalTo: _scrollView.rightAnchor),
            _wrapperView.widthAnchor.constraint(equalTo: self.widthAnchor),
            
            _nameTextField.widthAnchor.constraint(equalTo: _wrapperView.widthAnchor, multiplier: 0.8),
            _nameTextField.centerXAnchor.constraint(equalTo: _wrapperView.centerXAnchor),
            
            _muscleGroupLabel.centerXAnchor.constraint(equalTo: _wrapperView.centerXAnchor),
            _muscleGroupLabel.leftAnchor.constraint(greaterThanOrEqualTo: _wrapperView.leftAnchor, constant: 10),
            _muscleGroupLabel.rightAnchor.constraint(lessThanOrEqualTo: _wrapperView.rightAnchor, constant: -10),
            
            _groupPickerLabel.centerXAnchor.constraint(equalTo: _wrapperView.centerXAnchor),
            _groupPickerLabel.leftAnchor.constraint(greaterThanOrEqualTo: _wrapperView.leftAnchor, constant: 10),
            _groupPickerLabel.rightAnchor.constraint(lessThanOrEqualTo: _wrapperView.rightAnchor, constant: -10),
            
            _weightTextField.widthAnchor.constraint(equalTo: _wrapperView.widthAnchor, multiplier: 0.4),
            _weightTextField.centerXAnchor.constraint(equalTo: _wrapperView.centerXAnchor),
            
            _repsTextField.widthAnchor.constraint(equalTo: _wrapperView.widthAnchor, multiplier: 0.4),
            _repsTextField.centerXAnchor.constraint(equalTo: _wrapperView.centerXAnchor),
            
            _linkTextField.widthAnchor.constraint(equalTo: _wrapperView.widthAnchor, multiplier: 0.6),
            _linkTextField.centerXAnchor.constraint(equalTo: _wrapperView.centerXAnchor),
        ]
        
        let VerticalConstraints = [
            _scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            _scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            _wrapperView.topAnchor.constraint(equalTo: _scrollView.topAnchor),
            _wrapperView.bottomAnchor.constraint(equalTo: _scrollView.bottomAnchor),
            
            _nameTextField.topAnchor.constraint(equalTo: _wrapperView.topAnchor, constant: 50),
            
            _weightTextField.topAnchor.constraint(equalTo: _nameTextField.bottomAnchor, constant: 20),

            _repsTextField.topAnchor.constraint(equalTo: _weightTextField.bottomAnchor, constant: 20),
            
            _muscleGroupLabel.topAnchor.constraint(equalTo: _repsTextField.bottomAnchor, constant: 20),
            
            _groupPickerLabel.topAnchor.constraint(equalTo: _muscleGroupLabel.bottomAnchor, constant: 20),

            _linkTextField.topAnchor.constraint(equalTo: _muscleGroupLabel.bottomAnchor, constant: 20),
            _linkTextField.bottomAnchor.constraint(equalTo: _wrapperView.bottomAnchor, constant: -50),

        ]
        
        NSLayoutConstraint.activate(HorizontalConstraints)
        NSLayoutConstraint.activate(VerticalConstraints)
        
        
        
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.contentOffset.x = 0.0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
