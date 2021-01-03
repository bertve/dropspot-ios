//
//  LoginRequestModel.swift
//  dropspot
//
//  Created by Bert Van eeckhoutte on 31/12/2020.
//

import Foundation

struct LoginRequestModel : Codable {
    let usernameOrEmail: String
    let password: String
    
    enum CodingKeys: String, CodingKey {
        case usernameOrEmail
        case password
    }
}
