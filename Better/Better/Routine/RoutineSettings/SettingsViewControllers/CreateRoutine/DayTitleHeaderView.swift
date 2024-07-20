//
//  DayTitleCell.swift
//  Better
//
//  Created by John Jakobsen on 6/20/24.
//

import Foundation
import UIKit

protocol DayTitleHeaderViewDelegate {
    func didEditTitleTextField(_ text: String, dayIndex: Int)
    func didTapOpen(dayIndex: Int, noChange: Bool)
    func dayStatus(dayRow: Int) -> Bool
    func didTapRemove(dayIndex: Int)
}

class DayTitleHeaderView: UITableViewHeaderFooterView, UnderlinedTextFieldDelegate, UIGestureRecognizerDelegate {
    
    let dayTitleTextField: UnderlinedTextField
    let openStatusImageView: UIImageView
    var delegate: DayTitleHeaderViewDelegate? = nil
    let baseContainerView: UIView
    var redBackgroundDeleteView: UIView
    var containerView: UIView
    let removeButton: UIButton
    var dayIndex: Int = 0
    var originalPosition: CGPoint = CGPoint()
    var currentStartPanPosition: CGPoint = CGPoint()
    var setOriginalPosition: Bool = false
    
    private let timerDuration = 0.025
    private let decelerationSmoothness = 0.9
    private let velocityToAngleConversion = 0.0025
    private var currentVelocity: Double = 0.0
    
    static let reuseIdentifier: String = "DayTitleHeaderView"

    override init(reuseIdentifier: String?) {
                
        dayTitleTextField = UnderlinedTextField(placeholder: "Day Title")
        dayTitleTextField.translatesAutoresizingMaskIntoConstraints = false
        dayTitleTextField.font = Fonts.Montserrat_Small_Medium
        dayTitleTextField.textColor = Colors.blackTextColor
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: Colors.greyTextColor // Set your desired placeholder color here
        ]
        let attributedPlaceholder = NSAttributedString(string: "Day Title", attributes: attributes)
        dayTitleTextField.attributedPlaceholder = attributedPlaceholder
        
        openStatusImageView = UIImageView(image: UIImage(systemName: "chevron.down")?.withTintColor(Colors.blackTextColor, renderingMode: .alwaysOriginal))
        openStatusImageView.translatesAutoresizingMaskIntoConstraints = false
        openStatusImageView.isUserInteractionEnabled = true
        
        redBackgroundDeleteView = UIView()
        redBackgroundDeleteView.translatesAutoresizingMaskIntoConstraints = false
        redBackgroundDeleteView.backgroundColor = .systemRed
        
        removeButton = UIButton()
        removeButton.translatesAutoresizingMaskIntoConstraints = false
        removeButton.setTitle("Remove", for: .normal)
        removeButton.titleLabel?.font = Fonts.Montserrat_Small.bolder()
        removeButton.setTitleColor(.white, for: .normal)
        
        redBackgroundDeleteView.addSubview(removeButton)
        
        containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .white
        containerView.addSubview(dayTitleTextField)
        containerView.addSubview(openStatusImageView)
        
        baseContainerView = UIView()
        baseContainerView.translatesAutoresizingMaskIntoConstraints = false
        baseContainerView.addSubview(containerView)
        baseContainerView.insertSubview(redBackgroundDeleteView, belowSubview: containerView)
        
        baseContainerView.layer.zPosition = 0
        redBackgroundDeleteView.layer.zPosition = 1
        containerView.layer.zPosition = 2
        
