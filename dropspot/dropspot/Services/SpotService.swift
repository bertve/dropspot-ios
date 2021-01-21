//
//  Spotcontroller.swift
//  spotWebTest
//
//  Created by Bert Van eeckhoutte on 22/12/2020.
//

import Foundation

class SpotService : ResourceService {
    
    func fetchSpots(completion: @escaping (Result<[Spot],Error>) -> Void){
        super.sendRequest(SpotsRequest(), completion: completion)
    }
    
    func fetchSpotDetails(completion: @escaping (Result<[SpotDetail],Error>) -> Void){
        super.sendRequest(SpotDetailsRequest(), completion: completion)
    }
    
    func fetchSpotDetail(id: Int,completion: @escaping (Result<SpotDetail,Error>) -> Void){
        super.sendRequest(SpotDetailRequest(id: id), completion: completion)
    }
    
    func addStreetSpot(requestModel: AddStreetSpotRequestModel, completion: @escaping (Result<Spot,Error>) -> Void){
        super.sendRequest(AddStreetSpotRequest(addStreetSpotRequestModel: requestModel), completion: completion)
    }
    
    func addParkSpot(requestModel: AddParkSpotRequestModel, completion: @escaping (Result<Spot,Error>) -> Void){
        super.sendRequest(AddParkSpotRequest(addParkSpotRequestModel: requestModel), completion: completion)
    }
    
    func fetchMySpots(completion: @escaping (Result<[SpotDetail],Error>) -> Void){
        super.sendRequest(MySpotsRequest(), completion: completion)
    }
    
    func fetchFavoriteSpots(completion: @escaping (Result<[SpotDetail],Error>) -> Void){
        super.sendRequest(FavoriteSpotsRequest(), completion: completion)
    }
    
}
