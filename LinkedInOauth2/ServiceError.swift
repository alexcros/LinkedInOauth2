//
//  ServiceError.swift
//  LinkedInOauth2
//
//  Enum of http errors
//
//  Created by Alex Cros on 25/2/17.
//  Copyright © 2017 Alex Cros. All rights reserved.
//

import Foundation

enum ServiceError: Error {
    case notFound
    case invalidRequest
    case unprocessableEntity(NSDictionary?)
    case notAllowed
    case notLogged(String?)
    case unprocessableError(String?)
    case badRequest
    case unknownError(Error?)
    case noConnection
}
