//
//  ViewController.swift
//  Better
//
//  Created by John Jakobsen on 2/8/23.
//

import UIKit
import Charts

class WeightViewController: UIViewController, EditableWeightCellDelegate, WeightViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let r = _records else {return 0}
        return r.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeightRecordCell") as? WeightRecordCell
        cell?.setCellInfo(record: _records![indexPath.row])
        return cell!
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return self._editableWeightSectionView
    }
    
    func didAddWeightRecord(weight: Float) {
        let weightR = WeightRecord(weight: weight, date: Date.now)
        Task {
            await weightR.saveToFirebase { err in
                if err != nil {
                    let alert = UIAlertController(title: "Error", message: "Failed to save weight", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                    }))
                    self.present(alert, animated: true, completion: nil)
                } else {
                    self._records?.insert(weightR, at: 0)
                    self._weightView._weightsTableView.reloadData()
                    self._editableWeightSectionView.reloadChart()
                }
            }
        }

    }
    
    func getLineChartData() -> LineChartData? {
        guard let r = _records else {return nil}
        let dataEntries: [ChartDataEntry]  = r.reversed().enumerated().map { (index, weightRecord) in
            return ChartDataEntry(x: Double(index), y: Double(weightRecord.weight))
        }
        
        let dataSet = LineChartDataSet(entries: dataEntries, label: "Weight")
        dataSet.drawValuesEnabled = false
        return LineChartData(dataSet: dataSet)

    }
    
    func getLineChartXAxisLabels() -> [String]? {
        guard let r = _records else {return nil}
        return r.reversed().map {$0.date.formatted(date: .abbreviated, time: .omitted)}
    }
    
    var _records: [WeightRecord]?
    let _editableWeightSectionView: EditableWeightSectionView!
    let _weightView: WeightView!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        _records = []
        _weightView = WeightView()
        _editableWeightSectionView = EditableWeightSectionView(reuseIdentifier: "EditableWeightSectionView")
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        _editableWeightSectionView.delegate = self
        _weightView.delegate = self
        self.tabBarItem = .init(title: "Weight", image: .init(systemName: "scalemass"), selectedImage: .init(systemName: "scalemass.fill"))
        view.addSubview(_weightView)
        let weightViewConstraints = [
            _weightView.leftAnchor.constraint(equalTo: view.leftAnchor),
            _weightView.rightAnchor.constraint(equalTo: view.rightAnchor),
            _weightView.topAnchor.constraint(equalTo: view.topAnchor),
            _weightView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        NSLayoutConstraint.activate(weightViewConstraints)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        view.addGestureRecognizer(tap)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        Task {
            await WeightRecord.getAllWeightRecords { recordArr, err in
                if err != nil {
                    let alert = UIAlertController(title: "Error", message: "Failed to load weight records", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                    }))
                    self.present(alert, animated: true, completion: nil)
                } else {
                    self._records = recordArr
                    self._weightView._weightsTableView.reloadData()
                    self._editableWeightSectionView.reloadChart()
                }
            }
        }
    }

    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        self.view.endEditing(true)
    }

}

