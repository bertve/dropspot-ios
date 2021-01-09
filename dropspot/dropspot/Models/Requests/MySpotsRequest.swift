//
//  MySpotsRequest.swift
//  dropspot
//
//  Created by Bert Van eeckhoutte on 09/01/2021.
//

import Foundation


class MySpotsRequest: BasedResourceApiRequest<[SpotDetail]> {
    init() {
        super.init(endpoint: "users/mySpots")
    }
}
