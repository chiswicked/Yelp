//
//  YelpQuery.swift
//  Yelp
//
//  Created by Norbert Metz on 13/12/2015.
//  Copyright © 2015 Norbert Metz. All rights reserved.
//

import Foundation
import BDBOAuth1Manager

public typealias YelpQueryCompletionHandler = (YelpResponse?, NSError?) -> (Void)

public typealias YelpQueryProgressHandler   = (progress: NSProgress) -> Void
public typealias YelpQuerySuccessHandler    = (operation: NSURLSessionDataTask?, response: AnyObject?) -> Void
public typealias YelpQueryFailureHandler    = (operation: NSURLSessionDataTask?, error: NSError) -> Void

/**
 Definition of available query types the [Yelp API v2.0](https://www.yelp.com/developers/documentation/v2/overview) accepts.
 - [`search`](https://www.yelp.com/developers/documentation/v2/search_api)
 - [`business`](https://www.yelp.com/developers/documentation/v2/business)
 - [`phone_search`](https://www.yelp.com/developers/documentation/v2/phone_search)
 */
public enum YelpQueryType: String {
    
    case Search         = "search"
    case Business       = "business"
    case PhoneSearch    = "phone_search"
}

/**
 A `YelpQuery` object initiates a search operation using the [Yelp API v2.0](https://www.yelp.com/developers/documentation/v2/overview) and delivers the results back to your app asynchronously. `YelpQuery` objects are designed to perform one search operation only. To perform several different searches, you must create separate instances of this class and start them separately.
 
 ## Overview
 
 You use this class to perform programmatic searches of business information from the Yelp platform. Currently the following search operations are supported:
 - [Search API](https://www.yelp.com/developers/documentation/v2/search_api)
 - [Business API](https://www.yelp.com/developers/documentation/v2/business)
 - [Phone Search API](https://www.yelp.com/developers/documentation/v2/phone_search)
 */

public class YelpQuery {
    
    // TODO: Expose request
    
    /// The `YelpQueryRequest` with which the `YelpQuery` was initialized
    private var request: YelpRequest
    
    /// Networking utility that handles the [OAuth 1.0a](http://tools.ietf.org/html/rfc5849) authentication session as required by [Yelp API v2.0](https://www.yelp.com/developers/documentation/v2/authentication)
    private var sessionManager: BDBOAuth1SessionManager?
    
    public var authorized: Bool { return sessionManager != nil ? sessionManager!.authorized : false }
    
    private init(sessionManager: BDBOAuth1SessionManager, request: YelpRequest) {
        self.sessionManager = sessionManager
        self.request = request
    }
    
    public func resume() {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            
            if self.authorized {
                self.executeQuery()
            } else {
                let error = NSError(domain: "uk.co.chiswicked", code: 0, userInfo: [NSLocalizedDescriptionKey: "Connection to Yelp API v2.0 was unsuccesful", NSLocalizedFailureReasonErrorKey: "YelpSession was not initialized correctly", NSLocalizedRecoverySuggestionErrorKey: "Try initializing YelpSession with correct credentials"])
                
                self.returnError(error)
            }
        }
    }
    
    private func executeQuery() {}
    
    private func returnError(error: NSError) {}
}

public class YelpCompletionHandledQuery: YelpQuery {
    
    private var completionHandler: YelpQueryCompletionHandler!
    
    init(sessionManager: BDBOAuth1SessionManager, request: YelpRequest, completionHandler: YelpQueryCompletionHandler) {
        super.init(sessionManager: sessionManager, request: request)
        self.completionHandler = completionHandler
    }
    
    private override func executeQuery() {
        
        let progress: YelpQueryProgressHandler = {
            (progress: NSProgress) -> Void in
            // Progress feedback is not supported in completion handlers
        }
        
        let success: YelpQuerySuccessHandler = {
            [unowned self] (operation: NSURLSessionDataTask?, response: AnyObject?) -> Void in
            let yelpReponse = YelpResponse(type: self.request.type, operation: operation, body: response!)
            self.completionHandler(yelpReponse, nil)
        }
        
        let failure: YelpQueryFailureHandler = {
            [unowned self] (operation: NSURLSessionDataTask?, error: NSError) -> Void in
            self.completionHandler(nil, error)
        }
        
        sessionManager!.GET(request.path, parameters: request.parameters, progress: progress, success: success, failure: failure)
    }
    
    private override func returnError(error: NSError) {
        completionHandler(nil, error)
    }
}

public class YelpDelegatedQuery: YelpQuery {
    
    /// Reference to the object that will handle callbacks when the `YelpQuery` object is executed with the `executeWithDelegate()` method
    private var delegate: YelpQueryDelegate!
    
    init(sessionManager: BDBOAuth1SessionManager, request: YelpRequest, delegate: YelpQueryDelegate) {
        super.init(sessionManager: sessionManager, request: request)
        self.delegate = delegate
    }
    
    private override func executeQuery() {
        
        let progress: YelpQueryProgressHandler = {
            [unowned self] (progress: NSProgress) -> Void in
            self.delegate.yelpQuery(self, didMakeProgress: progress)
        }
        
        let success: YelpQuerySuccessHandler = {
            [unowned self] (operation: NSURLSessionDataTask?, response: AnyObject?) -> Void in
            self.delegate.yelpQuery(self, didFinishWithResponse: YelpResponse(type: self.request.type, operation: operation, body: response!), operation: operation)
        }
        
        let failure: YelpQueryFailureHandler = {
            [unowned self] (operation: NSURLSessionDataTask?, error: NSError) -> Void in
            self.delegate.yelpQuery(self, didFinishWithError: error, operation: operation)
        }
        
        sessionManager!.GET(request.path, parameters: request.parameters, progress: progress, success: success, failure: failure)
    }
    
    private override func returnError(error: NSError) {
        delegate.yelpQuery(self, didFinishWithError: error, operation: nil)
    }
}










