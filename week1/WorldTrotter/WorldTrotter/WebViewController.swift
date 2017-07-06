//
//  WebViewController.swift
//  WorldTrotter
//
//  Created by 오민호 on 2017. 7. 4..
//  Copyright © 2017년 BoostCamp. All rights reserved.
//

import UIKit
import WebKit

class WebViewController : UIViewController, WKNavigationDelegate, WKUIDelegate {
    var webView : WKWebView!
    let startPageUrl = URL(string: "https://m.naver.com")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView = WKWebView(frame: view.bounds)
        webView.navigationDelegate = self
        webView.uiDelegate = self
        
        webView.load(URLRequest(url: startPageUrl!))
        
        view.addSubview(webView)
        
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 8).isActive = true
        webView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        webView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
    }
}
