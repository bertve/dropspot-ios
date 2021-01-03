//
//  RegisterRequestModel.swift
//  dropspot
//
//  Created by Bert Van eeckhoutte on 02/01/2021.
//

import Foundation

struct RegisterRequestModel: Codable{
    let firstName: String
    let lastName: String
    let username: String
    let password: String
    let email: String
    
    enum CodingKeys: String, CodingKey {
        case firstName
        case lastName
        case username
        case password
        case email
    }
}
