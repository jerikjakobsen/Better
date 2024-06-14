
import UIKit
import Foundation

protocol SessionInProgressViewControllerDelegate {
    func didFinishExerciseSession(exerciseSession: ExerciseSession)
}

class SessionInProgressViewController: UIViewController, SessionInProgressViewDelegate, SessionNotesPopUpViewControllerDelegate {
    
    let _sessionInProgressSetView: SessionInProgressView
    var setSessions: [SetSession] = []
    let currentExerciseSession: ExerciseSession
    var sessionStartTime: Date? = nil
    var timer: Timer? = nil
    var notes: String = ""
    var delegate: SessionInProgressViewControllerDelegate? = nil
    
    init(exercise: Exercise, day: Day) {
        
        self.currentExerciseSession = ExerciseSession.startExerciseSession(exercise: exercise)
        self._sessionInProgressSetView = SessionInProgressView(viewModel: .init(exerciseTitleContent: exercise.name, startedAtContent: currentExerciseSession.startTime.dateStringFormatted(format: "h:mm")))
        super.init(nibName: nil, bundle: nil)
        self.view = self._sessionInProgressSetView
        self._sessionInProgressSetView.backgroundColor = .white
        self._sessionInProgressSetView.delegate = self
        
        let titleView = UILabel()
        titleView.font = Fonts.Montserrat_Medium.bolder()
        titleView.textColor = Colors.blackTextColor
        titleView.text = day.name
        self.navigationItem.titleView = titleView
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap))
        self._sessionInProgressSetView.addGestureRecognizer(tap)
        
        self.timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
        
        self.navigationItem.titleView = titleView
        self.navigationItem.setLeftBarButton(nil, animated: false)
        let doneButton = UIButton()
        doneButton.setTitle("Done", for: .normal)
        doneButton.setTitleColor(Colors.linkColor, for: .normal)
        doneButton.titleLabel?.font = Fonts.Montserrat_Small_Medium
        
        let quitButton = UIButton()
        quitButton.setTitle("Quit", for: .normal)
        quitButton.setTitleColor(Colors.redColor, for: .normal)
        quitButton.titleLabel?.font = Fonts.Montserrat_Small_Medium
        
        let doneButtonItem = UIBarButtonItem(customView: doneButton)
        self.navigationItem.setRightBarButton(doneButtonItem, animated: true)
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        let quitButtonItem = UIBarButtonItem(customView: quitButton)
        self.navigationItem.setLeftBarButton(quitButtonItem, animated: true)
        
        doneButton.addTarget(self, action: #selector(self.didEndExerciseSession), for: .touchUpInside)
        quitButton.addTarget(self, action: #selector(self.didQuitSession), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func numberOfRows(_ tableView: UITableView) -> Int {
        return setSessions.count
    }
    
    func setForRowAt(_ tableView: UITableView, row: Int) -> SetSession {
        return setSessions[row]
    }
    
    func didStartSetSession() {
        sessionStartTime = Date.now
        
        self._sessionInProgressSetView.setSetNumber(setNumber: self.setSessions.count+1, isSet: true)
    }
    
    func didEndSetSession(reps: Int, weight: Float) {
        if let notNilCurrentSetSessionStartTime = sessionStartTime {
            self.setSessions.insert(SetSession(startTime: notNilCurrentSetSessionStartTime, endTime: Date.now, weight: weight, reps: reps), at: 0)
            self._sessionInProgressSetView.reloadSessions()
            self._sessionInProgressSetView.setSetNumber(setNumber: self.setSessions.count, isSet: false)
        }
        self.sessionStartTime = Date.now
        self._sessionInProgressSetView._timerLabel.text = String(format: "00 : 00 : 00")
    }
    
    @objc func didEndExerciseSession() {
        currentExerciseSession.notes = notes
        currentExerciseSession.setSessions = self.setSessions
        currentExerciseSession.endExerciseSession()
        self.sessionStartTime = nil
        self._sessionInProgressSetView._timerLabel.text = String(format: "00 : 00 : 00")
        self.delegate?.didFinishExerciseSession(exerciseSession: currentExerciseSession)
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func didQuitSession() {

        let alert = BetterAlertController(title: "Are you sure you want to quit?", defaultFont: Fonts.Montserrat_Small_Medium.bold(), defaultColor: Colors.blackTextColor)
        
        alert.addAction(title: "Quit", color: Colors.redColor, font: Fonts.Montserrat_Small_Medium) { _ in
            self.navigationController?.popViewController(animated: true)
        }
        
        alert.addAction(title: "Back", color: Colors.blackTextColor, font: Fonts.Montserrat_Small_Medium)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func showRepsWeightEmptyAlert() {

        let alert = BetterAlertController(title: "Weight and reps cannot be empty", defaultFont: Fonts.Montserrat_Small_Medium.bold(), defaultColor: Colors.blackTextColor)
        
        alert.addAction(title: "End", color: Colors.redColor, font: Fonts.Montserrat_Small_Medium) { _ in
            self.didEndExerciseSession()
        }
        alert.addAction(title: "Ok", color: Colors.blackTextColor, font: Fonts.Montserrat_Small_Medium)
        
        self.present(alert, animated: true)
    }
    
    @objc func handleTap() {
        self._sessionInProgressSetView.endEditing(true)
    }
    
    func showNotesPopUp() {
        let vc = SessionNotesPopUpViewController(note: notes)
        vc.delegate = self
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .coverVertical
        self.present(vc, animated: true)
    }
    
    func updateNotes(note: String) {
        notes = note
        self._sessionInProgressSetView._noteButton.setTitle(notes.count == 0 ? "Add Note" : "Edit Note", for: .normal)
    }
    
    @objc func updateCounter() {
        if let notNilSessionStartTime = sessionStartTime {
            let timeInterval = notNilSessionStartTime.timeIntervalSinceNow * -1
            let hours = timeInterval.hours
            let minutes = timeInterval.minutes
            let seconds = timeInterval.seconds
            self._sessionInProgressSetView._timerLabel.text = String(format: "%02d : %02d : %02d", hours, minutes, seconds)
        }
    }
    
    func endExerciseWrapper(alert: UIAlertAction) {
        self.didEndExerciseSession()
    }
}
