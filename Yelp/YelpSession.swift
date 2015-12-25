//
//  YelpSession.swift
//  Yelp
//
//  Created by Norbert Metz on 25/12/2015.
//  Copyright © 2015 Norbert Metz. All rights reserved.
//

import Foundation
import BDBOAuth1Manager

/**
 Convenient helper to access Yelp endpoints:
 - [Yelp API v2.0 Base URL](https://api.yelp.com/v2/)
 - [Categories](https://www.yelp.com/developers/documentation/v2/all_category_list/categories.json)
 */
struct YelpEndpoint {
    
    static let APIBaseURL           = "https://api.yelp.com/v2/"
    static let CategoryList         = "https://www.yelp.com/developers/documentation/v2/all_category_list/categories.json"
}

public class YelpSession {
    
    // TODO: Make class tread-safe
    
    /// Networking utility that handles the [OAuth 1.0a](http://tools.ietf.org/html/rfc5849) authentication session as required by [Yelp API v2.0](https://www.yelp.com/developers/documentation/v2/authentication)
    private var sessionManager: BDBOAuth1SessionManager?
    
    public convenience init(consumerKey: String, consumerSecret: String, token: String, tokenSecret: String) {
        self.init(credentials: YelpSessionConfiguration(consumerKey: consumerKey, consumerSecret: consumerSecret, token: token, tokenSecret: tokenSecret))
    }
    
    public init(credentials: YelpSessionConfiguration) {
        
        // TODO: May require refactoring for the sake of unit testing
        
        let baseURL = NSURL(string: YelpEndpoint.APIBaseURL)
        
        if let sessionManager = BDBOAuth1SessionManager(baseURL: baseURL, consumerKey: credentials.consumerKey, consumerSecret: credentials.consumerSecret) {
            
            if let accessToken = BDBOAuth1Credential(token: credentials.token, secret: credentials.tokenSecret, expiration: nil) {
                sessionManager.requestSerializer.saveAccessToken(accessToken)
            }
            
            self.sessionManager = sessionManager
        }
    }
    
    public func queryWithRequest(request: YelpRequest, completionHandler: YelpQueryCompletionHandler) -> YelpQuery {
        return YelpQuery(sessionManager: sessionManager!, request: request, completionHandler: completionHandler)
    }
    
    public func queryWithRequest(request: YelpRequest, delegate: YelpQueryDelegate) -> YelpQuery {
        return YelpQuery(sessionManager: sessionManager!, request: request, delegate: delegate)
    }
}