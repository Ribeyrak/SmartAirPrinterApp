//
//  WebVC.swift
//  SmartAirPrinterApp
//
//  Created by Evhen Lukhtan on 03.07.2023.
//

import UIKit
import WebKit

class WebVC: UIViewController, WKUIDelegate {
    private var webView: WKWebView!
    var link = "https://www.google.com/"
    
    //MARK: - Lifecycle
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        webView.allowsBackForwardNavigationGestures = true
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myURL = URL(string: link)
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
        
        let printButton = UIBarButtonItem(title: "Print", style: .plain, target: self, action: #selector(printButtonTapped))
        navigationItem.rightBarButtonItem = printButton
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    //MARK: Methods
    @objc private func printButtonTapped() {
        printPage()
    }
    
    func printPage() {
        let printController = UIPrintInteractionController.shared
        printController.delegate = self
        
        let printInfo = UIPrintInfo.printInfo()
        printInfo.jobName = "Web Page"
        printController.printInfo = printInfo
        printController.printFormatter = webView.viewPrintFormatter()
        
        DispatchQueue.main.async {
            printController.present(animated: true, completionHandler: nil)
        }
    }
}

// MARK: - WKNavigationDelegate
extension WebVC: UIPrintInteractionControllerDelegate {
    func printInteractionControllerDidFinishJob(_ printInteractionController: UIPrintInteractionController) {
        // Печать завершена
        navigationController?.popViewController(animated: true)
    }
}
