//
//  RoutineSelectionOptionViewController.swift
//  Better
//
//  Created by John Jakobsen on 4/13/24.
//

import Foundation
import UIKit

protocol RoutineSelectionViewControllerDelegate {
    func optionForRowAt(_ routineSelectionViewController: RoutineSelectionOptionViewController, row: Int) -> String
    func numberOfOptions(_ routineSelectionViewController: RoutineSelectionOptionViewController) -> Int
    func didSelectOptionAt(_ routineSelectionViewController: RoutineSelectionOptionViewController, row: Int)
}

class RoutineSelectionOptionViewController: UIViewController, RoutineSelectionOptionViewDelegate {
    
    let _routineSelectionOptionView: RoutineSelectionOptionView
    var delegate: RoutineSelectionViewControllerDelegate? = nil
    
    init(frame: CGRect) {
        
        _routineSelectionOptionView = RoutineSelectionOptionView()
        super.init(nibName: nil, bundle: nil)
        self.view = _routineSelectionOptionView
        _routineSelectionOptionView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func numberOfOptions(_ routineSelectionOptionView: RoutineSelectionOptionView) -> Int {
        return self.delegate?.numberOfOptions(self) ?? 0
    }
    
    func optionForRowAt(_ routineSelectionOptionView: RoutineSelectionOptionView, row: Int) -> String {
        return self.delegate?.optionForRowAt(self, row: row) ?? ""
    }
    
    func didSelectOption(row: Int) {
        self.delegate?.didSelectOptionAt(self, row: row)
    }
    
    func didTapBackground() {
        self.dismiss(animated: true)
    }
}
