//
//  EventData.swift
//  BasicExample
//
//  Created by Brandon Sneed on 5/24/21.
//

import Foundation
import Krenalis
import UIKit

struct WorkoutProperties: Codable {
    let workoutType: String
    let durationMinutes: Int
    let caloriesBurned: Int
    let device: String
}

struct NameTraits: Codable {
    let name: String
}

struct EmailTraits: Codable {
    let email: String
}

struct AgeTraits: Codable {
    let age: String
}


class OutputPlugin: Plugin {
    let type: PluginType = .after
    let name: String

    var analytics: Analytics?
    var textView: UITextView!

    required init(name: String) {
        self.name = name
    }

    init(textView: UITextView!) {
        self.textView = textView
        self.name = "output_capture"
    }

    func execute<T>(event: T?) -> T? where T : RawEvent {
        let string = event?.prettyPrint()
        textView.text = string
        return event
    }
}
