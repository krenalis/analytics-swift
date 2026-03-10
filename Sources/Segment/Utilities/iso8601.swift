//
//  iso8601.swift
//  Meergo
//
//  Created by Brandon Sneed on 12/8/20.
//

import Foundation

enum MeergoISO8601DateFormatter {
    static let shared: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions.update(with: .withFractionalSeconds)
        return formatter
    }()
}

internal extension Date {
    func iso8601() -> String {
        return MeergoISO8601DateFormatter.shared.string(from: self)
    }
}

internal extension String {
    func iso8601() -> Date? {
        return MeergoISO8601DateFormatter.shared.date(from: self)
    }
}
