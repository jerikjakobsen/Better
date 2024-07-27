//
//  AddMuscleGroupView.swift
//  Better
//
//  Created by John Jakobsen on 7/20/24.
//

import Foundation
import UIKit

protocol AddMuscleGroupViewDelegate {
    func numberOfMuscleGroups() -> Int
    func muscleGroupTitleForRowAt(_ row: Int) -> String
    func searchTextDidChangeTo(_ text: String)
    func didSelectMuscleGroupAt(_ row: Int)
}

class AddMuscleGroupView: UIView {
    let searchbarView: UISearchBar
    let tableView: UITableView
    
    var delegate: AddMuscleGroupViewDelegate? = nil
    
    init() {
        self.tableView = UITableView()
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.register(ExerciseCreationTitleCell.self, forCellReuseIdentifier: ExerciseCreationTitleCell.reuseIdentifier)
        self.tableView.separatorStyle = .none
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 200
        self.tableView.sectionHeaderTopPadding = 0
        self.tableView.keyboardDismissMode = .onDrag
        self.tableView.backgroundColor = .clear
        
        self.searchbarView = UISearchBar()
        self.searchbarView.translatesAutoresizingMaskIntoConstraints = false
        self.searchbarView.searchTextField.font = Fonts.Montserrat_Small_Medium
        self.searchbarView.searchTextField.textColor = Colors.blackTextColor
        self.searchbarView.backgroundColor = .white
        self.searchbarView.searchBarStyle = .prominent
        self.searchbarView.barTintColor = .white
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: Colors.greyTextColor // Set your desired placeholder color here
        ]
        let attributedPlaceholder = NSAttributedString(string: "Search Muscle Groups...", attributes: attributes)
        self.searchbarView.searchTextField.attributedPlaceholder = attributedPlaceholder
        
        super.init(frame: CGRect())
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.searchbarView.delegate = self
        self.addSubview(self.searchbarView)
        self.addSubview(self.tableView)
        self.backgroundColor = .white
        
        self.autolayoutSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func autolayoutSubviews() {
        NSLayoutConstraint.activate([
            searchbarView.leftAnchor.constraint(greaterThanOrEqualTo: self.leftAnchor, constant: 10),
            searchbarView.rightAnchor.constraint(lessThanOrEqualTo: self.rightAnchor, constant: -10),
            searchbarView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            searchbarView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            searchbarView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
            
            tableView.leftAnchor.constraint(equalTo: self.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: self.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            tableView.topAnchor.constraint(equalTo: searchbarView.bottomAnchor, constant: 5)
        ])
    }
    
    public func reloadMuscleGroups() {
        self.tableView.reloadData()
    }
}

extension AddMuscleGroupView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.delegate?.numberOfMuscleGroups() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (self.tableView.dequeueReusableCell(withIdentifier: ExerciseCreationTitleCell.reuseIdentifier) as? ExerciseCreationTitleCell) ??  ExerciseCreationTitleCell(style: .default, reuseIdentifier: ExerciseCreationTitleCell.reuseIdentifier)
        
        cell.setCellInfo(title: self.delegate?.muscleGroupTitleForRowAt(indexPath.row) ?? "")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.didSelectMuscleGroupAt(indexPath.row)
    }
}

extension AddMuscleGroupView: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.delegate?.searchTextDidChangeTo(searchText)
    }
}
