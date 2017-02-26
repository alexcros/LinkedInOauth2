//
//  APIManager.swift
//  LinkedInOauth2
//
//  Manage all service requests
//
//  Created by Alex Cros on 25/2/17.
//  Copyright © 2017 Alex Cros. All rights reserved.
//

import Foundation
import PromiseKit

class APIManager {

    let defaults = UserDefaults.standard

    func call(_ method: APIValidMethods, urlString: String, params: String?) -> Promise<JSONDictionary> {
        guard let url = URL(string: Api.url + urlString) else {
            return Promise { fulfill, reject in
                reject(ServiceError.invalidRequest)
            }
        }
        var request = URLRequest( url: url)
        // Auth
        let token: String = (defaults.string(forKey: "token") != nil) ? defaults.string(forKey: "token")! : ""
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        let session = URLSession(configuration:URLSessionConfiguration.default, delegate: nil, delegateQueue: nil)

        return Promise { fulfill, reject in
            let dataTask = session.dataTask(with: request, completionHandler: {
                (data: Data?, response: URLResponse?, error: Error?) in

                if error != nil {
                    reject(error!)
                } else {
                    guard let data = data else {reject(ServiceError.invalidRequest); return}
                    let responseData = (try? JSONSerialization.jsonObject(with: data, options: [])) as? [String: Any]
                    guard let httpResponse = response as? HTTPURLResponse else {reject(ServiceError.invalidRequest); return}
                    print(urlString, httpResponse.statusCode)
                    switch httpResponse.statusCode {
                    case 200...202:
                        fulfill(responseData! as JSONDictionary)
                        break
                    case 404:
                        reject(ServiceError.notFound)
                        break
                    case 401:
                        if let message = responseData?["message"] as? String {
                            reject(ServiceError.notLogged(message))
                        }
                        break
                    case 403: reject(ServiceError.notAllowed)
                        break
                    case 422:
                        guard let errors = responseData?["errors"] as? Dictionary<String, Any> else {
                            // If there's no array of errors, we try to get the current response message
                            guard let errorMessage = responseData?["message"] else {
                                // If no message, unprocessable error
                                reject(ServiceError.unprocessableError(nil))
                                return
                            }
                            reject(ServiceError.unprocessableEntity(["message" : [errorMessage]]))
                            return
                        }
                        print(errors)
                        reject(ServiceError.unprocessableEntity(errors as NSDictionary?))
                        break
                    case 500...599:
                        reject(ServiceError.unprocessableError(nil))
                        break
                    default:
                        print("Received HTTP \(httpResponse.statusCode), which was not handled")
                        reject(ServiceError.invalidRequest)
                    }
                }
            })
            dataTask.resume()
        }
    }
}
