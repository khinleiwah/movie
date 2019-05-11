//
//  ShopBackTests.swift
//  ShopBackTests
//
//  Created by Win on 10/5/19.
//  Copyright © 2019 Win. All rights reserved.
//

import XCTest
@testable import ShopBack

class ShopBackTests: XCTestCase {
    
    var homeVC: HomeTableViewController!
    var detailVC: DetailViewController!
    var nav: UINavigationController!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        nav = (storyboard.instantiateInitialViewController() as? UINavigationController)
        homeVC = nav.viewControllers.first as? HomeTableViewController

        detailVC = storyboard.instantiateViewController(withIdentifier: "detailVC") as? DetailViewController
        
        UIApplication.shared.keyWindow!.rootViewController = nav
        
        XCTAssertNotNil(homeVC.tableView)
    }
    
    func testElement() {
        //1 Arrange
      homeVC.movieList = [Results.init(vote_count: 1, id: 1, video: false, vote_average: 12.5, title: "Testing", popularity: 4.6, poster_path: "/lubzBMQLLmG88CLQ4F3TxZr2Q7N.jpg", original_language: "en", original_title: "The Secret Life of Pets", genre_ids: [12], backdrop_path:"/lubzBMQLLmG88CLQ4F3TxZr2Q7N.jpg" , adult: false, overview: "The quiet life of a terrier named Max is upended when his owner takes in Duke, a stray whom Max instantly dislikes.", release_date: "2016-06-18")]
        
      homeVC.tableView.reloadData()
    
      let cells = homeVC.tableView.visibleCells as! [HomeTableViewCell]
      XCTAssertEqual(cells.count, homeVC.movieList.count, "Cells count should match array.count")
      XCTAssertGreaterThan(cells.count, 0, "Greater than zero")
     
     let movie = MovieDetailResponse.init(adult: false, backdrop_path: "/lubzBMQLLmG88CLQ4F3TxZr2Q7N.jpg", budget: 75000000, genres: [Genres.init(id: 12,name: "Adventure")], id: 328111, imdb_id: "tt2709768", original_language: "en", original_title: "The Secret Life of Pets", overview: "The quiet life of a terrier named Max is upended when his owner takes in Duke, a stray whom Max instantly dislikes.", popularity: 7.458, poster_path:  "/WLQN5aiQG8wc9SeKwixW7pAR8K.jpg", production_countries: [], release_date: "2016-06-18", revenue: 875457937, runtime: 87, spoken_languages: [spoken_languages.init(iso_639_1:  "en", name: "English")], status: "Released", tagline: "Think this is what they do all day?", title: "The Secret Life of Pets", video: false, vote_average: 6, vote_count: 5284)
        
        detailVC.detail = movie
        
        detailVC.loadView()
        detailVC.setupUI()

        XCTAssertEqual(detailVC.synopsisLabel.text,movie.overview)
        XCTAssertEqual(detailVC.titleLabel.text,movie.title)
        XCTAssertEqual(detailVC.genreLabel.text,(movie.genres?.map({$0.name!}))!.joined(separator: ","))
        XCTAssertEqual(detailVC.languageLabel.text,(movie.spoken_languages?.map({$0.name!}))!.joined(separator: ","))
        XCTAssertEqual(detailVC.durationLabel.text, movie.runtime?.description)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
