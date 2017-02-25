//
//  User.swift
//  LinkedInOauth2
//
//  Created by Alex Cros on 25/2/17.
//  Copyright © 2017 Alex Cros. All rights reserved.
//

import Foundation

class User {
    // MARK: - Public API
    var id: String = ""
    var name: String = ""
    var email: String = ""
    var photo: String = ""
    var company: String = ""
    var position: String = ""
    var token: String = ""
    var url: String = ""

    // Custom Initializer for User Object
    init?(data: JSONDictionary) {
        guard let data =  data["data"] as? JSONDictionary,
            let user = data["user"] as? JSONDictionary,
            let id: String = user["provider_id"] as? String,
            let name: String = user["name"] as? String,
            let email: String = user["email"] as? String,
            let photo: String = user["photo"] as? String,
            let company: String = user["company"] as? String,
            let position: String = user["function"] as? String,
            let token: String = user["token"] as? String,
            let url: String = user["url"] as? String else {
                print("error setting json data to user")
                return
        }
        self.id = id
        self.name = name
        self.email = email
        self.photo = photo
        self.company = company
        self.position = position
        self.token = token
        self.url = url
    }
}
