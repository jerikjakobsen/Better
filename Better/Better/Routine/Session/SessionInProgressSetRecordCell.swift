import UIKit
import Foundation

class SessionInProgressSetRecordCell: UITableViewCell {
    let weightLabel: UILabel
    let repsLabel: UILabel
    let timeLabel: UILabel
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        weightLabel = UILabel()
        weightLabel.translatesAutoresizingMaskIntoConstraints = false
        weightLabel.font = Fonts.Montserrat_Small
        weightLabel.textColor = Colors.blackTextColor
        
        repsLabel = UILabel()
        repsLabel.translatesAutoresizingMaskIntoConstraints = false
        repsLabel.font = Fonts.Montserrat_Small
        repsLabel.textColor = Colors.blackTextColor
        
        timeLabel = UILabel()
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.font = Fonts.Montserrat_Small
        timeLabel.textColor = Colors.blackTextColor
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(weightLabel)
        contentView.addSubview(repsLabel)
        contentView.addSubview(timeLabel)
        
        self.autolayoutSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func autolayoutSubviews() {
        let constraints = [
            weightLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            weightLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            weightLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            
            repsLabel.leftAnchor.constraint(greaterThanOrEqualTo: weightLabel.rightAnchor, constant: 5),
            repsLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            repsLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            repsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            repsLabel.rightAnchor.constraint(lessThanOrEqualTo: timeLabel.leftAnchor, constant: -5),
            
            timeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            timeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            timeLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func setCellInfo(setSession: SetSession) {
        weightLabel.text = String(format: "%.1f lbs", setSession.weight)
        repsLabel.text = "\(setSession.reps) Reps"
        timeLabel.text = String(format: "%.1f mins", setSession.duration.doubleMinutes)
    }
}
