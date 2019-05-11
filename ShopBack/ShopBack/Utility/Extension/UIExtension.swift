//
//  UIExtension.swift
//  ShopBack
//
//  Created by Win on 10/5/19.
//  Copyright © 2019 Win. All rights reserved.
//

import UIKit

extension UIImageView {
    func downloadedFrom(url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFill) {
        DispatchQueue.global(qos: .background).async {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
                DispatchQueue.main.async() { () -> Void in
                    self.contentMode = mode
                    
                    self.image = image
                }
            }.resume()
        }
    }
  
}
