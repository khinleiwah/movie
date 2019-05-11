//
//  Constants.swift
//  ShopBack
//
//  Created by Win on 10/5/19.
//  Copyright © 2019 Win. All rights reserved.
//

import UIKit

class Constants: NSObject {
    
    static let domainName = "https://image.tmdb.org/t/p/w500"
    static let apiURL = "http://api.themoviedb.org/3/discover/movie?api_key=328c283cd27bd1877d9080ccb1604c91&primary_release_date.lte=2016-12-31&sort_by=release_date.desc&page=%@"
    static let movieDetailURL = "http://api.themoviedb.org/3/movie/%@?api_key=328c283cd27bd1877d9080ccb1604c91"
    
    static let webViewLink = "https://www.cathaycineplexes.com.sg"
    struct Date {
        static let API_DATE_FORMAT: String = "yyyy-MM-dd'T'HH:mm:ssZ"
        static let DATE_FORMAT : String = "dd-MMM-yyyy"
        static let DATETIME_FORMAT : String = "dd-MMM-yyyy HH:mm:ss"
    }
    
    struct Identifier {
        static let homeCell = "homeCell"
    }
    
    struct StoryboardID {
        static let detailId = "detailVC"
    }
}
