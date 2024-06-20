//
//  RoutinSelectionOptionView.swift
//  Better
//
//  Created by John Jakobsen on 4/13/24.
//

import Foundation
import UIKit

protocol RoutineSelectionOptionViewDelegate {
    func numberOfOptions(_ routineSelectionOptionView: RoutineSelectionOptionView) -> Int
    func optionForRowAt(_ routineSelectionOptionView: RoutineSelectionOptionView, row: Int) -> String
    func didSelectOption(row: Int)
    func didTapBackground()
}

class RoutineSelectionOptionView: UIView, UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate {
    
    var delegate: RoutineSelectionOptionViewDelegate? = nil
    let _tableView: UITableView
    let _containerView: UIView
    
    override init(frame: CGRect) {
        
        self._tableView = UITableView()
        self._tableView.separatorStyle = .singleLine
        self._tableView.rowHeight = UITableView.automaticDimension
        self._tableView.estimatedRowHeight = 200
        self._tableView.sectionHeaderTopPadding = 0
        self._tableView.translatesAutoresizingMaskIntoConstraints = false
        self._tableView.layer.cornerRadius = 10
        self._tableView.register(RoutineSelectionOptionCell.self, forCellReuseIdentifier: "RoutineSelectionOptionCell")
        
        self._containerView = UIView()
        self._containerView.translatesAutoresizingMaskIntoConstraints = false
        self._containerView.layer.cornerRadius = 10
        self._containerView.layer.masksToBounds = false
        self._containerView.layer.shadowColor = UIColor.black.cgColor
        self._containerView.layer.shadowOpacity = 0.30
        self._containerView.layer.shadowOffset = .zero
        self._containerView.layer.shadowRadius = 10
        self._containerView.addSubview(self._tableView)
        //self._tableView.layer.shadowPath = UIBezierPath(rect: self._tableView.bounds).cgPath

        super.init(frame: CGRect())

        self._tableView.delegate = self
        self._tableView.dataSource = self
        self.addSubview(_containerView)
        self._autolayoutSubviews(tableViewRect: frame)
        self.backgroundColor = .clear
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap))
        tap.delegate = self
        self.addGestureRecognizer(tap)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func _autolayoutSubviews(tableViewRect: CGRect) {
        let constraints = [
            _tableView.leftAnchor.constraint(equalTo: _containerView.leftAnchor),
            _tableView.rightAnchor.constraint(equalTo: _containerView.rightAnchor),
            _tableView.topAnchor.constraint(equalTo: _containerView.topAnchor),
            _tableView.bottomAnchor.constraint(equalTo: _containerView.bottomAnchor),
            _containerView.leftAnchor.constraint(greaterThanOrEqualTo: self.leftAnchor),
            _containerView.rightAnchor.constraint(lessThanOrEqualTo: self.rightAnchor),
            _containerView.topAnchor.constraint(greaterThanOrEqualTo: self.topAnchor),
            _containerView.bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor),
            _containerView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            _containerView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -150),
            _containerView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8),
            _containerView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.4)

        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.delegate?.numberOfOptions(self) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RoutineSelectionOptionCell") as? RoutineSelectionOptionCell ?? RoutineSelectionOptionCell(style: .default, reuseIdentifier: "RoutineSelectionOptionCell")
        
        cell.setCellInfo(name: self.delegate?.optionForRowAt(self, row: indexPath.row) ?? "", row: indexPath.row)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.didSelectOption(row: indexPath.row)
    }
    
    @objc private func handleTap() {
        self.delegate?.didTapBackground()
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.view?.isDescendant(of: self._containerView) ?? false {
            return false
        }
        return true
    }
    
}
