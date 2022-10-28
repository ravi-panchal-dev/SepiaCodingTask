//
//  PetDetailViewController.swift
//  Sepia Test
//
//  Created by iOS on 28/10/22.
//

import UIKit
import WebKit

class PetDetailViewController: UIViewController {
    
    @IBOutlet weak var webView              : WKWebView!
    @IBOutlet weak var activityIndicator    : UIActivityIndicatorView!
    
    var wikiURL : String = ""
    var petName : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = self.petName
        self.loadDataFromURL()
    }

    private func loadDataFromURL(){
        webView.navigationDelegate = self
        webView.load(URLRequest(url: URL(string:wikiURL)!))
    }
    
    private func isLoading(show:Bool){
        activityIndicator.isHidden = !show
        if show{
            activityIndicator.startAnimating()
        }else{
            activityIndicator.stopAnimating()
        }
    }
}

// MARK: WebView Delegate Methods

extension PetDetailViewController: WKNavigationDelegate {
    
    //Equivalent of webViewDidStartLoad:
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        isLoading(show: true)
    }

    //Equivalent of didFailLoadWithError:
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        let nserror = error as NSError
        if nserror.code != NSURLErrorCancelled {
            isLoading(show: true)
            webView.loadHTMLString("Page Not Found", baseURL: URL(string: "https://developer.apple.com/"))
        }
    }

    //Equivalent of webViewDidFinishLoad:
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        isLoading(show: false)
    }
    
}
