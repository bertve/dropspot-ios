//
//  Session.swift
//  dropspot
//
//  Created by Bert Van eeckhoutte on 06/01/2021.
//

import Foundation

class Session {
    
    static var defaultSession : URLSession{
        let config = URLSessionConfiguration.default
        if let formattedToken = Session.formattedSessionToken {
            print("setting auth header")
            config.httpAdditionalHeaders = [Session.authHeader : formattedToken]
        }
        return URLSession(configuration: config)
    }
    
    static let authHeader: String = "Authorization"
    static var sessionToken: String? = nil {
        didSet{
            print("session token set in session: \(String(describing: sessionToken))")
        }
    }
    static var formattedSessionToken: String? {
        if let token = sessionToken {
            return "Bearer " + token
        }
        return nil
    }
}
