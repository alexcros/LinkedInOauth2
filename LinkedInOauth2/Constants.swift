//
//  Constants.swift
//  LinkedInOauth2
//
//  Created by Alex Cros on 25/2/17.
//  Copyright © 2017 Alex Cros. All rights reserved.
//

import Foundation

typealias JSONDictionary = [String : Any]

struct Api {
    static let url = "INSERT API URL"

    struct Auth {
        static let login = "INSERT LOGIN ENDPOINT"
    }
    struct User {
        static let me = "me"
        static let login = "login"
        static let signup = "register"
        static let edit = "users/"
    }
}

struct Linkedin {
    // hardcoded values. This values has to come from the API response.. not here :)
    static let clientId = "LINKEDIN CLIENT ID"
    static let secretId = "LINKEDIN SECRET ID"
}
