//
//  WebViewController.swift
//  SmartAirPrinterApp
//
//  Created by Evhen Lukhtan on 03.07.2023.
//

import UIKit
import WebKit


class WebViewController: UIViewController, WKNavigationDelegate, WKUIDelegate {

    private let urlString: String
    var wView: WKWebView!
    
    init(urlString: String) {
        self.urlString = urlString
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        wView = WKWebView(frame: .zero, configuration: webConfiguration)
        wView.uiDelegate = self
        wView.allowsBackForwardNavigationGestures = true
        view = wView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let myURL = URL(string: urlString)
        let myRequest = URLRequest(url: myURL!)
        wView.load(myRequest)
    }
}

