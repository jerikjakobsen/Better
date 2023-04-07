//
//  EditableWeight.swift
//  Better
//
//  Created by John Jakobsen on 2/18/23.
//

import Foundation
import UIKit
import Charts
protocol EditableWeightCellDelegate {
    func didAddWeightRecord(weight: Float)
    func getLineChartData() -> LineChartData?
    func getLineChartXAxisLabels() -> [String]?
}
class EditableWeightSectionView: UITableViewHeaderFooterView {
    
    let _weightTextField: UITextField!
    let _addButton: UIButton!
    var delegate: EditableWeightCellDelegate?
    let _lineChartView: LineChartView
    let _titleLabel: UILabel!
    var chartHeightAnchor: NSLayoutConstraint?
    
    override init(reuseIdentifier: String?) {
        
        _titleLabel = UILabel()
        _titleLabel.translatesAutoresizingMaskIntoConstraints = false
        _titleLabel.text = "Weight Progress"
        _titleLabel.font = FontConstants.LabelTitle1
     
        _weightTextField = InsetTextField()
        _weightTextField.translatesAutoresizingMaskIntoConstraints = false
        _weightTextField.keyboardType = .decimalPad
        _weightTextField.placeholder = "0.0 lbs"
        
        _addButton = UIButton(type: .system)
        _addButton.translatesAutoresizingMaskIntoConstraints = false
        _addButton.setTitle("Add Record", for: .normal)
        
        _lineChartView = LineChartView()
        _lineChartView.translatesAutoresizingMaskIntoConstraints = false
        
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.addSubview(_titleLabel)
        contentView.addSubview(_weightTextField)
        contentView.addSubview(_addButton)
        contentView.addSubview(_lineChartView)
        _addButton.addTarget(self, action: #selector(addWeightRecord), for: .touchUpInside)
        
        _autolayoutSubViews()
        _setupLineChartView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func addWeightRecord() {
        guard let weight: Float = Float(_weightTextField.text!) else {return}
        delegate?.didAddWeightRecord(weight: weight)
        self.reloadChart()
        self._weightTextField.text = ""
    }
    
    func reloadChart() {
        _lineChartView.data = delegate?.getLineChartData()
        if let indexValues = delegate?.getLineChartXAxisLabels() {
            _lineChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: indexValues)
        }
    }
    
    func _autolayoutSubViews() {
        
        let constraints = [
            _titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            _titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            _titleLabel.leftAnchor.constraint(greaterThanOrEqualTo: contentView.leftAnchor, constant: 10),
            _titleLabel.rightAnchor.constraint(lessThanOrEqualTo: contentView.rightAnchor, constant: -10),
            
            _lineChartView.topAnchor.constraint(equalTo: _titleLabel.bottomAnchor, constant: 10),
            _lineChartView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            _lineChartView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            _lineChartView.heightAnchor.constraint(equalToConstant: 300),
            
            _weightTextField.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            _weightTextField.topAnchor.constraint(equalTo: _lineChartView.bottomAnchor, constant: 20),
            _weightTextField.leftAnchor.constraint(greaterThanOrEqualTo: contentView.leftAnchor, constant: 10),
            _weightTextField.rightAnchor.constraint(lessThanOrEqualTo: contentView.rightAnchor, constant: -10),
            _weightTextField.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.6),
            
            _addButton.topAnchor.constraint(equalTo: _weightTextField.bottomAnchor, constant: 10),
            _addButton.leftAnchor.constraint(greaterThanOrEqualTo: contentView.leftAnchor, constant: 10),
            _addButton.rightAnchor.constraint(lessThanOrEqualTo: contentView.rightAnchor, constant: -10),
            _addButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            _addButton.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -10)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    
    func _setupLineChartView() {
        
        _lineChartView.animate(xAxisDuration: 1, easingOption: .linear)
        _lineChartView.animate(yAxisDuration: 1, easingOption: .linear)
        
        _lineChartView.legend.horizontalAlignment = .center
        
        _lineChartView.rightAxis.enabled = false
        //_lineChartView.setExtraOffsets(left: 10, top: 0, right: 10, bottom: 10)
        
        let xAxis = _lineChartView.xAxis
        xAxis.labelPosition = .bottom
        xAxis.drawGridLinesEnabled = false
        xAxis.setLabelCount(3, force: true)
        xAxis.avoidFirstLastClippingEnabled = true
        
        _lineChartView.leftAxis.drawGridLinesEnabled = false
    }
    
}
