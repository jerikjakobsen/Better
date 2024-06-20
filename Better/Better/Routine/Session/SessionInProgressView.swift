import Foundation
import UIKit

protocol SessionInProgressViewDelegate {
    func numberOfRows(_ tableView: UITableView) -> Int
    func setForRowAt(_ tableView: UITableView, row: Int) -> SetSession
    func didStartSetSession()
    func didEndSetSession(reps: Int, weight: Float)
    func didEndExerciseSession()
    func showRepsWeightEmptyAlert()
    func showNotesPopUp()
}

struct SessionInProgressViewModel {
    let exerciseTitleContent: String
    let startedAtContent: String
}


class SessionInProgressView: UIView, UITableViewDelegate, UITableViewDataSource {
    let _exerciseTitleLabel: UILabel
    let _startedAtLabel: UILabel
    let _timerLabel: UILabel
    let _noteButton: UIButton
    let _setNumberLabel: UILabel
    let _weightNumberTextField: UnderlinedTextField
    let _repsNumberTextField: UnderlinedTextField
    let _startEndButton: UIButton
    let _startEndButtonTopAnchor: NSLayoutConstraint
    let _previousSetsTableView: UITableView
    var delegate: SessionInProgressViewDelegate? = nil
    let viewModel: SessionInProgressViewModel
    var setInSession: Bool = false
    
