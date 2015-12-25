//
//  YelpQueryDelegate.swift
//  Yelp
//
//  Created by Norbert Metz on 22/12/2015.
//  Copyright © 2015 Norbert Metz. All rights reserved.
//

import Foundation

/**
The `YelpQueryDelegate` protocol defines methods that are called by the `YelpQuery` object in response to important events regarding the query executed against the [Yelp API v2.0](https://www.yelp.com/developers/documentation/v2/overview).

Overview

You use the methods of the query delegate to obtain information about progress the query execution has made or to handle events when query execution is finished with a success or failure.
*/
public protocol YelpQueryDelegate {
    
    /**
     Tells the delegate that the query executed against the [Yelp API v2.0](https://www.yelp.com/developers/documentation/v2/overview) has made progress.
     
     - parameter query:    The query being executed
     - parameter progress: Progress report
     */
    func yelpQuery(query: YelpQuery, didMakeProgress progress: NSProgress)
    
    /**
     Tells the delegate that the query executed against the [Yelp API v2.0](https://www.yelp.com/developers/documentation/v2/overview) has completed successfully.
     
     - parameter query:     The query being executed
     - parameter response:  [Yelp API v2.0](https://www.yelp.com/developers/documentation/v2/overview) response
     - parameter operation: Raw details of the HTTP operation
     */
    func yelpQuery(query: YelpQuery, didFinishWithResponse response: YelpResponse, operation: NSURLSessionDataTask?)
    
    /**
     Tells the delegate that the query executed against the [Yelp API v2.0](https://www.yelp.com/developers/documentation/v2/overview) has completed with an error.
     
     - parameter query:     The query being executed
     - parameter error:     Description of the error occurred
     - parameter operation: Raw details of the HTTP operation
     */
    func yelpQuery(query: YelpQuery, didFinishWithError error: NSError, operation: NSURLSessionDataTask?)
}

extension YelpQueryDelegate {
    
    func yelpQuery(query: YelpQuery, didMakeProgress progress: NSProgress) {
        // Workaround to make the method optional as custom types such as the YelpQuery parameter is not suported by @objc
    }
}
