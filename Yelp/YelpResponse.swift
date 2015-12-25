//
//  YelpQueryResponse.swift
//  ImportTestApp
//
//  Created by Norbert Metz on 13/12/2015.
//  Copyright © 2015 Norbert Metz. All rights reserved.
//

import Foundation
import SwiftyJSON

public class YelpResponse {
    
    private var operation: NSURLSessionDataTask?
    private var responseBody: AnyObject
    public var body: JSON { return JSON(responseBody) }
    public var businesses: [YelpBusiness] { return getBusinesses() }
    
    private var responseType: YelpQueryType
    public var type: YelpQueryType { return responseType }
    
    public init(type responseType: YelpQueryType, operation: NSURLSessionDataTask?, body responseBody: AnyObject) {
        self.responseType = responseType
        self.operation = operation
        self.responseBody = responseBody
        
    }
    
    private func getBusinesses() -> [YelpBusiness] {
        
        var resp = [YelpBusiness]()
        
        if let businesses = responseBody["businesses"] as? NSArray {
            for business in businesses {
                resp.append(YelpBusiness(json: JSON(business)))
            }
        } else {
            resp.append(YelpBusiness(json: body))
        }
        
        return resp
    }
}


