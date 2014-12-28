//
//  WebViewController.swift
//  SwiftGistExample
//
//  Created by 5t111111 on 2014/06/15.
//  Copyright (c) 2014 5t111111. All rights reserved.
//

import UIKit

class WebViewController: UIViewController, UIWebViewDelegate {
    
    @IBOutlet weak var gistWebView: UIWebView!
    
    var gistURL: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.gistWebView.frame = self.view.bounds
        self.gistWebView.delegate = self;
        self.view.addSubview(self.gistWebView)
        
        println(gistURL)
        var url: NSURL = NSURL(string: gistURL)!
        var urlRequest: NSURLRequest = NSURLRequest(URL: url)
        self.gistWebView.loadRequest(urlRequest)
    }
    
    func webView(webView: UIWebView!, shouldStartLoadWithRequest request: NSURLRequest!,
        navigationType: UIWebViewNavigationType) -> Bool {
            return true
    }
}
