//
//  ExerciseEditableCell.swift
//  Better
//
//  Created by John Jakobsen on 2/12/23.
//

import Foundation
import UIKit

protocol ExerciseEditableCellDelegate {
    func addRecord(exerciseRecord: ExerciseRecord)
}

class ExerciseEditableCell: UITableViewCell {
    let _nameLabel: UILabel!
    let _muscleGroupsLabel: UILabel!
    let _linkLabel: UILabel!
    let _weightTextField: UITextField!
    let _repsTextField: UITextField!
    let _doneImageView: UIImageView!
    let _addButton: UIButton!
    var _exercise: Exercise?
    var delegate: ExerciseEditableCellDelegate?
    var exercise: Exercise? {
        get {
            return _exercise
        }
        set (newVal) {
            _exercise = newVal
            _nameLabel.text = newVal!.name
            var typeText = ""
            for type in newVal!.type {
                typeText += "\(type?.rawValue ?? ""), "
            }
            _muscleGroupsLabel.text = String(typeText.prefix(typeText.count-2))
            _linkLabel.text = newVal!.link
            _weightTextField.placeholder = String(format: "%.2f", newVal!.weight!)
            _repsTextField.placeholder = newVal!.reps
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        _nameLabel = UILabel()
        _nameLabel.translatesAutoresizingMaskIntoConstraints = false
        _nameLabel.numberOfLines = 0
        
        _muscleGroupsLabel = UILabel()
        _muscleGroupsLabel.translatesAutoresizingMaskIntoConstraints = false
        _muscleGroupsLabel.numberOfLines = 0
        
        _linkLabel = UILabel()
        _linkLabel.translatesAutoresizingMaskIntoConstraints = false
        _linkLabel.numberOfLines = 0
        
        _weightTextField = InsetTextField()
        _weightTextField.translatesAutoresizingMaskIntoConstraints = false
        _weightTextField.keyboardType = .decimalPad

        _repsTextField = InsetTextField()
        _repsTextField.translatesAutoresizingMaskIntoConstraints = false
        _repsTextField.keyboardType = .numbersAndPunctuation
        
        _doneImageView = UIImageView()
        _doneImageView.translatesAutoresizingMaskIntoConstraints = false
        
        _addButton = UIButton(type: .system)
        _addButton.setTitle("Add Record", for: .normal)
        _addButton.translatesAutoresizingMaskIntoConstraints = false
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(_nameLabel)
        self.contentView.addSubview(_muscleGroupsLabel)
        self.contentView.addSubview(_linkLabel)
        self.contentView.addSubview(_weightTextField)
        self.contentView.addSubview(_repsTextField)
        self.contentView.addSubview(_addButton)
        //self.contentView.addSubview(_doneImageView)
        _addButton.addTarget(self, action: #selector(didPressAddRecord), for: .touchUpInside)
        _autolayoutSubviews()
    }
    
    @objc func didPressAddRecord() {
        guard let id = _exercise?.id, let w = Float(_weightTextField.text!), let r = _repsTextField.text  else {return}
        delegate?.addRecord(exerciseRecord: ExerciseRecord(exerciseID: id , weight: w, reps: r, date: Date.now))
    }
    
    private func _autolayoutSubviews() {
        let constraints = [
            _nameLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 10),
            _nameLabel.rightAnchor.constraint(lessThanOrEqualTo: self._addButton.leftAnchor, constant: 10),
            _nameLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),

            
            _addButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            _addButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            _addButton.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: 10),
            
            _muscleGroupsLabel.leftAnchor.constraint(equalTo: _nameLabel.leftAnchor),
            _muscleGroupsLabel.rightAnchor.constraint(lessThanOrEqualTo: self.contentView.rightAnchor, constant: 10),
            _muscleGroupsLabel.topAnchor.constraint(equalTo: _nameLabel.bottomAnchor, constant: 10),
            
            _weightTextField.leftAnchor.constraint(equalTo: _nameLabel.leftAnchor),
            _weightTextField.topAnchor.constraint(equalTo: _muscleGroupsLabel.bottomAnchor, constant: 10),
            _weightTextField.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: 10),
            
            _repsTextField.leftAnchor.constraint(equalTo: _nameLabel.leftAnchor),
            _repsTextField.topAnchor.constraint(equalTo: _weightTextField.bottomAnchor, constant: 10),
            _repsTextField.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: 10),
            
            _linkLabel.leftAnchor.constraint(equalTo: _nameLabel.leftAnchor),
            _linkLabel.topAnchor.constraint(equalTo: _repsTextField.bottomAnchor, constant: 10),
            _linkLabel.rightAnchor.constraint(lessThanOrEqualTo: self.contentView.rightAnchor, constant: 10),
            _linkLabel.bottomAnchor.constraint(lessThanOrEqualTo: self.contentView.bottomAnchor, constant: -10)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func setCellInfo(exercise: Exercise) {
        self.exercise = exercise
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
