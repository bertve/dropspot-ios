//
//  AddParkSpotRequest.swift
//  dropspot
//
//  Created by Bert Van eeckhoutte on 09/01/2021.
//

import Foundation

class AddParkSpotRequest: PostRequestModelBasedResourceApiRequest<AddParkSpotRequestModel, Spot> {
    
    init(addParkSpotRequestModel: AddParkSpotRequestModel) {
        super.init(endpoint: "spots/park", requestModel: addParkSpotRequestModel)
    }
}