    init(viewModel: SessionInProgressViewModel) {
        
        self.viewModel = viewModel
        
        _exerciseTitleLabel = UILabel()
        _exerciseTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        _exerciseTitleLabel.font = Fonts.Montserrat_Medium_Large
        _exerciseTitleLabel.textColor = Colors.blackTextColor
        _exerciseTitleLabel.text = viewModel.exerciseTitleContent
        
        _startedAtLabel = UILabel()
        _startedAtLabel.translatesAutoresizingMaskIntoConstraints = false
        _startedAtLabel.font = Fonts.Montserrat_Small
        _startedAtLabel.textColor = Colors.blackTextColor
        _startedAtLabel.text = "Started at \(viewModel.startedAtContent)"
        
        _timerLabel = UILabel()
        _timerLabel.translatesAutoresizingMaskIntoConstraints = false
        _timerLabel.font = Fonts.Montserrat_Large.bold()
        _timerLabel.textColor = Colors.blackTextColor
        _timerLabel.text = "00 : 00 : 00"
        
        _setNumberLabel = UILabel()
        _setNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        _setNumberLabel.font = Fonts.Montserrat_Medium_Large
        _setNumberLabel.textColor = Colors.blackTextColor
        _setNumberLabel.text = "Set # 1"
        
        _noteButton = UIButton()
        _noteButton.translatesAutoresizingMaskIntoConstraints = false
        _noteButton.titleLabel?.font = Fonts.Montserrat_Small
        _noteButton.setTitleColor(Colors.linkColor, for: .normal)
        _noteButton.setTitle("Add Note", for: .normal)
        _noteButton.titleLabel?.numberOfLines = 2
        _noteButton.titleLabel?.textAlignment = .center
        
        _weightNumberTextField = UnderlinedTextField(placeholder: "Weight")
        _weightNumberTextField.translatesAutoresizingMaskIntoConstraints = false
        _weightNumberTextField.font = Fonts.Montserrat_Small
        _weightNumberTextField.textColor = Colors.blackTextColor
        _weightNumberTextField.textAlignment = .center
        _weightNumberTextField.isUserInteractionEnabled = false
        _weightNumberTextField.keyboardType = .decimalPad
        _weightNumberTextField.isUserInteractionEnabled = false
        _weightNumberTextField.alpha = 0
        
        _repsNumberTextField = UnderlinedTextField(placeholder: "Reps")
        _repsNumberTextField.translatesAutoresizingMaskIntoConstraints = false
        _repsNumberTextField.font = Fonts.Montserrat_Small
        _repsNumberTextField.textColor = Colors.blackTextColor
        _repsNumberTextField.textAlignment = .center
        _repsNumberTextField.isUserInteractionEnabled = false
        _repsNumberTextField.keyboardType = .numberPad
        _repsNumberTextField.isUserInteractionEnabled = false
        _repsNumberTextField.alpha = 0
        
        _startEndButton = UIButton()
        _startEndButton.translatesAutoresizingMaskIntoConstraints = false
        _startEndButton.setImage(UIImage(named: "startButtonIcon"), for: .normal)
        var configuration = UIButton.Configuration.plain()
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        _startEndButton.configuration = configuration
        _startEndButton.backgroundColor = .white
        
//        _startButton = UIButton()
//        _startButton.translatesAutoresizingMaskIntoConstraints = false
//        _startButton.setImage(UIImage(named: "startButtonIcon"), for: .normal)
//        _startButton.configuration = configuration
//        _startButton.backgroundColor = .white
        
        _previousSetsTableView = UITableView()
        _previousSetsTableView.translatesAutoresizingMaskIntoConstraints = false
        _previousSetsTableView.separatorStyle = .none
        _previousSetsTableView.rowHeight = UITableView.automaticDimension
        _previousSetsTableView.estimatedRowHeight = 200
        _previousSetsTableView.sectionHeaderTopPadding = 0
        _previousSetsTableView.register(SessionInProgressSetRecordCell.self, forCellReuseIdentifier: "SessionInProgressSetRecordCell")
        
        _startEndButtonTopAnchor = _startEndButton.topAnchor.constraint(equalTo: _noteButton.bottomAnchor, constant: 30)
//        _startEndButtonBottomAnchor = _startEndButton.bottomAnchor.constraint(equalTo: _previousSetsTableView.topAnchor, constant: -10)
//        _startEndButtonBottomAnchor.isActive = true
        
        super.init(frame: CGRect())
        
        self.addSubview(_exerciseTitleLabel)
        self.addSubview(_startedAtLabel)
        self.addSubview(_timerLabel)
        self.addSubview(_noteButton)
        self.addSubview(_setNumberLabel)
        self.addSubview(_weightNumberTextField)
        self.addSubview(_repsNumberTextField)
        self.addSubview(_startEndButton)
        self.addSubview(_previousSetsTableView)

        _startEndButton.addTarget(self, action: #selector(self.didTapStartEndButton), for: .touchUpInside)
        _noteButton.addTarget(self, action: #selector(self.didTapNotesButton), for: .touchUpInside)
        _previousSetsTableView.dataSource = self
        _previousSetsTableView.delegate = self
        
        _startEndButtonTopAnchor.isActive = true
        self.autolayoutSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return delegate?.numberOfRows(_previousSetsTableView) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SessionInProgressSetRecordCell = (_previousSetsTableView.dequeueReusableCell(withIdentifier: "SessionInProgressSetRecordCell") as? SessionInProgressSetRecordCell) ?? SessionInProgressSetRecordCell(style: .default, reuseIdentifier: "SessionInProgressSetRecordCell")
        if let record = delegate?.setForRowAt(_previousSetsTableView, row: indexPath.row) {
            cell.setCellInfo(setSession: record)
        }
        
        return cell
    }
    
    func autolayoutSubviews() {
        let constraints = [
            _exerciseTitleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            _exerciseTitleLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
            _exerciseTitleLabel.leftAnchor.constraint(greaterThanOrEqualTo: self.leftAnchor, constant: 10),
            _exerciseTitleLabel.rightAnchor.constraint(lessThanOrEqualTo: self.rightAnchor, constant: -10),
            
            _startedAtLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            _startedAtLabel.topAnchor.constraint(equalTo: _exerciseTitleLabel.bottomAnchor, constant: 10),
            _startedAtLabel.leftAnchor.constraint(greaterThanOrEqualTo: self.leftAnchor, constant: 10),
            _startedAtLabel.rightAnchor.constraint(lessThanOrEqualTo: self.rightAnchor, constant: -10),
            
            _timerLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            _timerLabel.topAnchor.constraint(equalTo: _startedAtLabel.bottomAnchor, constant: 15),
            _startedAtLabel.leftAnchor.constraint(greaterThanOrEqualTo: self.leftAnchor, constant: 10),
            _startedAtLabel.rightAnchor.constraint(lessThanOrEqualTo: self.rightAnchor, constant: -10),

            _setNumberLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            _setNumberLabel.topAnchor.constraint(equalTo: _timerLabel.bottomAnchor, constant: 15),
            _setNumberLabel.leftAnchor.constraint(greaterThanOrEqualTo: self.leftAnchor, constant: 10),
            _setNumberLabel.rightAnchor.constraint(lessThanOrEqualTo: self.rightAnchor, constant: -10),
            
            _noteButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            _noteButton.topAnchor.constraint(equalTo: _setNumberLabel.bottomAnchor, constant: 5),
            _noteButton.leftAnchor.constraint(greaterThanOrEqualTo: self.leftAnchor, constant: 10),
            _noteButton.rightAnchor.constraint(lessThanOrEqualTo: self.rightAnchor, constant: -10),

            _weightNumberTextField.topAnchor.constraint(equalTo: _noteButton.bottomAnchor, constant: 30),
            _weightNumberTextField.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 30),
            _weightNumberTextField.rightAnchor.constraint(equalTo: self.centerXAnchor, constant: -30),
            
            _repsNumberTextField.topAnchor.constraint(equalTo: _noteButton.bottomAnchor, constant: 30),
            _repsNumberTextField.leftAnchor.constraint(equalTo: self.centerXAnchor, constant: 30),
            _repsNumberTextField.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -30),
            
            _startEndButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            _previousSetsTableView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.25),
            _previousSetsTableView.leftAnchor.constraint(equalTo: self.leftAnchor),
            _previousSetsTableView.rightAnchor.constraint(equalTo: self.rightAnchor),
            _previousSetsTableView.topAnchor.constraint(greaterThanOrEqualTo: _startEndButton.bottomAnchor, constant: 10),
            _previousSetsTableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ]
        
