//
//  SpotDetailsRequest.swift
//  dropspot
//
//  Created by Bert Van eeckhoutte on 08/01/2021.
//

import Foundation

class SpotDetailsRequest: BasedResourceApiRequest<[SpotDetail]> {
    init() {
        super.init(endpoint: "spots/detail")
    }
}
