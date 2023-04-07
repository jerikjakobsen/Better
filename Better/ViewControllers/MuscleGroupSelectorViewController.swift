//
//  MuscleGroupSelectorViewController.swift
//  Better
//
//  Created by John Jakobsen on 2/17/23.
//

import Foundation
import UIKit

protocol MuscleGroupSelectorViewControllerDelegate {
    func didDismissMGController(selectedGroups: [String])
}

class MuscleGroupSelectorViewController: UIViewController, MuscleGroupSelectorViewDelegate {
    let _muscleGroupSelectorView: MuscleGroupSelectorView!
    var _selectedGroups: Set<String>
    var delegate: MuscleGroupSelectorViewControllerDelegate?
    convenience init(selectedGroups: [String]) {
        self.init(nibName: nil, bundle: nil)
        _muscleGroupSelectorView.delegate = self
        _selectedGroups = Set(selectedGroups)
        self.view.addSubview(_muscleGroupSelectorView)
        let constraints = [
            _muscleGroupSelectorView.leftAnchor.constraint(equalTo: view.leftAnchor),
            _muscleGroupSelectorView.rightAnchor.constraint(equalTo: view.rightAnchor),
            _muscleGroupSelectorView.topAnchor.constraint(equalTo: view.topAnchor),
            _muscleGroupSelectorView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        _muscleGroupSelectorView = MuscleGroupSelectorView()
        _selectedGroups = Set()
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MuscleGroup.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MuscleGroupCell") as! MuscleGroupCell
        cell.setCellInfo(text: MuscleGroup.allCases[indexPath.row].rawValue, selected: _selectedGroups.contains(MuscleGroup.allCases[indexPath.row].rawValue))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! MuscleGroupCell
        if _selectedGroups.contains(cell._label.text!) {
            cell.toggleActiveState(active: false)
            _selectedGroups.remove(cell._label.text!)
        } else {
            _selectedGroups.insert(cell._label.text!)
            cell.toggleActiveState(active: true)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        delegate?.didDismissMGController(selectedGroups: Array(_selectedGroups))
    }
    
}
