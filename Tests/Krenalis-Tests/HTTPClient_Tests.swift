//
//  HTTPClientTests.swift
//  Krenalis-Tests
//
//  Created by Brandon Sneed on 1/21/21.
//

#if !os(Linux) && !os(Windows)

import XCTest
@testable import Krenalis

class HTTPClientTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        RestrictedHTTPSession.reset()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCustomHTTPSessionUpload() throws {
        // Use a specific writekey to this test so we do not collide with other cached items.
        let analytics = Analytics(
            configuration: Configuration(writeKey: "testCustomSesh")
                .flushInterval(9999)
                .flushAt(9999)
                .httpSession(RestrictedHTTPSession())
        )
        
        waitUntilStarted(analytics: analytics)
        
        analytics.storage.hardReset(doYouKnowHowToUseThis: true)
        
        analytics.identify(userId: "brandon", traits: MyTraits(email: "blah@blah.com"))
        
        let flushDone = XCTestExpectation(description: "flush done")
        analytics.flush {
            flushDone.fulfill()
        }
    
        wait(for: [flushDone])
         
        XCTAssertEqual(RestrictedHTTPSession.fileUploads, 1)
    }
    
    func testDefaultHTTPSessionUpload() throws {
        // Use a specific writekey to this test so we do not collide with other cached items.
        let analytics = Analytics(
            configuration: Configuration(writeKey: "testDefaultSesh")
                .flushInterval(9999)
                .flushAt(9999)
        )
        
        // reach in and set it, would be the same as the default ultimately
        let krenalis = analytics.find(pluginType: KrenalisDestination.self)
        XCTAssertTrue(!(krenalis?.httpClient?.session is RestrictedHTTPSession))
        XCTAssertTrue(krenalis?.httpClient?.session is URLSession)
        krenalis?.httpClient?.session = RestrictedHTTPSession()
        
        waitUntilStarted(analytics: analytics)
        
        analytics.storage.hardReset(doYouKnowHowToUseThis: true)
        
        analytics.identify(userId: "brandon", traits: MyTraits(email: "blah@blah.com"))
        
        let flushDone = XCTestExpectation(description: "flush done")
        analytics.flush {
            flushDone.fulfill()
        }
    
        wait(for: [flushDone])
         
        XCTAssertEqual(RestrictedHTTPSession.fileUploads, 1)
    }
}

#endif
