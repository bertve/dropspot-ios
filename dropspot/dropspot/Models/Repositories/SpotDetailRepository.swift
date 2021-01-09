//
//  SpotDetailRepository.swift
//  dropspot
//
//  Created by Bert Van eeckhoutte on 08/01/2021.
//

import Foundation

class SpotDetailRepository {

    private let spotService = SpotService()
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    private let spotDetailsFileURL = FileManager.createJSONDir().appendingPathComponent("spotDetails.json")

    func fetchSpotDetails(completion: @escaping (Result<[SpotDetail],Error>) -> Void) {
        spotService.fetchSpotDetails(completion: completion)
    }
    
    func fetchMySpots(completion: @escaping (Result<[SpotDetail],Error>) -> Void) {
        spotService.fetchMySpots(completion: completion)
    }
    
    func fetchFavoriteSpots(completion: @escaping (Result<[SpotDetail],Error>) -> Void) {
        spotService.fetchFavoriteSpots(completion: completion)
    }
    
    func getSpotDetails() -> [SpotDetail]? {
        if let localSpotsData = try? Data(contentsOf: spotDetailsFileURL),
           let decodedSpots : [SpotDetail] = try? decoder.decode([SpotDetail].self, from: localSpotsData){
            print("spots locally retrieved:")
            print(decodedSpots)
            return decodedSpots
        }
        return nil
    }
    
    func resetSpotDetailsInLocalDir() {
        try? FileManager.default.removeItem(at: spotDetailsFileURL)
    }
    
    func saveSpotDetailsInLocalDir(spots: [SpotDetail]){
        spots.forEach { spot in
            saveSpotDetailInLocalDir(spot: spot)
        }
    }
    
    func saveSpotDetailInLocalDir(spot: SpotDetail){
        print("try Saving spotDetail in local doc:")
        print(spot.description)
        let encodedSpot = try? encoder.encode(spot)
        try? encodedSpot?.write(to: spotDetailsFileURL)
    }
    
}
