//
//  LinkedinWebViewController.swift
//  LinkedInOauth2
//
//  Created by Alex Cros on 25/2/17.
//  Copyright © 2017 Alex Cros. All rights reserved.
//

import UIKit

class LinkedinWebViewController: UIViewController, UIWebViewDelegate {
    // MARK: - IBOutlets
    @IBOutlet weak var linkedinWebView: UIWebView!

    let api = APIManager()
    var defaults = UserDefaults.standard
    var user: User?

    override func viewDidLoad() {
        super.viewDidLoad()
        linkedinWebView.delegate = self
        startAuthorization()
    }

    func startAuthorization() {
        let oauthLogin = Api.Auth.login

        // Create a URL request and load it in the web view.
        let authorizationURL = "https://www.linkedin.com/oauth/v2/authorization?response_type=code&client_id=\(Linkedin.clientId)&redirect_uri=\(oauthLogin)&state=MTM&scope=r_basicprofile,r_emailaddress"
        let request = URLRequest(url: URL(string: authorizationURL)!)
        linkedinWebView.loadRequest(request)
    }

    // MARK: UIWebViewDelegate
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        let url = request.url!

        if url.host == "example.com" { // redirection API url
            //TODO: - set activity indicator loader!

            let urlString: String = url.absoluteString
            if let code = urlString.getQueryStringParameter(url: urlString, param: "code") ,
                let state = urlString.getQueryStringParameter(url: urlString, param: "state") {
                let authManager = AuthManager()
                // loading

                authManager.login(code, state: state)
                    .then { (loadLinkedinUser: User) -> Void in

                        //TODO: - end activity load indicator
                        print("login succesful!")
                    }.catch { error in
                        print(error)
                }

                // stop webview
                return false
            }
        }
        // show webview
        return true
    }
}
