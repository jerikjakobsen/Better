//
//  Weight.swift
//  Better
//
//  Created by John Jakobsen on 2/8/23.
//

import Foundation
import UIKit
import Charts

protocol WeightViewDelegate: UITableViewDelegate, UITableViewDataSource, ChartViewDelegate {}

class WeightView: UIView {
    
    let _weightsTableView: UITableView!
    var _delegate: WeightViewDelegate?
    var delegate: WeightViewDelegate? {
        get {
            return _delegate
        }
        set (newVal) {
            _weightsTableView.delegate = newVal
            _weightsTableView.dataSource = newVal
            _delegate = newVal
        }
    }
    convenience init() {
        self.init(frame: CGRect())
        backgroundColor = .systemBackground
        self.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(_weightsTableView)
        
        _autolayoutSubViews()
    }
    override init(frame: CGRect) {
        _weightsTableView = UITableView()
        _weightsTableView.translatesAutoresizingMaskIntoConstraints = false
        _weightsTableView.rowHeight = UITableView.automaticDimension
        _weightsTableView.estimatedRowHeight = 200
        _weightsTableView.sectionHeaderTopPadding = 0
        _weightsTableView.register(WeightRecordCell.self, forCellReuseIdentifier: "WeightRecordCell")
        
        super.init(frame: frame)
    }
    
    private func _autolayoutSubViews() {
        let constraints = [
            _weightsTableView.leftAnchor.constraint(equalTo: self.leftAnchor),
            _weightsTableView.rightAnchor.constraint(equalTo: self.rightAnchor),
            _weightsTableView.topAnchor.constraint(equalTo: self.topAnchor),
            _weightsTableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
