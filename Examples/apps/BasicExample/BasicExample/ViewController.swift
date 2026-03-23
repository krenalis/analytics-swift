//
//  ViewController.swift
//  BasicExample
//
//  Created by Brandon Sneed on 5/21/21.
//

import UIKit
import Krenalis

class ViewController: UIViewController {
    var analytics: Analytics? {
        return UIApplication.shared.delegate?.analytics
    }

    @IBOutlet weak var eventView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let outputCapture = OutputPlugin(textView: eventView)
        analytics?.add(plugin: outputCapture)
    }

    @IBAction func startSessionTapped(_ sender: Any) {
        analytics?.startSession()
    }

    @IBAction func endSessionTapped(_ sender: Any) {
        analytics?.endSession()
    }

    @IBAction func trackWorkoutTapped(_ sender: Any) {
        analytics?.track(name: "Workout Completed", properties: WorkoutProperties(
            workoutType: "Cardio",
            durationMinutes: 45,
            caloriesBurned: 380,
            device: "Smartwatch"
        ))
    }

    @IBAction func identifyTapped(_ sender: Any) {
        analytics?.identify(userId: "user1234", traits: NameTraits(name: "Jhon"))
    }

    @IBAction func identifyWithEmailTapped(_ sender: Any) {
        analytics?.identify(userId: "", traits: EmailTraits(email: "user1234@example.com"))
    }

    @IBAction func identifyWithAgeTapped(_ sender: Any) {
        analytics?.identify(userId: "", traits: AgeTraits(age: "35"))
    }

    @IBAction func resetTapped(_ sender: Any) {
        analytics?.reset()
    }
}
