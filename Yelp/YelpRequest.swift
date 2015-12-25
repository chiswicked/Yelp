//
//  YelpQueryRequest.swift
//  ImportTestApp
//
//  Created by Norbert Metz on 13/12/2015.
//  Copyright © 2015 Norbert Metz. All rights reserved.
//

import Foundation

public typealias YelpRequestParameters = [String: AnyObject]

/**
 `YelpSearchSortType`
 
 Available `sort` types (modes) as defined in the [Yelp API v2.0](https://www.yelp.com/developers/documentation/v2/search_api)
 
 If the mode is `BestMatched` or `Distance` a search may retrieve an additional 20 businesses past the initial limit of the first 20 results. This is done by specifying an offset and limit of 20. Sort by distance is only supported for a location or geographic search. The rating sort is not strictly sorted by the rating value, but by an adjusted rating value that takes into account the number of ratings, similar to a bayesian average. This is so a business with 1 rating of 5 stars doesn’t immediately jump to the top.
 
 - BestMatched:  0
 - Distance:     1
 - HighestRated: 2
 */
public enum YelpSearchSortType: Int {
    case BestMatched    = 0
    case Distance       = 1
    case HighestRated   = 2
}

/**
 The YelpQueryRequest protocol defines the interface for a utility object that you use to specify a Yelp API v2.0 search request. After creating an instance of this object, you then use the configured object to initialize a `YelpQuery` object and perform your search.
 */
public protocol YelpRequest {
    var parameters: YelpRequestParameters { get }
    var path: String { get }
    var type: YelpQueryType { get }
    var URL:  NSURL  { get }
    
}

extension YelpRequest {
    public var URL: NSURL {
        get {
            return NSURL(string: YelpEndpoint.APIBaseURL + path)!
        }
    }
}

/**
 A `YelpSearchRequest` object is a utility object that you use to specify a Yelp API v2.0 [Search API](https://www.yelp.com/developers/documentation/v2/search_api) search request.
 
 The initialization of a `YelpSearchRequest` object requires a `YelpRequestParameters` dictionay holding the search parameters as defined in the [Search API](https://www.yelp.com/developers/documentation/v2/search_api)
 
 Alternatively one of the convenience initializers can be used with a more natural method parameter list to provide the [Search API](https://www.yelp.com/developers/documentation/v2/search_api) parameters.
 
 After creating an instance of the `YelpSearchRequest` object, you then use the configured object to initialize a `YelpQuery` object and perform your search.
 */
public class YelpSearchRequest: YelpRequest {
    
    private var rawParameters: YelpRequestParameters
    
    public var parameters: YelpRequestParameters { return rawParameters }
    
    public var type: YelpQueryType { return YelpQueryType.Search }
    public var path: String { return type.rawValue }
    
    public init(parameters: YelpRequestParameters = YelpRequestParameters()) {
        self.rawParameters = parameters
    }
    
    public init(term: String, sort: YelpSearchSortType? = nil, categoryFilter: String? = nil, limit: NSNumber? = nil) {
        
        rawParameters = YelpRequestParameters()
        rawParameters["term"] = term
        rawParameters["limit"] = limit
        rawParameters["sort"] = sort?.rawValue
        rawParameters["categoryFilter"] = categoryFilter
        rawParameters["ll"] = "37.785771,-122.406165"
    }
}

/**
 A `YelpBusinessRequest` object is a utility object that you use to specify a Yelp API v2.0 [Business API](https://www.yelp.com/developers/documentation/v2/business) search request.
 
 The initialization of a `YelpBusinessRequest` object requires a `YelpRequestParameters` dictionay holding the search parameters as defined in the [[Business API](https://www.yelp.com/developers/documentation/v2/business)
 
 Alternatively one of the convenience initializers can be used with a more natural method parameter list to provide the [Business API](https://www.yelp.com/developers/documentation/v2/business) parameters.
 
 After creating an instance of the `YelpBusinessRequest` object, you then use the configured object to initialize a `YelpQuery` object and perform your search.
 */
public class YelpBusinessRequest: YelpRequest {
    
    private var businessID: String
    private var rawParameters: YelpRequestParameters
    
    public var parameters: YelpRequestParameters { return rawParameters }
    
    public var type: YelpQueryType { return YelpQueryType.Business }
    public var path: String { return type.rawValue + "/" + businessID }
    
    public init(businessID: String, parameters: YelpRequestParameters = YelpRequestParameters()) {
        
        self.businessID = businessID
        
        self.rawParameters = parameters
    }
    
    public init(businessID: String, countryCode: String, language: String, filterReviewsByLanguage: Bool) {
        
        self.businessID = businessID
        
        rawParameters = YelpRequestParameters()
        rawParameters["cc"] = countryCode
        rawParameters["lang"] = language
        rawParameters["lang_filter"] = filterReviewsByLanguage
    }
}

/**
 A `YelpPhoneSearchRequest` object is a utility object that you use to specify a Yelp API v2.0 [Business API](https://www.yelp.com/developers/documentation/v2/phone_search) search request.
 
 The initialization of a `YelpPhoneSearchRequest` object requires a `YelpRequestParameters` dictionay holding the search parameters as defined in the [[Business API](https://www.yelp.com/developers/documentation/v2/phone_search)
 
 Alternatively one of the convenience initializers can be used with a more natural method parameter list to provide the [Business API](https://www.yelp.com/developers/documentation/v2/phone_search) parameters.
 
 After creating an instance of the `YelpPhoneSearchRequest` object, you then use the configured object to initialize a `YelpQuery` object and perform your search.
 */
public class YelpPhoneSearchRequest: YelpRequest {
    
    private var rawParameters: YelpRequestParameters
    
    public var parameters: YelpRequestParameters { return rawParameters }
    
    public var type: YelpQueryType { return YelpQueryType.PhoneSearch }
    public var path: String { return type.rawValue }
    
    public init!(parameters: YelpRequestParameters) {

        self.rawParameters = parameters
       
        guard parameters["phone"] != nil else { return nil }
    }
    
    public init(phone: String, parameters: YelpRequestParameters? = nil) {
        
        if let params = parameters {
            self.rawParameters = params
        } else {
            self.rawParameters = YelpRequestParameters()
        }
        
        rawParameters["phone"] = phone
    }
    
    public init(phone: String, countryCode: String? = nil, category: String? = nil) {
        
        rawParameters = YelpRequestParameters()
        rawParameters["phone"] = phone
        rawParameters["cc"] = countryCode
        rawParameters["category"] = category
    }
}