        super.init(reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(baseContainerView)
        
        self.autolayoutSubviews()
                
        dayTitleTextField.underlinedDelegate = self
        
        self.containerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.didTapOpen)))
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.panPiece(_:)))
        panGesture.delegate = self
        self.containerView.addGestureRecognizer(panGesture)
        
        removeButton.addTarget(self, action: #selector(self.didTapRemove), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func autolayoutSubviews() {
        NSLayoutConstraint.activate([
            baseContainerView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
            baseContainerView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor),
            baseContainerView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            baseContainerView.topAnchor.constraint(equalTo: self.contentView.topAnchor),            
        ])
        
        NSLayoutConstraint.activate([
            containerView.leftAnchor.constraint(lessThanOrEqualTo: baseContainerView.leftAnchor),
            containerView.rightAnchor.constraint(equalTo: baseContainerView.rightAnchor),
            containerView.bottomAnchor.constraint(equalTo: baseContainerView.bottomAnchor),
            containerView.topAnchor.constraint(equalTo: baseContainerView.topAnchor),
            
            dayTitleTextField.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 10),
            dayTitleTextField.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
            dayTitleTextField.bottomAnchor.constraint(lessThanOrEqualTo: containerView.bottomAnchor, constant: -10),
            dayTitleTextField.widthAnchor.constraint(greaterThanOrEqualToConstant: 200),
            dayTitleTextField.widthAnchor.constraint(lessThanOrEqualToConstant: 250),
            
            openStatusImageView.leftAnchor.constraint(greaterThanOrEqualTo: dayTitleTextField.rightAnchor, constant: 40),
            openStatusImageView.centerYAnchor.constraint(equalTo: dayTitleTextField.centerYAnchor),
            openStatusImageView.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -10),
            openStatusImageView.topAnchor.constraint(greaterThanOrEqualTo: containerView.topAnchor, constant: 10),
            openStatusImageView.heightAnchor.constraint(equalToConstant: 20),
            openStatusImageView.widthAnchor.constraint(equalToConstant: 20),
            openStatusImageView.bottomAnchor.constraint(lessThanOrEqualTo: containerView.bottomAnchor, constant: -10),
        ])
        
        NSLayoutConstraint.activate([
            redBackgroundDeleteView.leftAnchor.constraint(equalTo: baseContainerView.leftAnchor),
            redBackgroundDeleteView.rightAnchor.constraint(equalTo: baseContainerView.rightAnchor),
            redBackgroundDeleteView.bottomAnchor.constraint(equalTo: baseContainerView.bottomAnchor),
            redBackgroundDeleteView.topAnchor.constraint(equalTo: baseContainerView.topAnchor),
            
            removeButton.leftAnchor.constraint(greaterThanOrEqualTo: redBackgroundDeleteView.leftAnchor),
            removeButton.rightAnchor.constraint(equalTo: redBackgroundDeleteView.rightAnchor, constant: -5),
            removeButton.topAnchor.constraint(equalTo: redBackgroundDeleteView.topAnchor, constant: 5),
            removeButton.bottomAnchor.constraint(equalTo: redBackgroundDeleteView.bottomAnchor, constant:  -5),
        ])
    }
    
    override func layoutSubviews() {
        let time = 0.4//abs(self.containerView.center.x - self.originalPosition.x)/500
        UIView.animate(withDuration: time) {
            super.layoutSubviews()
        }
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
            // Allow pan gesture to recognize simultaneously with others
            return true
        }
    
    public func setTextField(text: String) {
        self.dayTitleTextField.text = text
    }
    
    public func setDayIndex(dayIndex: Int) {
        self.dayIndex = dayIndex
    }
    
    func setOpenStatus(noChange: Bool) {
        self.delegate?.didTapOpen(dayIndex: self.dayIndex, noChange: noChange)
        guard let openStatus = self.delegate?.dayStatus(dayRow: self.dayIndex) else {
            return
        }
        UIView.animate(withDuration: 0.3) {
            if openStatus {
                self.openStatusImageView.transform = CGAffineTransformMakeRotation(0.0);
            } else {
                self.openStatusImageView.transform = CGAffineTransformMakeRotation(-0.5 * Double.pi);
            }
        }
    }
    
    @objc func didTapOpen() {
        self.setOpenStatus(noChange: false)
    }
    
    @objc func panPiece(_ gestureRecognizer : UIPanGestureRecognizer) {
        guard let piece = gestureRecognizer.view else {return}

        // Get the changes in the X and Y directions relative to
        // the superview's coordinate space.
        let translation = gestureRecognizer.translation(in: piece.superview)

          // Update the position for the .began, .changed, and .ended states
        switch (gestureRecognizer.state) {
        case .began:
            self.currentStartPanPosition = piece.center
            if !self.setOriginalPosition {
                self.originalPosition = piece.center
                self.setOriginalPosition = true
            }
            break
        case .changed:
            let translateXVal = translation.x
            let newPositionX = self.currentStartPanPosition.x + translateXVal
            if newPositionX > self.originalPosition.x {
                piece.center = self.originalPosition
                return
            }
            
            piece.center = CGPoint(x: self.currentStartPanPosition.x + translateXVal, y: self.originalPosition.y)
            break
        case .ended:
            print("ended")
            let dragVelocity = gestureRecognizer.velocity(in: self)
            let time = 0.5
            if dragVelocity.x >= 25 {
                UIView.animate(withDuration: time*2) {
                    piece.center = CGPoint(x: self.originalPosition.x, y: self.originalPosition.y)
                }
            }
            let newPosition = self.currentStartPanPosition.x
            let draggedDistance = self.originalPosition.x - piece.center.x
            if draggedDistance >= 25 {
                UIView.animate(withDuration: time) {
                    piece.center = CGPoint(x: self.originalPosition.x - 74, y: self.originalPosition.y)
                }
            } else if draggedDistance >= 0 {
                UIView.animate(withDuration: time/2) {
                    piece.center = CGPoint(x: self.originalPosition.x, y: self.originalPosition.y)
                }
            }
            break
        case .cancelled:
            print("Cancelled")
            let time = abs(piece.center.x - self.originalPosition.x)/200
            UIView.animate(withDuration: time) {
                piece.center = CGPoint(x: self.originalPosition.x, y: self.originalPosition.y)
            }
            break
        default:
            return
        }
    }
    
    @objc func didTapRemove() {
        self.delegate?.didTapRemove(dayIndex: self.dayIndex)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let textFieldText = textField.text {
            self.delegate?.didEditTitleTextField(textFieldText, dayIndex: self.dayIndex)
        }
    }
}
