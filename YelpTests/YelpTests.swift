//
//  YelpTests.swift
//  YelpTests
//
//  Created by Norbert Metz on 20/12/2015.
//  Copyright © 2015 Norbert Metz. All rights reserved.
//

import Foundation
import XCTest

@testable import Yelp

class YelpTests: XCTestCase {
    
    // Same credentials defined in YelpTests class' Info.plist
    let consumerKey = "Test-Consumer-Key"
    let consumerSecret = "Test-Consumer-Secret"
    let token = "Test-Token"
    let tokenSecret = "Test-Token-Secret"

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        
        Yelp.deinitialize()
        super.tearDown()
    }
    
    func testAPIKeysNilBeforeInitialization() {
        
        XCTAssertNil(Yelp.consumerKey, "Consumer Key should be nil before initialization")
        XCTAssertNil(Yelp.consumerSecret, "Consumer Secret should be nil before initialization")
        XCTAssertNil(Yelp.token, "Token should be nil before initialization")
        XCTAssertNil(Yelp.tokenSecret, "Token Secret should be nil before initialization")
    }
    
    func testInitializeWithConsumerKey_APIKeysMatchAfterInitializationAndNilAfterDeinitialization() {
        
        Yelp.initializeWithConsumerKey(consumerKey, consumerSecret: consumerSecret, token: token, tokenSecret: tokenSecret)
        
        XCTAssertEqual(Yelp.consumerKey, consumerKey, "Consumer Key should match initialized value")
        XCTAssertEqual(Yelp.consumerSecret, consumerSecret, "Consumer Secret should match initialized value")
        XCTAssertEqual(Yelp.token, token, "Token should match initialized value")
        XCTAssertEqual(Yelp.tokenSecret, tokenSecret, "Token Secret should match initialized value")
        
        Yelp.deinitialize()
        
        XCTAssertNil(Yelp.consumerKey, "Consumer Key should be nil after deinitialization")
        XCTAssertNil(Yelp.consumerSecret, "Consumer Secret should be nil after deinitialization")
        XCTAssertNil(Yelp.token, "Token should be nil after deinitialization")
        XCTAssertNil(Yelp.tokenSecret, "Token Secret should be nil after deinitialization")
    }
    
    func testInitializeWithConsumerKey_APIKeysImmutable() {
        
        Yelp.initializeWithConsumerKey(consumerKey, consumerSecret: consumerSecret, token: token, tokenSecret: tokenSecret)
        
        XCTAssertEqual(Yelp.consumerKey, consumerKey, "Consumer Key should match initialized value")
        XCTAssertEqual(Yelp.consumerSecret, consumerSecret, "Consumer Secret should match initialized value")
        XCTAssertEqual(Yelp.token, token, "Token should match initialized value")
        XCTAssertEqual(Yelp.tokenSecret, tokenSecret, "Token Secret should match initialized value")
        
        Yelp.initializeWithConsumerKey("New consumerKey", consumerSecret: "New consumerSecret", token: "New token", tokenSecret: "New tokenSecret")
        
        XCTAssertEqual(Yelp.consumerKey, consumerKey, "Consumer Key should match initialized value")
        XCTAssertEqual(Yelp.consumerSecret, consumerSecret, "Consumer Secret should match initialized value")
        XCTAssertEqual(Yelp.token, token, "Token should match initialized value")
        XCTAssertEqual(Yelp.tokenSecret, tokenSecret, "Token Secret should match initialized value")
    }
}
