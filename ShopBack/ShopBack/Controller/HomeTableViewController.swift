//
//  HomeTableViewController.swift
//  ShopBack
//
//  Created by Win on 10/5/19.
//  Copyright © 2019 Win. All rights reserved.
//

import UIKit
import KRPullLoader


class HomeTableViewController: UITableViewController {
 
    private var pageIndex = 1
    var movieList = [Results]()
    var selectedMovie = MovieDetailResponse()
    
    let loadMoreView = KRPullLoadView()
    let pullToRefreshView = KRPullLoadView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.loadMovies()

        //KVNProgress.
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        
        loadMoreView.delegate = self
        tableView.addPullLoadableView(loadMoreView, type: .loadMore)
        
        pullToRefreshView.delegate = self
        tableView.addPullLoadableView(pullToRefreshView, type: .refresh)
    }

    deinit{
        tableView.removePullLoadableView(self.pullToRefreshView)
        tableView.removePullLoadableView(self.loadMoreView)
    }
    
    func loadMovies() {
        APIManager.shared.loadMovies(pageIndex: String(self.pageIndex)) { (data, error) in
            if let movies = data {
                print(movies)
                self.movieList.append(contentsOf: movies)
                
                DispatchQueue.main.async { [weak self] in
                    self!.tableView.reloadData()
                }
            }
        }
    }
    
    func loadMovieDetail(byId: String,finishLoading:@escaping (Bool)->()) {
        APIManager.shared.loadMovieDetail(movieId: byId) { (detail, error) in
            if let movieDeail = detail {
                print(movieDeail)
                self.selectedMovie = movieDeail
                
                finishLoading(true)
            }
            else {
                finishLoading(false)
            }
        }
    }
    
    // MARK: - Table view data source
    func movies(for indexPath: IndexPath) -> Results {
        return self.movieList[indexPath.row]
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.movieList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Identifier.homeCell, for: indexPath) as! HomeTableViewCell
        
        // Configure the cell...
        let movie = self.movies(for: indexPath)
        cell.titleLabel.text = movie.title
        cell.titleLabel.accessibilityIdentifier = "title"
        cell.popularityLabel.text = movie.popularity?.description
        cell.popularityLabel.accessibilityIdentifier = "popularity"

        if let posterPath = movie.poster_path {
            let imageURL = URL(string: Constants.domainName + posterPath)
            cell.imgView.downloadedFrom(url: imageURL!)
        }
        else if let backdropPath = movie.backdrop_path{
            let imageURL = URL(string: Constants.domainName + backdropPath)
            cell.imgView.downloadedFrom(url: imageURL!)
        }
        
        cell.imgView.accessibilityIdentifier = "image"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = self.movies(for: indexPath)

        self.loadMovieDetail(byId: (movie.id?.description)!) { (isCompleted) in
            if(isCompleted) {
                DispatchQueue.main.async { [weak self] in
                    self?.performSegue(withIdentifier: "detailSegue", sender: self)
                }
            }
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! DetailViewController
        vc.detail = self.selectedMovie
    }
}

extension HomeTableViewController: KRPullLoadViewDelegate {
    func pullLoadView(_ pullLoadView: KRPullLoadView, didChangeState state: KRPullLoaderState, viewType type: KRPullLoaderType) {
        if type == .loadMore {
            switch state {
            case let .loading(completionHandler):
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+1) {
                    completionHandler()
                    self.pageIndex += 1
                    self.loadMovies()
                    self.tableView.reloadData()
                }
            default: break
            }
            return
        }
        
        switch state {
        case .none:
            pullLoadView.messageLabel.text = ""
            
        case let .pulling(offset, threshould):
            if offset.y > threshould {
                pullLoadView.messageLabel.text = "Pull more..."
            } else {
                pullLoadView.messageLabel.text = "Release to refresh.."
            }
            
        case let .loading(completionHandler):
            pullLoadView.messageLabel.text = "Updating..."
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+1) {
                completionHandler()
                self.pageIndex += 1
                self.loadMovies()
                self.tableView.reloadData()
            }
        }
    }
}
