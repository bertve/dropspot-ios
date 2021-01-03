//
//  JwtResponse.swift
//  dropspot
//
//  Created by Bert Van eeckhoutte on 31/12/2020.
//

import Foundation

class JwtResponse: MessageResponse{
    var token: String
    var type: String
    var user: AppUser?
    
    init(success: Bool, message: String, token: String, type: String, user: AppUser?) {
        self.token = token
        self.type = type
        self.user = user
        super.init(success: success, message: message)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.token = try container.decode(String.self, forKey: .token)
        self.type = try container.decode(String.self, forKey: .type)
        self.user = try container.decode(AppUser?.self, forKey: .user)
        try super.init(from: decoder)
    }
    
    enum CodingKeys: String, CodingKey {
        case token
        case type
        case user
    }
    
}
