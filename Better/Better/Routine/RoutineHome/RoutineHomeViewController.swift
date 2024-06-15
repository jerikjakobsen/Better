//
//  RoutineHomeViewController.swift
//  Better
//
//  Created by John Jakobsen on 4/11/24.
//

import UIKit

class RoutineHomeViewController: UIViewController {
    
    let _headerView: RoutineHomeHeaderSectionView!
    let _routineHomeView: RoutineHomeView!
    let _routineSelectionView: RoutineSelectionView!
    
    let routines: [Routine] = [.init(id: "123", name: "Routine #1", current_routine_number: 1, days: [.init(name: "Day 1: Legs", id: "123", completed: true), .init(name: "Day 2: Arms", id: "132", completed: true), .init(name: "Day 3: Back", id: "12443", completed: false)]), .init(id: "1234", name: "Routine #2: asdadsasdasdas asdasdas d adasdasds asd", current_routine_number: 2, days: [.init(name: "Day 1: Legs", id: "1", completed: false), .init(name: "Day 2: Upper Body", id: "2", completed: false)])]
    var selectedRoutine: Routine? = nil
    var withoutSelectedRoutine: [Routine] = []

    init() {
        self._routineHomeView = RoutineHomeView()
        self._headerView = RoutineHomeHeaderSectionView(reuseIdentifier: "RoutineHomeHeaderSectionView", viewModel: .init(routineNumber: 16, availableRestDays: 2, daysDone: 3, totalDays: 5))
        self._routineSelectionView = RoutineSelectionView()
        self._routineSelectionView.title = self.routines[0].name
        self._routineHomeView.register(RoutineHomeDayCell.self, forCellReuseIdentifier: "RoutineHomeDayCell")
        
        super.init(nibName: nil, bundle: nil)
        self.selectedRoutine = routines[0]
        self.tabBarItem = .init(title: "", image: UIImage(named: "weightlifter"), selectedImage: UIImage(named: "weightlifter"))
        
        self.view = self._routineHomeView

        self._routineHomeView.delegate = self
        self._routineHomeView.dataSource = self
        self._routineSelectionView.delegate = self
        
        self.navigationItem.titleView = self._routineSelectionView
        self.navigationController?.navigationBar.prefersLargeTitles = false
        
        self.navigationItem.rightBarButtonItem = .init(image: UIImage(named: "settings"), style: .plain, target: self, action: #selector(self.didTapSettings))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()        
    

        // Do any additional setup after loading the view.
    }

    @objc private func didTapSettings() {
        let settingsVC = RoutineSettingsViewController()
        self.navigationController?.pushViewController(settingsVC, animated: true)
    }

}

extension RoutineHomeViewController: RoutineHomeViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return self._headerView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.selectedRoutine?.days.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let notNilSelectedRoutine = self.selectedRoutine else {
            return UITableViewCell()
        }
        let cell: RoutineHomeDayCell = tableView.dequeueReusableCell(withIdentifier: "RoutineHomeDayCell") as? RoutineHomeDayCell ?? RoutineHomeDayCell(style: .default, reuseIdentifier: "RoutineHomeDayCell")
        let queriedDay = notNilSelectedRoutine.days[indexPath.row]
        cell.setCellInfo(viewModel: .init(day_id: queriedDay.id, day_name: queriedDay.name, is_completed: queriedDay.completed))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let notNilSelectedRoutine = self.selectedRoutine else {
            return
        }
        let day = notNilSelectedRoutine.days[indexPath.row]
        let vc = RoutineDoneDayDetailViewController(routine: notNilSelectedRoutine, day: day)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func navigateToDay(routineId: String, dayId: String) {
        if (selectedRoutine?.id ?? "N/A" != routineId) {
            for r in self.routines {
                if (routineId == r.id) {
                    self.didSelectRoutine(routine: r)
                }
            }
        }
        guard selectedRoutine?.id ?? "N/A" == routineId else {
            return
        }
        guard let notNilSelectedRoutine = self.selectedRoutine else {
            return
        }
        
        for d in notNilSelectedRoutine.days {
            if d.id == dayId {
                let vc = RoutineDoneDayDetailViewController(routine: notNilSelectedRoutine, day: d)
                self.navigationController?.pushViewController(vc, animated: true)
                return
            }
        }
    }
    
    func didSelectRoutine(routine: Routine) {
        self.selectedRoutine = routine
        self._routineSelectionView.title = self.selectedRoutine?.name ?? ""
        self._routineHomeView.reloadData()
        return
    }
    
}

extension RoutineHomeViewController: RoutineSelectionViewDelegate, RoutineSelectionViewControllerDelegate {
    func optionForRowAt(_ routineSelectionViewController: RoutineSelectionOptionViewController, row: Int) -> String {
        return self.withoutSelectedRoutine[row].name
    }
    
    func numberOfOptions(_ routineSelectionViewController: RoutineSelectionOptionViewController) -> Int {
        return self.withoutSelectedRoutine.count
    }
    
    func didSelectOptionAt(_ routineSelectionViewController: RoutineSelectionOptionViewController, row: Int) {
        didSelectRoutine(routine: self.withoutSelectedRoutine[row])
        routineSelectionViewController.dismiss(animated: false)
    }
    
    func didTapDropDown(_ routineSelectionView: RoutineSelectionView) {
        let vc = RoutineSelectionOptionViewController(frame: CGRect(x: 0, y: 20, width: self.view.frame.width * 0.8, height: self.view.frame.height * 0.4))
        self.withoutSelectedRoutine = self.routines.filter({ routine in
            return routine.id != self.selectedRoutine?.id ?? ""
        })
        vc.delegate = self
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .coverVertical
        self.present(vc, animated: true)
    }
}
