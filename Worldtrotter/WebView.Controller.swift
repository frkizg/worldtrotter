//
//  WebView.swift
//  Worldtrotter
//
//  Created by Zvonimir Grebenar on 16.05.2016..
//  Copyright © 2016. Zvonimir Grebenar. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    
    @IBOutlet weak var webView: UIWebView!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let url = NSURL (string: "https://www.bignerdranch.com");
        let myNSURLRequest = NSURLRequest(URL: url!);
        webView.loadRequest(myNSURLRequest);
    }
    
}