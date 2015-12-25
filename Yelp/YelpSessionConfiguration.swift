//
//  YelpSessionConfiguration.swift
//  Yelp
//
//  Created by Norbert Metz on 25/12/2015.
//  Copyright © 2015 Norbert Metz. All rights reserved.
//

public class YelpSessionConfiguration {
    
    // Internal data structure to hold Yelp API keys
    private var APIKeys = [String:String]()
    
    /// The [Yelp API v2.0](https://www.yelp.com/developers/manage_api_keys) Consumer Key, set after a successful initialization of the Yelp framework.
    public var consumerKey: String! {
        return APIKeys[YelpAuthTokenType.ConsumerKey]
    }
    
    /// The [Yelp API v2.0](https://www.yelp.com/developers/manage_api_keys) Consumer Secret, set after a successful initialization of the Yelp framework.
    public var consumerSecret: String! {
        return APIKeys[YelpAuthTokenType.ConsumerSecret]
    }
    
    /// The [Yelp API v2.0](https://www.yelp.com/developers/manage_api_keys) Token, set after a successful initialization of the Yelp framework.
    public var token: String! {
        return APIKeys[YelpAuthTokenType.Token]
    }
    
    /// The [Yelp API v2.0](https://www.yelp.com/developers/manage_api_keys) Token Secret, set after a successful initialization of the Yelp framework.
    public var tokenSecret: String! {
        return APIKeys[YelpAuthTokenType.TokenSecret]
    }

    init (consumerKey: String, consumerSecret: String, token: String, tokenSecret: String) {
        APIKeys[YelpAuthTokenType.ConsumerKey]      = consumerKey
        APIKeys[YelpAuthTokenType.ConsumerSecret]   = consumerSecret
        APIKeys[YelpAuthTokenType.Token]            = token
        APIKeys[YelpAuthTokenType.TokenSecret]      = tokenSecret
    }
}
