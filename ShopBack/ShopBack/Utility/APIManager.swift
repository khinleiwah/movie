//
//  APIManager.swift
//  ShopBack
//
//  Created by Win on 10/5/19.
//  Copyright © 2019 Win. All rights reserved.
//

import UIKit

typealias completionBlock = ([Results]?,Error?) -> ()
typealias detailCompletionBlock = (MovieDetailResponse?, Error?) -> ()

class APIManager: NSObject {
    static let shared = APIManager()
    let session = URLSession.shared
    
    func loadMovies(pageIndex:String, completion: @escaping completionBlock) {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let self = self else {
                return
            }
            let urlString = String.init(format: Constants.apiURL,pageIndex)
            print("urlString \(urlString)")
            self.session.dataTask(with: URL(string: urlString)!) { (data, response, error) in
                print("data \(String(describing: data))")

                do {
                    guard let json = try? JSONDecoder().decode(ResponseJson.self, from: data!) else {
                        print("cannot decode")
                
                        let alert = UIAlertController.init(title: "Alert", message: "Please retry the loading", preferredStyle: .alert)
                        alert.addAction(UIAlertAction.init(title: "OK", style: .default, handler: { (action) in
                            completion(nil,error)
                        }))
                        
                        let appDelegate = UIApplication.shared.delegate as! AppDelegate
                        appDelegate.window!.rootViewController!.present(alert, animated: true, completion: nil)
                        
                        return
                    }
                    if let movies = json.results {
                        completion(movies,nil)
                    }
                } catch {
                    print("error \(error.localizedDescription)")
                }
            }.resume()
        }
    }
    
    
    func loadMovieDetail(movieId:String, completion: @escaping detailCompletionBlock) {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let self = self else {
                return
            }
            let urlString = String.init(format: Constants.movieDetailURL,movieId)
            print("urlString \(urlString)")
            self.session.dataTask(with: URL(string: urlString)!) { (data, response, error) in
                print("data \(String(describing: data))")
                
                do {
                    guard let detail = try? JSONDecoder().decode(MovieDetailResponse.self, from: data!) else {
                        print("cannot decode")
                        DispatchQueue.main.async {
                            let alert = UIAlertController.init(title: "Alert", message: "Cannot watch this movie.", preferredStyle: .alert)
                            alert.addAction(UIAlertAction.init(title: "OK", style: .default, handler: { (action) in
                                completion(nil,error)
                            }))
                            
                            let appDelegate = UIApplication.shared.delegate as! AppDelegate
                            appDelegate.window!.rootViewController!.present(alert, animated: true, completion: nil)
                        }
                        return
                    }
                   
                    completion(detail,nil)
                    
                } catch {
                    print("error \(error.localizedDescription)")
                }
            }.resume()
        }
    }
    
}
