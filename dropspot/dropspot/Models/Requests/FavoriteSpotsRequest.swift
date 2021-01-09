//
//  FavoriteSpotsRequest.swift
//  dropspot
//
//  Created by Bert Van eeckhoutte on 09/01/2021.
//

import Foundation

class FavoriteSpotsRequest: BasedResourceApiRequest<[SpotDetail]> {
    init() {
        super.init(endpoint: "users/favorites")
    }
}
