//
//  ContentfloatingPanelDelegate.swift
//  dropspot
//
//  Created by Bert Van eeckhoutte on 09/01/2021.
//

import Foundation

protocol ContentFloatingPanelDelegate{
    func exitFPCClicked()
    func addStreetSpot(requestModel: AddStreetSpotRequestModel)
    func addParkSpot(requestModel: AddParkSpotRequestModel)
}
