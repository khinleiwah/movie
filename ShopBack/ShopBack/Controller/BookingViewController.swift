//
//  BookingViewController.swift
//  ShopBack
//
//  Created by Win on 11/5/19.
//  Copyright © 2019 Win. All rights reserved.
//

import UIKit
import WebKit

class BookingViewController: UIViewController,WKNavigationDelegate {

    @IBOutlet weak var webView: WKWebView!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "BOOKING"
        
        // Do any additional setup after loading the view.
        let request = URLRequest.init(url: URL(string:Constants.webViewLink)!)
        self.webView.accessibilityIdentifier = "webViewId"//AccessibilityIdentifier.webView.rawValue
        
        self.webView.navigationDelegate = self
        self.webView.load(request)
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
