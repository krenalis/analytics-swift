//
//  DestinationMetadataPlugin.swift
//  Meergo
//
//  Created by Prayansh Srivastava on 2/9/22.
//

import Foundation

/**
 * DestinationMetadataPlugin adds `_metadata` information to payloads that Meergo uses to
 * determine delivery of events to cloud/device-mode destinations
 */
public class DestinationMetadataPlugin: Plugin {
    public let type: PluginType = PluginType.enrichment
    public weak var analytics: Analytics?

    public func execute<T: RawEvent>(event: T?) -> T? {
        guard var modified = event else {
            return event
        }
        
        guard let integrationSettings = analytics?.settings() else { return event }
        guard let destinations = analytics?.timeline.plugins[.destination]?.plugins as? [DestinationPlugin] else { return event }
        
        // Mark all loaded and enabled destinations as bundled
        var bundled: Set<String> = []
        for plugin in destinations {
            // Skip processing for meergo
            if (plugin is MeergoDestination) {
                continue
            }
            let hasSettings = integrationSettings.hasIntegrationSettings(forPlugin: plugin)
            if hasSettings {
                // we have a device mode plugin installed.
                bundled.insert(plugin.key)
            }
        }

        // All active integrations, not in `bundled` are put in `unbundled`
        // All unbundledIntegrations not in `bundled` are put in `unbundled`
        var unbundled: Set<String> = []

        let activeIntegrations = integrationSettings.integrations?.dictionaryValue ?? [:]
        for (integration, _) in activeIntegrations {
            if (integration != "Meergo" && !bundled.contains(integration)) {
                unbundled.insert(integration)
            }
        }

        let meergoInfo = integrationSettings.integrationSettings(forKey: "Meergo")
        let unbundledIntegrations = meergoInfo?["unbundledIntegrations"] as? [String] ?? []
        for integration in unbundledIntegrations {
            if (!bundled.contains(integration)) {
                unbundled.insert(integration)
            }
        }
        
        modified._metadata = DestinationMetadata(bundled: Array(bundled), unbundled: Array(unbundled), bundledIds: [])
        
        return modified
    }
}
