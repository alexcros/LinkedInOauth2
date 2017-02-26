//
//  AuthManager.swift
//  LinkedInOauth2
//
//  Manages user auth services
//
//  Created by Alex Cros on 26/2/17.
//  Copyright © 2017 Alex Cros. All rights reserved.
//
import Foundation
import PromiseKit

class AuthManager {
    let api = APIManager()
    let defaults = UserDefaults.standard

    func login(_ code: String, state: String) ->  Promise<User> {
        let params = "?code=" + code + "&state=" + state
        return Promise { fulfill, reject in
            api.call(APIValidMethods.get, urlString: "oauth/login" + params, params: nil)
                .then { response -> Void in

                    self.getToken(response)

                    let user = User(data: response)
                    fulfill(user!)
                }.catch {
                    (error: Error) -> Void in
                    reject(error)
            }
        }
    }

    func setToken(_ token: String) {
        defaults.setValue(token, forKey: "token")
    }

    func getToken(_ object: JSONDictionary) -> Void {
        guard let data = object["data"] as? JSONDictionary else {
            print("no data from user")
            return
        }
        guard let token = data["token"] as? String  else {
            print("no token from user")
            return
        }
        self.setToken(token)
    }
}
