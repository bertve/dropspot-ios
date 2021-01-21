//
//  SpotDetail.swift
//  spotWebTest
//
//  Created by Bert Van eeckhoutte on 26/12/2020.
//

import Foundation

class SpotDetail: Codable, CustomStringConvertible {
    let spotId : Int
    var spotName : String
    let creatorId: Int
    var creatorName: String
    var latitude : Double
    var longitude : Double
    var address: Address?
    var criteriaScore: [CriterionScore]
    var liked: Bool
    var owner: Bool
    var parkCategory: ParkCategory?
    var entranceFee: Float?
    var description: String {
        return "{ID: \(spotId), NAME: \(spotName), CREATOR:\(creatorName), LAT:\(latitude), LONG: \(longitude)\nADDRESS:\(address), SCORE:\(criteriaScore), OWNER:\(owner), CAT:\(parkCategory?.rawValue), FEE:\(entranceFee)}"
    }
    
    var  rank: Int {
        var resDouble = 0.0
        criteriaScore.forEach { criterionScore in
            resDouble += criterionScore.score
        }
        resDouble = resDouble / Double(criteriaScore.count)
        
        return Int(resDouble.rounded())
    }
    
    var locationString: String {
        if let address = address {
            return address.street + " " + address.houseNumber + "\n" + address.postalCode + " " + address.city
        } else {
            return "LAT: \(latitude)\nLONG: \(longitude)"
        }
    }
    
    init(spotId: Int, spotName: String, creatorId: Int, creatorName: String, latitude: Double, longitude: Double, address: Address?, criteriaScore: [CriterionScore], liked: Bool, owner: Bool, parkCategory: ParkCategory?, entranceFee: Float?) {
        self.spotId = spotId
        self.spotName = spotName
        self.creatorId = creatorId
        self.creatorName = creatorName
        self.latitude = latitude
        self.longitude = longitude
        self.address = address
        self.criteriaScore = criteriaScore
        self.liked = liked
        self.owner = owner
        self.parkCategory = parkCategory
        self.entranceFee = entranceFee
    }
    
    enum CodingKeys: String, CodingKey {
        case spotId
        case spotName
        case creatorId
        case creatorName
        case latitude
        case longitude
        case address
        case criteriaScore
        case liked
        case owner
        case parkCategory
        case entranceFee
    }
}
