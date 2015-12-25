//
//  YelpBusiness.swift
//  ImportTestApp
//
//  Created by Norbert Metz on 13/12/2015.
//  Copyright © 2015 Norbert Metz. All rights reserved.
//

import Foundation
import SwiftyJSON

public class YelpBusiness: CustomStringConvertible {
    
    private var json: JSON
    
    /// [Yelp API 2.0](https://www.yelp.com/developers/documentation/v2/business) reference: `id`
    ///
    /// Yelp ID for this business
    public var id: String? {
        return json["id"].string
    }
    
    /// [Yelp API 2.0](https://www.yelp.com/developers/documentation/v2/business) reference: `is_claimed`
    ///
    /// Whether business has been claimed by a business owner
    public var isClaimed: Bool? {
        return json["is_claimed"].bool
    }
    
    /// [Yelp API 2.0](https://www.yelp.com/developers/documentation/v2/business) reference: `is_closed`
    ///
    /// Whether business has been (permanently) closed
    public var isClosed: Bool? {
        return json["is_closed"].bool
    }
    
    /// [Yelp API 2.0](https://www.yelp.com/developers/documentation/v2/business) reference: `name`
    ///
    /// Name of this business
    public var name: String? {
        return json["name"].string
    }
    
    /// [Yelp API 2.0](https://www.yelp.com/developers/documentation/v2/business) reference: `image_url`
    ///
    /// URL of photo for this business
    public var imageURL: String? {
        return json["image_url"].string
    }
    
    /// [Yelp API 2.0](https://www.yelp.com/developers/documentation/v2/business) reference: `url`
    ///
    /// URL for business page on Yelp
    public var URL: String? {
        return json["url"].string
    }
    
    /// [Yelp API 2.0](https://www.yelp.com/developers/documentation/v2/business) reference: `mobile_url`
    ///
    /// URL for mobile business page on Yelp
    public var mobileURL: String? {
        return json["mobile_url"].string
    }
    
    /// [Yelp API 2.0](https://www.yelp.com/developers/documentation/v2/business) reference: `phone`
    ///
    /// Phone number for this business with international dialing code (e.g. +442079460000)
    public var phone: String? {
        return json["phone"].string
    }
    
    /// [Yelp API 2.0](https://www.yelp.com/developers/documentation/v2/business) reference: `display_phone`
    ///
    /// Phone number for this business formatted for display
    public var displayPhone: String? {
        return json["display_phone"].string
    }
    
    /// [Yelp API 2.0](https://www.yelp.com/developers/documentation/v2/business) reference: `review_count`
    ///
    /// Number of reviews for this business
    public var reviewCount: NSNumber? {
        return json["review_count"].number
    }
    
    /// [Yelp API 2.0](https://www.yelp.com/developers/documentation/v2/business) reference: `categories`
    ///
    /// Provides a list of category name, alias pairs that this business is associated with. For example, `[["Local Flavor", "localflavor"], ["Active Life", "active"], ["Mass Media", "massmedia"]]`
    /// The alias is provided so you can search with the `category_filter`.
    public var categories: [String: String]? {
        return json["categories"].dictionaryObject as? [String: String]
    }
    
    /// [Yelp API 2.0](https://www.yelp.com/developers/documentation/v2/business) reference: `distance`
    ///
    /// Distance that business is from search location in meters, if a latitude/longitude is specified.
    public var distance: NSNumber? {
        return json["distance"].number
    }
    
    /// [Yelp API 2.0](https://www.yelp.com/developers/documentation/v2/business) reference: `rating`
    ///
    /// Rating for this business (value ranges from 1, 1.5, ... 4.5, 5)
    public var rating: NSNumber? {
        return json["rating"].number
    }
    
    /// [Yelp API 2.0](https://www.yelp.com/developers/documentation/v2/business) reference: `rating_img_url`
    ///
    /// URL to star rating image for this business (size = 84x17)
    public var ratingImageURL: String? {
        return json["rating_img_url"].string
    }
    
    /// [Yelp API 2.0](https://www.yelp.com/developers/documentation/v2/business) reference: `rating_img_url_small`
    ///
    /// URL to small version of rating image for this business (size = 50x10)
    public var ratingImageURLSmall: String? {
        return json["rating_img_url_small"].string
    }
    
    /// [Yelp API 2.0](https://www.yelp.com/developers/documentation/v2/business) reference: `rating_img_url_large`
    ///
    /// URL to large version of rating image for this business (size = 166x30)
    public var ratingImageURLLarge: String? {
        return json["rating_img_url_large"].string
    }
    
    /// [Yelp API 2.0](https://www.yelp.com/developers/documentation/v2/business) reference: `snippet_text`
    ///
    /// Snippet text associated with this business
    public var snippetText: String? {
        return json["snippet_text"].string
    }
    
    /// [Yelp API 2.0](https://www.yelp.com/developers/documentation/v2/business) reference: `snippet_image_url`
    ///
    /// URL of snippet image associated with this business
    public var snippetImageURL: String? {
        return json["snippet_image_url"].string
    }
    
    public var description: String {
        return json.description
    }
    
    public init(json: JSON) {
        self.json = json
    }
}