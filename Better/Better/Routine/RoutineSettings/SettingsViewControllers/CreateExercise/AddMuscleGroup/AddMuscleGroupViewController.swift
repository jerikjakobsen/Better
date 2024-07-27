//
//  AddMuscleGroupViewController.swift
//  Better
//
//  Created by John Jakobsen on 7/20/24.
//

import Foundation
import UIKit

protocol AddMuscleGroupViewControllerDelegate {
    func didSelectMuscleGroup(_ muscleGroup: MuscleGroup)
}

class AddMuscleGroupViewController: UIViewController {
    
    let addMuscleGroupView: AddMuscleGroupView
    var searchedMuscleGroups: [MuscleGroup]
    let fullMuscleGroupList: [MuscleGroup]
    
    public var delegate: AddMuscleGroupViewControllerDelegate? = nil
    
    init() {
        self.addMuscleGroupView = AddMuscleGroupView()
        
        self.fullMuscleGroupList = [
            .init(name: "Abs", id: ""),
            .init(name: "Hamstrings", id: ""),
            .init(name: "Biceps", id: ""),
            .init(name: "Triceps", id: ""),
            .init(name: "Front Deltoids", id: ""),
            .init(name: "Latissimus Dorsi", id: ""),
            .init(name: "Middle Deltoids", id: ""),
            .init(name: "Back Deltoids", id: ""),
            .init(name: "Upper Chest", id: ""),
            .init(name: "Lower Chest", id: "")
        ]
        
        self.searchedMuscleGroups = fullMuscleGroupList
        
        super.init(nibName: nil, bundle: nil)
        
        self.navigationItem.setLeftChevronButton(viewController: self)
        
        addMuscleGroupView.delegate = self
        self.view = addMuscleGroupView
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AddMuscleGroupViewController: AddMuscleGroupViewDelegate {
    
    func numberOfMuscleGroups() -> Int {
        return self.searchedMuscleGroups.count
    }
    
    func muscleGroupTitleForRowAt(_ row: Int) -> String {
        return self.searchedMuscleGroups[row].name
    }
    
    func searchTextDidChangeTo(_ text: String) {
        let processedSearchText = text.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        if processedSearchText == "" {
            self.searchedMuscleGroups = self.fullMuscleGroupList
            self.addMuscleGroupView.reloadMuscleGroups()
            return
        }
        self.searchedMuscleGroups = self.fullMuscleGroupList.filter { muscleGroup in
            return muscleGroup.name.lowercased().contains(processedSearchText)
        }
        self.addMuscleGroupView.reloadMuscleGroups()
    }
    
    func didSelectMuscleGroupAt(_ row: Int) {
        self.delegate?.didSelectMuscleGroup(self.searchedMuscleGroups[row])
        self.navigationController?.popViewController(animated: true)
    }
    
}
