//
//  SpotApiRequest.swift
//  spotWebTest
//
//  Created by Bert Van eeckhoutte on 26/12/2020.
//

import Foundation

class BasedResourceApiRequest<T : Codable>: ResourceApiRequest<T> {
    var baseUrl: String = "https://dropspot-rest-api.herokuapp.com/"
    typealias Response = T
    
    init(endpoint : String) {
        super.init(url: baseUrl + endpoint)
    }

}
