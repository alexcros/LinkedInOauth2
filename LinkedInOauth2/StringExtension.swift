//
//  StringExtension.swift
//  LinkedInOauth2
//
//  Created by Alex Cros on 26/2/17.
//  Copyright © 2017 Alex Cros. All rights reserved.
//
import Foundation

extension String {
    // get code and state of linkedin response
    func getQueryStringParameter(url: String?, param: String) -> String? {
        if let url = url, let urlComponents = URLComponents(string: url), let queryItems = (urlComponents.queryItems) {
            return queryItems.filter({ (item) in item.name == param }).first?.value!
        }
        return nil
    }
}
