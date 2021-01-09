//
//  ParkSpotRequestModel.swift
//  dropspot
//
//  Created by Bert Van eeckhoutte on 09/01/2021.
//

import Foundation

struct AddParkSpotRequestModel: Codable {
    let name: String
    let latitude: Double
    let longitude: Double
    let entranceFee: Float
    let parkCategory: ParkCategory
    let street: String
    let houseNumber: String
    let postalCode: String
    let city: String
    let state: String
    let country: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case latitude
        case longitude
        case entranceFee
        case parkCategory
        case street
        case houseNumber
        case postalCode
        case city
        case state
        case country
    }
}
