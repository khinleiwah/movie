//
//  DetailViewController.swift
//  ShopBack
//
//  Created by Win on 10/5/19.
//  Copyright © 2019 Win. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var synopsisLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    
    var detail:MovieDetailResponse!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupUI()
        self.setAccessibility()
    }
    
    func setAccessibility() {
        self.titleLabel.accessibilityIdentifier = "title"
        self.synopsisLabel.accessibilityIdentifier = "synopsis"
        self.genreLabel.accessibilityIdentifier = "genre"
        self.languageLabel.accessibilityIdentifier = "language"
        self.durationLabel.accessibilityIdentifier = "duration"
    }
    
    func setupUI() {
        self.titleLabel.text = detail.title
     
        if let posterPath = detail.poster_path {
            let imageUrl = URL(string: Constants.domainName + posterPath)

            self.imgView.downloadedFrom(url: imageUrl!, contentMode: .scaleToFill)
        }
        else
            if let backdropPath = detail.backdrop_path{
            let imageUrl = URL(string: Constants.domainName + backdropPath)

            self.imgView.downloadedFrom(url: imageUrl!, contentMode: .scaleAspectFit)
        }
        
        self.synopsisLabel.text = detail.overview
        self.genreLabel.text = (detail.genres?.map({$0.name!}))!.joined(separator: ",")
        self.languageLabel.text = (detail.spoken_languages?.map({$0.name!}))!.joined(separator: ",")
        self.durationLabel.text = detail.runtime?.description
    }
    
    @IBAction func bookingClick(_ sender: Any) {
    }

    /*
     
     // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
