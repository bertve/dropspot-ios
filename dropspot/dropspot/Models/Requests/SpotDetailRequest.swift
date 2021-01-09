//
//  SpotDetailRequest.swift
//  dropspot
//
//  Created by Bert Van eeckhoutte on 09/01/2021.
//

import Foundation

class SpotDetailRequest: BasedResourceApiRequest<SpotDetail> {
    init(id: Int) {
        super.init(endpoint: "spots/\(id)/detail" )
    }
}
