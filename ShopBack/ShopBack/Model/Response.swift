//
//  APIObject.swift
//  ShopBack
//
//  Created by Win on 10/5/19.
//  Copyright © 2019 Win. All rights reserved.
//

import UIKit




struct ResponseJson:Codable {
    var page: Int
    var total_results: Int
    var total_pages:  Int
    var results:  [Results]?
   
    enum CodingKeys: String, CodingKey {
        case page
        case total_results
        case total_pages
        case results
    }
}

struct Results {
    var vote_count: Int?
    var id: Int?
    var video: Bool?
    var vote_average: Float?
    var title: String?
    var popularity: Float?
    var poster_path: String?
    var original_language: String?
    var original_title: String?
    var genre_ids: [Int]?
    var backdrop_path: String?
    var adult: Bool?
    var overview: String?
    var release_date: String?
    
    enum CodingKeys: String, CodingKey {
        case vote_count
        case id
        case video
        case vote_average
        case title
        case popularity
        case poster_path
        case original_language
        case original_title
        case genre_ids
        case backdrop_path
        case adult
        case overview
        case release_date
    }
}

extension Results: Encodable {
    func encode(to encoder: Encoder) throws {
        
    }
}

extension Results: Decodable {
    init(from decoder: Decoder) throws {
       
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        vote_count = try values.decodeIfPresent(Int.self, forKey: .vote_count)
        print("vote count \(String(describing: vote_count))")
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        print("id \(String(describing: id))")
        video = try values.decodeIfPresent(Bool.self, forKey: .video)
        print("video \(String(describing: video))")
        vote_average = try values.decodeIfPresent(Float.self, forKey: .vote_average)
        print("vote_average \(String(describing: vote_average))")
        title = try values.decodeIfPresent(String.self, forKey: .title)
        print("title \(String(describing: title))")
        popularity = try values.decode(Float.self, forKey: .popularity)
        print("popularity \(String(describing: popularity))")
        poster_path = try values.decodeIfPresent(String.self, forKey: .poster_path)
        print("poster_path \(String(describing: poster_path))")
        original_language = try values.decodeIfPresent(String.self, forKey: .original_language)
        print("original_language \(String(describing: original_language))")
        original_title = try values.decodeIfPresent(String.self, forKey: .original_title)
        print("original_title \(String(describing: original_title))")
        genre_ids = try values.decodeIfPresent([Int].self, forKey: .genre_ids)
        print("genre_ids \(String(describing: genre_ids))")
        backdrop_path = try values.decodeIfPresent(String.self, forKey: .backdrop_path)
        print("backdrop_path \(String(describing: backdrop_path))")
        adult = try values.decodeIfPresent(Bool.self, forKey: .adult)
        print("adult \(String(describing: adult))")
        overview = try values.decodeIfPresent(String.self, forKey: .overview)
        print("overview \(String(describing: overview))")
        release_date = try values.decodeIfPresent(String.self, forKey: .release_date)
        print("release_date \(String(describing: release_date))")
    }
}

struct spoken_languages: Codable {
    var iso_639_1: String?
    var name: String?
}

struct ProductionCompany : Codable {
    var id: Int?
    var logo_path: String?
    var name: String?
    var origin_country: String?
}

struct MovieDetailResponse: Codable {
    var adult: Bool?
    var backdrop_path: String?
    //var belongs_to_collection:
    var budget: Int?
    var genres:[Genres]?
    //var homepage:
    var id: Int?
    var imdb_id: String?
    var original_language: String?
    var original_title: String?
    var overview: String?
    var popularity: Float?
    var poster_path: String?
    var production_countries: [ProductionCompany]?
    var release_date: String?
    var revenue: Int?
    var runtime: Int?
    var spoken_languages: [spoken_languages]?
    var status: String?
    var tagline: String?
    var title: String?
    var video: Bool?
    var vote_average: Int?
    var vote_count: Int?
}

struct Genres : Codable {
    var id: Int?
    var name: String?
}


