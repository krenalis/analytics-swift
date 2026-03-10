//
//  Article.swift
//  SegmentExtensionsExample
//
//  Created by Alan Charles on 8/15/21.
//

import Foundation
import Meergo

struct Article {
    let title: String
    let source: String
    let imageName: String
}

extension Article {
    
    private static let availableLibDocs = [
        Article(title:"Analytics for iOS ", source: "https://meergo.com/docs/connections/sources/catalog/libraries/mobile/ios/#analytics-for-ios", imageName: "Meergo_logo"),
        Article(title:"Analytics for Android", source: "https://meergo.com/docs/connections/sources/catalog/libraries/mobile/android/", imageName: "Meergo_logo"),
        Article(title:"Analytics for React Native", source: "https://meergo.com/docs/connections/sources/catalog/libraries/mobile/react-native/", imageName: "Meergo_logo"),
        Article(title:"Analytics.js", source: "https://meergo.com/docs/connections/sources/catalog/libraries/website/javascript/", imageName: "Meergo_logo"),
        Article(title:"Analytics for Node ", source: "https://meergo.com/docs/connections/sources/catalog/libraries/server/node/", imageName: "Meergo_logo"),
    ]
    
    private static let availableDestDocs = [
        Article(title:"Appsflyer Destination", source: "https://meergo.com/docs/connections/destinations/catalog/appsflyer/", imageName: "Meergo_logo"),
        Article(title:"Firebase Destination", source: "https://meergo.com/docs/connections/destinations/catalog/firebase/", imageName: "Meergo_logo"),
        Article(title:"Facebook App Events Destination", source: "https://meergo.com/docs/connections/destinations/catalog/facebook-app-events/", imageName: "Meergo_logo"),
        Article(title:"Mixpanel Destination", source: "https://meergo.com/docs/connections/destinations/catalog/mixpanel/", imageName: "Meergo_logo"),
        Article(title:"Amplitude Destination", source: "https://meergo.com/docs/connections/destinations/catalog/Amplitude/", imageName: "Meergo_logo"),
        
    ]
    
    static var libDocs: [Article] {
        return Array(availableLibDocs.shuffled().prefix(2))
    }
    
    static var destDocs: [Article] {
        return Array(availableDestDocs.shuffled().prefix(2))
    }
}
