//
//  Detail.swift
//  ShopBack
//
//  Created by Win on 10/5/19.
//  Copyright © 2019 Win. All rights reserved.
//

import UIKit

class MovieDetail: NSObject {
    var title: String!
    var imgPath: String!
    var synopsis: String!
    var genre: String!
    var language: String!
    var duration: String!
    
    override init() {
        super.init()
    }
    
    init(title:String, imgPath:String, synopsis:String, genre:String, language: String, duration:String) {
        self.title = title
        self.imgPath = imgPath
        self.synopsis = synopsis
        self.genre = genre
        self.language = language
        self.duration = duration
    }
}
