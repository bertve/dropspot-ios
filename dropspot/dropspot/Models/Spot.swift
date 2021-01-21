//
//  Spots.swift
//  spotWebTest
//
//  Created by Bert Van eeckhoutte on 22/12/2020.
//

import Foundation

class Spot : Codable, CustomStringConvertible {
    let id : Int
    let creatorId: Int
    var name : String
    var latitude : Double
    var longitude : Double
    var description: String {
        return "{ID: \(id), NAME: \(name), LAT:\(latitude), LONG: \(longitude)}"
    }
    
    init(id: Int, creatorId: Int, name: String, latitude: Double, longitude: Double) {
        self.id = id
        self.creatorId = creatorId
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case creatorId
        case name
        case latitude
        case longitude
    }
}
