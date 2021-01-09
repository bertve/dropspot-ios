//
//  StreetSpotRequest.swift
//  dropspot
//
//  Created by Bert Van eeckhoutte on 09/01/2021.
//

import Foundation

struct AddStreetSpotRequestModel: Codable {
    let name: String
    let latitude: Double
    let longitude: Double
    
    enum CodingKeys: String, CodingKey {
        case name
        case latitude
        case longitude
    }
}
