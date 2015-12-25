//
//  YelpReachability.swift
//  Yelp
//
//  Created by Norbert Metz on 25/12/2015.
//  Copyright © 2015 Norbert Metz. All rights reserved.
//

import SystemConfiguration

class Reachability {

    enum ConnectionType {
        
        case None
        case Cellular
        case WiFi
        
    }
    
    private let URL: String!
    
    init(URL: String) {
        self.URL = URL
    }
    
    func networkConnectionType() -> ConnectionType {
        
        let networkReachability = SCNetworkReachabilityCreateWithName(kCFAllocatorSystemDefault, URL)
        
        var flags = SCNetworkReachabilityFlags()
        
        SCNetworkReachabilityGetFlags(networkReachability!, &flags)
        
        let reachable = (flags.rawValue & SCNetworkReachabilityFlags.Reachable.rawValue) != 0
        
        let connectionRequired = (flags.rawValue & SCNetworkReachabilityFlags.ConnectionRequired.rawValue) != 0
        
        if reachable && !connectionRequired {
            let isCellularConnection = (flags.rawValue & SCNetworkReachabilityFlags.IsWWAN.rawValue) != 0
            
            if isCellularConnection {
                return .Cellular
            } else {
                return .WiFi
            }
        }
        
        return .None
    }
}
