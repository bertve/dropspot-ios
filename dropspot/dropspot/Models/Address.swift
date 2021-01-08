//
//  Address.swift
//  dropspot
//
//  Created by Bert Van eeckhoutte on 08/01/2021.
//

import Foundation

class Address: Codable, CustomStringConvertible {
    var description: String {
        return "{STREET: \(street)...}"
    }
    
    var street: String
    var houseNumber: String
    var postalCode: String
    var city: String
    var state: String
    var country: String
    
    init(street: String, houseNumber: String, postalCode: String, city: String, state: String, country: String) {
        self.street = street
        self.houseNumber = houseNumber
        self.postalCode = postalCode
        self.city = city
        self.state = state
        self.country = country
    }
    
    enum CodingKeys: String, CodingKey {
        case street
        case houseNumber
        case postalCode
        case city
        case state
        case country
    }
}
