//
//  MuscleGroupSelectorView.swift
//  Better
//
//  Created by John Jakobsen on 2/17/23.
//

import Foundation
import UIKit

protocol MuscleGroupSelectorViewDelegate: UITableViewDelegate, UITableViewDataSource {
    
}

class MuscleGroupSelectorView: UIView {
    
    let _tableView: UITableView!
    var _delegate: MuscleGroupSelectorViewDelegate?
    var delegate: MuscleGroupSelectorViewDelegate? {
        get {
            return _delegate
        }
        set (newVal){
            self._delegate = newVal
            _tableView.delegate = newVal
            _tableView.dataSource = newVal
        }
    }
    override init(frame: CGRect) {
        _tableView = UITableView()
        _tableView.translatesAutoresizingMaskIntoConstraints = false
        _tableView.separatorStyle = .none
        _tableView.rowHeight = UITableView.automaticDimension
        _tableView.estimatedRowHeight = 200
        _tableView.sectionHeaderTopPadding = 0
        _tableView.register(MuscleGroupCell.self, forCellReuseIdentifier: "MuscleGroupCell")
        
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(_tableView)
        _autolayoutSubviews()
    }
    
    convenience init() {
        self.init(frame: CGRect())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func _autolayoutSubviews() {
        let constraints = [
            _tableView.leftAnchor.constraint(equalTo: self.leftAnchor),
            _tableView.rightAnchor.constraint(equalTo: self.rightAnchor),
            _tableView.topAnchor.constraint(equalTo: self.topAnchor),
            _tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
