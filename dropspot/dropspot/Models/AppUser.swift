//
//  AppUser.swift
//  dropspot
//
//  Created by Bert Van eeckhoutte on 31/12/2020.
//

import Foundation

class AppUser: Codable {
    let userId: Int
    var username: String
    var firstName: String
    var lastName: String
    var email: String
    
    init(userId: Int, username: String, firstName: String, lastName: String, email: String) {
        self.userId = userId
        self.username = username
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
    }
    
    enum CodingKeys: String, CodingKey {
        case userId
        case username
        case firstName
        case lastName
        case email
    }
}
