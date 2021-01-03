//
//  MessageResponse.swift
//  dropspot
//
//  Created by Bert Van eeckhoutte on 31/12/2020.
//

import Foundation

class MessageResponse: Codable{
    var success: Bool = false
    var message: String = "no message"

    init(success: Bool, message: String){
        self.success = success
        self.message = message
    }

    enum CodingKeys: String, CodingKey {
        case success
        case message
    }
    
}