        NSLayoutConstraint.activate(constraints)
        
    }
    
    @objc func didTapStartEndButton() {
        if (setInSession) {
            if let reps = Int(self._repsNumberTextField.text ?? ""), let weight = Float(self._weightNumberTextField.text ?? "") {
                setInSession = false
                _startEndButton.setImage(UIImage(named: "startButtonIcon"), for: .normal)
                self.delegate?.didEndSetSession(reps: reps, weight: weight)
                self._weightNumberTextField.isUserInteractionEnabled = false
                self._repsNumberTextField.isUserInteractionEnabled = false
                self._weightNumberTextField.text = ""
                self._repsNumberTextField.text = ""
                UIView.animate(withDuration: 1) {
                    self._weightNumberTextField.alpha = 0
                    self._repsNumberTextField.alpha = 0
                    self._startEndButtonTopAnchor.constant = 30
                    self.layoutIfNeeded()
                }
            } else {
                self.delegate?.showRepsWeightEmptyAlert()
            }
            
        } else {
            setInSession = true
            _startEndButton.setImage(UIImage(named: "endButtonIcon"), for: .normal)
            self.delegate?.didStartSetSession()
            self._weightNumberTextField.isUserInteractionEnabled = true
            self._repsNumberTextField.isUserInteractionEnabled = true

            UIView.animate(withDuration: 1) {
                self._weightNumberTextField.alpha = 1.0
                self._repsNumberTextField.alpha = 1.0
                self._startEndButtonTopAnchor.constant = 60
                self.layoutIfNeeded()
            }
        }
    }
    
    func reloadSessions() {
        self._previousSetsTableView.reloadData()
    }
    
    func setSetNumber(setNumber: Int, isSet: Bool ) {
        if (isSet) {
            self._setNumberLabel.text = "Set # \(setNumber)"
        } else {
            self._setNumberLabel.text = "Break # \(setNumber)"
        }
    }
    
    @objc func didTapNotesButton() {
        self.delegate?.showNotesPopUp()
    }
}





