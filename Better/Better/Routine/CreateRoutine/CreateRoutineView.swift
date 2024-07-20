//
//  CreateRoutineView.swift
//  Better
//
//  Created by John Jakobsen on 6/20/24.
//

import Foundation
import UIKit

protocol CreateRoutineViewDelegate {
    func dayNameForCellAt(_ row: Int) -> String
    func numberOfDays() -> Int
    func numberOfExercisesForDay(_ day: Int) -> Int
    func exerciseForDay(_ day: Int, exerciseIdx: Int) -> Exercise
    func didDeleteDayAt(_ row: Int)
    func didAddDay(name: String)
    func didMoveDayFrom(_ sourceIdx: Int, to destinationIdx: Int)
    func didDeleteExercise(_ exerciseRow: Int, from dayRow: Int)
    func didAddExercise(to dayRow: Int)
    func didTapSave(routineName: String)
    func reloadDays()
    func didEditTitleForDay(_ day: Int, title: String)
    func didTapOpen(dayRow: Int, noChange: Bool)
    func isDayOpen(dayRow: Int) -> Bool
}

class CreateRoutineView: UIView {
    
    let routineTitleTextField: UnderlinedTextField
    let tableView: UITableView
    let addDayHeaderView: AddDayHeaderView
    
    var tableViewBumpedAmount: CGFloat = 0.0
    
    var delegate: CreateRoutineViewDelegate? = nil
    
    init() {
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ExerciseCreationTitleCell.self, forCellReuseIdentifier: ExerciseCreationTitleCell.reuseIdentifier)
        tableView.register(SingleActionCell.self, forCellReuseIdentifier: SingleActionCell.reuseIdentifier)
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
        tableView.sectionHeaderTopPadding = 0
        tableView.keyboardDismissMode = .onDrag
        tableView.backgroundColor = .clear
        
        routineTitleTextField = UnderlinedTextField(placeholder: "Routine Title")
        routineTitleTextField.translatesAutoresizingMaskIntoConstraints = false
        routineTitleTextField.font = Fonts.Montserrat_Medium
        routineTitleTextField.textColor = Colors.blackTextColor
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: Colors.greyTextColor // Set your desired placeholder color here
        ]
        let attributedPlaceholder = NSAttributedString(string: "Routine Title", attributes: attributes)
        routineTitleTextField.attributedPlaceholder = attributedPlaceholder
        
        addDayHeaderView = AddDayHeaderView()
                
        super.init(frame: CGRect())
        
        self.addSubview(tableView)
        self.addSubview(routineTitleTextField)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        addDayHeaderView.delegate = self
        
        self.backgroundColor = .white
        
        self.autolayoutSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func autolayoutSubviews() {
        NSLayoutConstraint.activate([
            routineTitleTextField.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 40),
            routineTitleTextField.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            routineTitleTextField.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -40),
            routineTitleTextField.heightAnchor.constraint(equalToConstant: 40),
            
            tableView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            tableView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
            tableView.topAnchor.constraint(equalTo: routineTitleTextField.bottomAnchor, constant: 20),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
        ])
    }
    
    public func addExerciseToDay(_ day: Int) {
        guard let del = self.delegate else {
            return
        }
        let numExercisesInSection = del.numberOfExercisesForDay(day)
        self.tableView.beginUpdates()
        self.tableView.insertRows(at: [IndexPath(row: numExercisesInSection-1, section: day)], with: .top)
        self.tableView.endUpdates()
    }
    
    func moveTableViewBy(_ moveAmount: CGFloat) {
        let currentOffset = tableView.contentOffset
        let newOffset = CGPoint(x: currentOffset.x, y: currentOffset.y + moveAmount)
        self.tableViewBumpedAmount = moveAmount
        // Set the content offset with optional animation
        tableView.setContentOffset(newOffset, animated: true)
        self.layoutIfNeeded()
    }
    
    func resetTableViewPosition() {
        let currentOffset = tableView.contentOffset
        let newOffset = CGPoint(x: currentOffset.x, y: currentOffset.y - self.tableViewBumpedAmount)
        
        // Set the content offset with optional animation
        tableView.setContentOffset(newOffset, animated: true)
        self.layoutIfNeeded()
    }
    
    func toggleDayExpanded(dayRow: Int, noChange: Bool) {
        self.tableView.beginUpdates()
        delegate?.didTapOpen(dayRow: dayRow, noChange: noChange)
        guard let openStatus = delegate?.isDayOpen(dayRow: dayRow) else {
            return
        }
        var indexPaths: [IndexPath] = []
        guard let del = delegate else {
            return
        }
        
        indexPaths = (0 ... del.numberOfExercisesForDay(dayRow)).map({ i in
            return IndexPath(row: i, section: dayRow)
        })
        
        if openStatus {
            self.tableView.insertRows(at: indexPaths, with: .top)
        } else {
            self.tableView.deleteRows(at: indexPaths, with: .top)
        }
        
        self.tableView.endUpdates()
    }
    
    func removeDay(_ dayIndex: Int) {
        self.tableView.beginUpdates()
        self.delegate?.didDeleteDayAt(dayIndex)
        let indexSet = IndexSet(integer: dayIndex)
        self.tableView.deleteSections(indexSet, with: .middle)
        self.tableView.endUpdates()
        for section in 0..<(tableView.numberOfSections-1) {
            if let headerView = tableView.headerView(forSection: section) as? DayTitleHeaderView {
                headerView.setDayIndex(dayIndex: section)
            }
        }
        
    }
    
    func reloadTableView() {
        self.tableView.reloadData()
    }
}

