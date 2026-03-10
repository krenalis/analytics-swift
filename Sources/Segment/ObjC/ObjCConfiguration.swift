//
//  ObjCConfiguration.swift
//
//
//  Created by Brandon Sneed on 8/13/21.
//

#if !os(Linux) && !os(Windows)

import Foundation
import JSONSafeEncoding

@objc(MRGConfiguration)
public class ObjCConfiguration: NSObject {
    internal var configuration: Configuration

    /// Sets a reference to your application.  This can be useful in instances
    /// where referring back to your application is necessary, such as within plugins
    /// or async code.  The default value is `nil`.
    @objc
    public var application: Any? {
        get {
            return configuration.values.application
        }
        set(value) {
            configuration.application(value)
        }
    }

    /// Opt-in/out of tracking lifecycle events.  The default value is `true`.
    /// NOTE: the default differs from analytics-ios.
    @objc
    public var trackApplicationLifecycleEvents: Bool {
        get {
            return (configuration.values.trackedApplicationLifecycleEvents != .none)
        }
        set(value) {
            configuration.setTrackedApplicationLifecycleEvents(.all)
        }
    }

    /// Set the number of events necessary to automatically flush. The default
    /// value is `20`.
    @objc
    public var flushAt: Int {
        get {
            return configuration.values.flushAt
        }
        set(value) {
            configuration.flushAt(value)
        }
    }

    /// Set a time interval (in seconds) by which to trigger an automatic flush.
    /// The default value is `30`.
    @objc
    public var flushInterval: TimeInterval {
        get {
            return configuration.values.flushInterval
        }
        set(value) {
            configuration.flushInterval(value)
        }
    }

    /// Sets a default set of Settings.  Normally these will come from the
    /// configured endpoint at `$endpoint/settings/$writeKey`, however in instances
    /// such as first app launch, it can be useful to have a pre-set batch of settings
    /// to ensure that the proper destinations and other settings are enabled prior
    /// to receiving them from the Settings endpoint.  The default is `nil`.
    @objc
    public var defaultSettings: [String: Any] {
        get {
            var result = [String: Any]()
            do {
                let encoder = JSONSafeEncoder.default
                let json = try encoder.encode(configuration.values.defaultSettings)
                if let r = try JSONSerialization.jsonObject(with: json) as? [String: Any] {
                    result = r
                }
            } catch {
                // not sure why this would fail, but report it.
                exceptionFailure("Failed to convert Settings to ObjC dictionary: \(error)")
            }
            return result
        }
        set(value) {
            do {
                let json = try JSONSerialization.data(withJSONObject: value, options: .prettyPrinted)
                let decoder = JSONDecoder.default
                let settings = try decoder.decode(Settings.self, from: json)
                configuration.defaultSettings(settings)
            } catch {
                exceptionFailure("Failed to convert defaultSettings to Settings object: \(error)")
            }
        }
    }

    /// Enable/Disable the automatic adding of Meergo as a destination.
    /// This can be useful in instances such as Consent Management, or in device
    /// mode only setups.  The default value is `true`.
    @objc
    public var autoAddMeergoDestination: Bool {
        get {
            return configuration.values.autoAddMeergoDestination
        }
        set(value) {
            configuration.autoAddMeergoDestination(value)
        }
    }

    /// Sets a custom endpoint for event uploads and settings retrieval.
    /// The default value is `test.example.com/v1`.
    @objc
    public var endpoint: String {
        get {
            return configuration.values.endpoint
        }
        set(value) {
            configuration.endpoint(value)
        }
    }

    /// Sets a block to be used when generating outgoing HTTP requests.  Useful in
    /// proxying, or adding additional header information for outbound traffic.
    ///
    /// - Parameter value: A block to call when requests are made.
    /// - Returns: The current Configuration.
    @objc
    public var requestFactory: ((URLRequest) -> URLRequest)? {
        get {
            return configuration.values.requestFactory
        }
        set(value) {
            configuration.values.requestFactory = value
        }
    }

    /// Initialize a configuration object to pass along to an Analytics instance.
    ///
    /// - Parameter writeKey: Your Meergo write key value
    @objc
    public init(writeKey: String) {
        self.configuration = Configuration(writeKey: writeKey)
    }
}

#endif
