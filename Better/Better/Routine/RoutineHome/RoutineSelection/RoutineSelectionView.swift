//
//  SelectRoutinePickerView.swift
//  Better
//
//  Created by John Jakobsen on 4/12/24.
//

import Foundation
import UIKit

protocol RoutineSelectionViewDelegate {
//    func didSelectRow(_ pickerView: RoutineSelectionView, row: Int)
//    func titleForRowAt(_ pickerView: RoutineSelectionView, row: Int) -> String
//    func numberOfRows(_ pickerView: RoutineSelectionView) -> Int
    func didTapDropDown(_ routineSelectionView: RoutineSelectionView)
}
class RoutineSelectionView: UIView {
    
    var delegate: RoutineSelectionViewDelegate? = nil
    var title: String? {
        get {
            return self._titleLabel.text
        }
        set (newVal){
            self._titleLabel.text = newVal
        }
    }
    
    let _contentView: UIView
    let _titleLabel: UILabel
    let _dropDownButton: UIButton
    
    init() {
        _titleLabel = UILabel()
        _titleLabel.translatesAutoresizingMaskIntoConstraints = false
        _titleLabel.font = Fonts.Montserrat_Medium
        _titleLabel.textColor = Colors.blackTextColor
        
        _dropDownButton = UIButton()
        _dropDownButton.translatesAutoresizingMaskIntoConstraints = false
        _dropDownButton.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        
        _contentView = UIView()
        _contentView.translatesAutoresizingMaskIntoConstraints = false
        _contentView.addSubview(_titleLabel)
        _contentView.addSubview(_dropDownButton)
        
        super.init(frame: CGRect())
        self.translatesAutoresizingMaskIntoConstraints = false
        
        _dropDownButton.addTarget(self, action: #selector(self.didSelectDropDown), for: .touchUpInside)
        self.addSubview(_contentView)
        self._autolayoutSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func _autolayoutSubviews() {
        let constraints = [
            _titleLabel.leftAnchor.constraint(greaterThanOrEqualTo: _contentView.leftAnchor),
            _titleLabel.topAnchor.constraint(equalTo: _contentView.topAnchor),
            _titleLabel.bottomAnchor.constraint(lessThanOrEqualTo: _contentView.bottomAnchor),
            _titleLabel.centerXAnchor.constraint(equalTo: _contentView.centerXAnchor),
            
            _dropDownButton.leftAnchor.constraint(greaterThanOrEqualTo: _titleLabel.rightAnchor, constant: 10),
            _dropDownButton.topAnchor.constraint(greaterThanOrEqualTo: _contentView.topAnchor),
            _dropDownButton.bottomAnchor.constraint(lessThanOrEqualTo: _contentView.bottomAnchor),
            _dropDownButton.rightAnchor.constraint(equalTo: _contentView.rightAnchor),
            _dropDownButton.centerYAnchor.constraint(equalTo: _contentView.centerYAnchor),
            _dropDownButton.widthAnchor.constraint(equalToConstant: 20),
            _dropDownButton.heightAnchor.constraint(equalToConstant: 20),
            
            _contentView.widthAnchor.constraint(equalTo: self.widthAnchor),
            _contentView.heightAnchor.constraint(equalTo: self.heightAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    @objc private func didSelectDropDown() {
        self.delegate?.didTapDropDown(self)
    }
    
}