extension CreateRoutineView: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return (self.delegate?.numberOfDays() ?? 0) + 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if delegate?.isDayOpen(dayRow: section) ?? false {
            return (self.delegate?.numberOfExercisesForDay(section) ?? 0) + 1
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == (self.delegate?.numberOfExercisesForDay(indexPath.section) ?? 1) {
            let cell = (tableView.dequeueReusableCell(withIdentifier: SingleActionCell.reuseIdentifier) as? SingleActionCell) ?? SingleActionCell(style: .default, reuseIdentifier: SingleActionCell.reuseIdentifier)
            cell.setTitle("Add Exercise")
            return cell
        }
        let exercise = self.delegate?.exerciseForDay(indexPath.section, exerciseIdx: indexPath.row)
        
        let cell = (tableView.dequeueReusableCell(withIdentifier: ExerciseCreationTitleCell.reuseIdentifier) as? ExerciseCreationTitleCell) ?? ExerciseCreationTitleCell(style: .default, reuseIdentifier: ExerciseCreationTitleCell.reuseIdentifier)
        cell.setCellInfo(title: exercise?.name ?? "")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let del = self.delegate else {
            return nil
        }
        let totalSections = del.numberOfDays()
        if totalSections == section {
            return self.addDayHeaderView
        }
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: DayTitleHeaderView.reuseIdentifier) as? DayTitleHeaderView ?? DayTitleHeaderView(reuseIdentifier: DayTitleHeaderView.reuseIdentifier)
        headerView.delegate = self
        headerView.dayIndex = section
        headerView.setTextField(text: del.dayNameForCellAt(section))
        
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let del = self.delegate else {
            return
        }
        let numExercisesInSection = del.numberOfExercisesForDay(indexPath.section)
        if numExercisesInSection == indexPath.row {
            del.didAddExercise(to: indexPath.section)
        }
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard let del = self.delegate else {
            return nil
        }
        if del.numberOfExercisesForDay(indexPath.section) > indexPath.row {
            let deleteAction = UIContextualAction(style: .destructive, title: "Remove") {
                (action, sourceView, completionHandler) in
                self.delegate?.didDeleteExercise(indexPath.row, from: indexPath.section)
                self.tableView.beginUpdates()
                self.tableView.deleteRows(at: [indexPath], with: .top)
                self.tableView.endUpdates()
            }
            let swipeConfiguration = UISwipeActionsConfiguration(actions: [deleteAction])
            return swipeConfiguration
        }
        return nil
    }
    
}

extension CreateRoutineView: DayTitleHeaderViewDelegate {
    
    func didEditTitleTextField(_ text: String, dayIndex: Int) {
        self.delegate?.didEditTitleForDay(dayIndex, title: text)
    }
    
    func didTapOpen(dayIndex: Int, noChange: Bool) {
        self.toggleDayExpanded(dayRow: dayIndex, noChange: noChange)
    }
    
    func dayStatus(dayRow: Int) -> Bool {
        return self.delegate?.isDayOpen(dayRow: dayRow) ?? true
    }
    
    func didTapRemove(dayIndex: Int) {
        self.removeDay(dayIndex)
    }
}

extension CreateRoutineView: AddDayHeaderViewDelegate {
    func didTapAddDay() {
        guard let del = self.delegate else {
            return
        }
        self.tableView.beginUpdates()
        del.didAddDay(name: "")
        self.tableView.insertSections(IndexSet(integer: del.numberOfDays()-1), with: .top)
        self.tableView.insertRows(at: [IndexPath(row: 0, section: del.numberOfDays()-1)], with: .top)
        self.tableView.endUpdates()
    }
}
