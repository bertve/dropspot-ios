//
//  SpotApiRequest.swift
//  spotWebTest
//
//  Created by Bert Van eeckhoutte on 26/12/2020.
//

import Foundation

class SpotsRequest: BasedResourceApiRequest<[Spot]> {
    init() {
        super.init(endpoint: "spots/dto")
    }
}
