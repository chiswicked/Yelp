//
//  Yelp.swift
//  Yelp
//
//  Created by Norbert Metz on 13/12/2015.
//  Copyright © 2015 Norbert Metz. All rights reserved.
//

/**
 *  Yelp API v2.0 credential type references for internal use
 */
struct YelpAuthTokenType {
    
    static let ConsumerKey       = "YelpConsumerKey"
    static let ConsumerSecret    = "YelpConsumerSecret"
    static let Token             = "YelpToken"
    static let TokenSecret       = "YelpTokenSecret"
}

/**
 Singleton class providing basic initialization tools for the Yelp framework.
 
 Use `Yelp.initializeWithConsumerKey()` in the `AppDelegate` `didFinishLaunchingWithOptions` delegate method to initialize the Yelp framework.
 */
public class Yelp {
    
    // Flag whether to allow initialization through the Yelp.initializeWithConsumerKey() method. Set to true after the first successful initialization.
    private var initialized = false
    
    // Internal data structure to hold Yelp API keys
    private var APIKeys = [String:String]()
    
    /// The [Yelp API v2.0](https://www.yelp.com/developers/manage_api_keys) Consumer Key, set after a successful initialization of the Yelp framework.
    public static var consumerKey: String! {
            return Yelp.sharedInstance.initialized ? Yelp.sharedInstance.APIKeys[YelpAuthTokenType.ConsumerKey]! : nil
    }
    
    /// The [Yelp API v2.0](https://www.yelp.com/developers/manage_api_keys) Consumer Secret, set after a successful initialization of the Yelp framework.
    public static var consumerSecret: String! {
            return Yelp.sharedInstance.initialized ? Yelp.sharedInstance.APIKeys[YelpAuthTokenType.ConsumerSecret]! : nil
    }
    
    /// The [Yelp API v2.0](https://www.yelp.com/developers/manage_api_keys) Token, set after a successful initialization of the Yelp framework.
    public static var token: String! {
            return Yelp.sharedInstance.initialized ? Yelp.sharedInstance.APIKeys[YelpAuthTokenType.Token]! : nil
    }
    
    /// The [Yelp API v2.0](https://www.yelp.com/developers/manage_api_keys) Token Secret, set after a successful initialization of the Yelp framework.
    public static var tokenSecret: String! {
        get {
            return Yelp.sharedInstance.initialized ? Yelp.sharedInstance.APIKeys[YelpAuthTokenType.TokenSecret]! : nil
        }
    }
    
    // Singleton definition
    
    private static var sharedInstance = Yelp()
    
    private init() {}
    
    /**
     Initializes the Yelp framework with Yelp [API v2.0 keys](https://www.yelp.com/developers/manage_api_keys) defined in method parameter list.
     
     After the first successful initialization the framework will expose all four API keys as read-only attribues, however any further initialization attempts will be ignored.
     
     - parameter consumerKey:    Consumer Key as defined in [Yelp API v2.0](https://www.yelp.com/developers/manage_api_keys)
     - parameter consumerSecret: Consumer Secret as defined in [Yelp API v2.0](https://www.yelp.com/developers/manage_api_keys)
     - parameter token:          Token as defined in [Yelp API v2.0](https://www.yelp.com/developers/manage_api_keys)
     - parameter tokenSecret:    Token Secret as defined in [Yelp API v2.0](https://www.yelp.com/developers/manage_api_keys)
     */
    public static func initializeWithConsumerKey(consumerKey: String, consumerSecret: String, token: String, tokenSecret: String) {
        
        guard !Yelp.sharedInstance.initialized else { return }
        
        Yelp.sharedInstance.APIKeys[YelpAuthTokenType.ConsumerKey]     = consumerKey
        Yelp.sharedInstance.APIKeys[YelpAuthTokenType.ConsumerSecret]  = consumerSecret
        Yelp.sharedInstance.APIKeys[YelpAuthTokenType.Token]           = token
        Yelp.sharedInstance.APIKeys[YelpAuthTokenType.TokenSecret]     = tokenSecret
        
        Yelp.sharedInstance.initialized = true
    }
    
    /**
     Required for unit testing to tear down the singleton.
     
     Not for public use.
     */
    static func deinitialize() {
        
        guard Yelp.sharedInstance.initialized else { return }
        
        sharedInstance = Yelp()
    }
}