//
//  HomeView.swift
//  Better
//
//  Created by John Jakobsen on 4/29/24.
//

import Foundation
import UIKit

struct HomeViewModel {
    let streak: Int
    let weight: Float
    let lastTraining: Date
    let routineName: String
    let nextDayName: String
}

protocol HomeViewDelegate {
    func didTapLastTraining()
    func didTapNextTraining()
}

class HomeView: UIView {
    let _greetingLabel: UILabel
    let _streakNumberLabel: UILabel
    let _fireImageView: UIImageView
    let _weightLabel: UILabel
    let _lastTrainingLabel: UILabel
    let _lastTrainingDayButton: UIButton
    let _nextTrainingLabel: UILabel
    let _nextDayButton: UIButton
    let _streakContainerView: UIView
    var delegate: HomeViewDelegate? = nil
    
    init(viewModel: HomeViewModel) {
        _greetingLabel = UILabel()
        _greetingLabel.translatesAutoresizingMaskIntoConstraints = false
        _greetingLabel.font = Fonts.Montserrat_Medium_Large.bold()
        _greetingLabel.textColor = Colors.blackTextColor
        _greetingLabel.text = Date.now.greeting()
        
        _streakNumberLabel = UILabel()
        _streakNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        _streakNumberLabel.font = Fonts.Montserrat_Larger.bolder()
        _streakNumberLabel.textColor = Colors.blackTextColor
        _streakNumberLabel.text = "\(viewModel.streak)"
        
        _fireImageView = UIImageView()
        _fireImageView.translatesAutoresizingMaskIntoConstraints = false
        _fireImageView.image = UIImage(named: "fire")
        
        _weightLabel = UILabel()
        _weightLabel.translatesAutoresizingMaskIntoConstraints = false
        _weightLabel.font = Fonts.Montserrat_Larger.bold()
        _weightLabel.textColor = Colors.blackTextColor
        _weightLabel.text = "\(viewModel.weight) lbs"
        
        _lastTrainingLabel = UILabel()
        _lastTrainingLabel.translatesAutoresizingMaskIntoConstraints = false
        _lastTrainingLabel.font = Fonts.Montserrat_Medium.bold()
        _lastTrainingLabel.textColor = Colors.blackTextColor
        _lastTrainingLabel.text = "Last Training"
        
        _lastTrainingDayButton = UIButton()
        _lastTrainingDayButton.translatesAutoresizingMaskIntoConstraints = false
        _lastTrainingDayButton.titleLabel?.font = Fonts.Montserrat_Medium.bold()
        _lastTrainingDayButton.setTitleColor(Colors.linkColor, for: .normal)
        _lastTrainingDayButton.setTitle("\(viewModel.lastTraining.relativeTime())", for: .normal)
        
        _nextTrainingLabel = UILabel()
        _nextTrainingLabel.translatesAutoresizingMaskIntoConstraints = false
        _nextTrainingLabel.font = Fonts.Montserrat_Medium.bold()
        _nextTrainingLabel.textColor = Colors.blackTextColor
        _nextTrainingLabel.text = "Next Training"
        
        _nextDayButton = UIButton()
        _nextDayButton.translatesAutoresizingMaskIntoConstraints = false
        _nextDayButton.titleLabel?.font = Fonts.Montserrat_Medium.bold()
        _nextDayButton.setTitleColor(Colors.linkColor, for: .normal)
        _nextDayButton.setTitle("\(viewModel.routineName)\n\(viewModel.nextDayName)", for: .normal)
        _nextDayButton.titleLabel?.numberOfLines = 2
        _nextDayButton.titleLabel?.textAlignment = .center
        
        _streakContainerView = UIView()
        _streakContainerView.translatesAutoresizingMaskIntoConstraints = false
        _streakContainerView.addSubview(_streakNumberLabel)
        _streakContainerView.addSubview(_fireImageView)
        
        super.init(frame: CGRect())
        self.backgroundColor = .white
        self.addSubview(_greetingLabel)
//        self.addSubview(_streakNumberLabel)
//        self.addSubview(_fireImageView)
        self.addSubview(_streakContainerView)
        self.addSubview(_weightLabel)
        self.addSubview(_lastTrainingLabel)
        self.addSubview(_lastTrainingDayButton)
        self.addSubview(_nextTrainingLabel)
        self.addSubview(_nextDayButton)
        
        self._nextDayButton.addTarget(self, action: #selector(self.didTapNextTraining), for: .touchUpInside)
        self._lastTrainingDayButton.addTarget(self, action: #selector(self.didTapLastTraining), for: .touchUpInside)
        autolayoutSubviews()
    }
    
    func autolayoutSubviews() {
        let streakContainerConstraints = [
            _streakNumberLabel.topAnchor.constraint(greaterThanOrEqualTo: _streakContainerView.topAnchor),
            _streakNumberLabel.leftAnchor.constraint(equalTo: _streakContainerView.leftAnchor),
            _streakNumberLabel.rightAnchor.constraint(equalTo: self._fireImageView.leftAnchor, constant: -12),
            _streakNumberLabel.bottomAnchor.constraint(lessThanOrEqualTo: _streakContainerView.bottomAnchor),
            _streakNumberLabel.bottomAnchor.constraint(equalTo: _fireImageView.bottomAnchor, constant: -10),
            
            _fireImageView.topAnchor.constraint(equalTo: _streakContainerView.topAnchor),
            _fireImageView.rightAnchor.constraint(equalTo: _streakContainerView.rightAnchor),
            _fireImageView.bottomAnchor.constraint(equalTo: _streakContainerView.bottomAnchor),
            _fireImageView.bottomAnchor.constraint(equalTo: _streakContainerView.bottomAnchor),
            //_fireImageView.centerYAnchor.constraint(equalTo: _streakNumberLabel.centerYAnchor),
            _fireImageView.widthAnchor.constraint(equalToConstant: 100),
            _fireImageView.heightAnchor.constraint(equalToConstant: 100),
        ]
        NSLayoutConstraint.activate(streakContainerConstraints)
        
        let constraints = [
            // _greetingLabel constraints
            _greetingLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            _greetingLabel.leftAnchor.constraint(greaterThanOrEqualTo: self.leftAnchor),
            _greetingLabel.rightAnchor.constraint(lessThanOrEqualTo: self.rightAnchor),
            _greetingLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 40),
            
            _streakContainerView.leftAnchor.constraint(greaterThanOrEqualTo: self.leftAnchor),
            _streakContainerView.rightAnchor.constraint(lessThanOrEqualTo: self.rightAnchor),
            _streakContainerView.topAnchor.constraint(equalTo: self._greetingLabel.bottomAnchor, constant: 60),
            _streakContainerView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            // _weightLabel constraints
            _weightLabel.topAnchor.constraint(equalTo: _streakContainerView.bottomAnchor, constant: 30),
            _weightLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            _weightLabel.leftAnchor.constraint(greaterThanOrEqualTo: self.leftAnchor),
            _weightLabel.rightAnchor.constraint(lessThanOrEqualTo: self.rightAnchor),
            
            // _lastTrainingLabel constraints
            _lastTrainingLabel.topAnchor.constraint(greaterThanOrEqualTo: _weightLabel.bottomAnchor, constant: 10),
            _lastTrainingLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            _lastTrainingLabel.leftAnchor.constraint(greaterThanOrEqualTo: self.leftAnchor),
            _lastTrainingLabel.rightAnchor.constraint(lessThanOrEqualTo: self.rightAnchor),
            
            // _lastTrainingDayButton constraints
            _lastTrainingDayButton.topAnchor.constraint(equalTo: _lastTrainingLabel.bottomAnchor),
            _lastTrainingDayButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            _lastTrainingDayButton.leftAnchor.constraint(greaterThanOrEqualTo: self.leftAnchor),
            _lastTrainingDayButton.rightAnchor.constraint(lessThanOrEqualTo: self.rightAnchor),
            
            // _nextTrainingLabel constraints
            _nextTrainingLabel.topAnchor.constraint(equalTo: _lastTrainingDayButton.bottomAnchor, constant: 20),
            _nextTrainingLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            _nextTrainingLabel.leftAnchor.constraint(greaterThanOrEqualTo: self.leftAnchor),
            _nextTrainingLabel.rightAnchor.constraint(lessThanOrEqualTo: self.rightAnchor),
            
            // _nextDayButton constraints
            _nextDayButton.topAnchor.constraint(equalTo: _nextTrainingLabel.bottomAnchor),
            _nextDayButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            _nextDayButton.leftAnchor.constraint(greaterThanOrEqualTo: self.leftAnchor),
            _nextDayButton.rightAnchor.constraint(lessThanOrEqualTo: self.rightAnchor),
            _nextDayButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -80)
        ]

        // Activate the constraints
        NSLayoutConstraint.activate(constraints)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func didTapLastTraining() {
        delegate?.didTapLastTraining()
    }
    
    @objc func didTapNextTraining() {
        delegate?.didTapNextTraining()
    }
}
