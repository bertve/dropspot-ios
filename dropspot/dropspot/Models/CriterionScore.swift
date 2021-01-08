//
//  CriterionScore.swift
//  dropspot
//
//  Created by Bert Van eeckhoutte on 08/01/2021.
//

import Foundation

class CriterionScore: Codable, CustomStringConvertible {
    let criterionId: Int
    let criterionName: String
    let description: String
    let score: Double
    
    init(criterionId: Int, criterionName: String, description: String, score: Double) {
        self.criterionId = criterionId
        self.criterionName = criterionName
        self.description = description
        self.score = score
    }
    
    enum CodingKeys: String, CodingKey {
        case criterionId
        case criterionName
        case description
        case score
    }
}
