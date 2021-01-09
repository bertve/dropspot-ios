//
//  AddStreetSpotRequest.swift
//  dropspot
//
//  Created by Bert Van eeckhoutte on 09/01/2021.
//

import Foundation

class AddStreetSpotRequest: PostRequestModelBasedResourceApiRequest<AddStreetSpotRequestModel, Spot> {
    
    init(addStreetSpotRequestModel: AddStreetSpotRequestModel) {
        super.init(endpoint: "spots/street", requestModel: addStreetSpotRequestModel)
    }
}
