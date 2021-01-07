//
//  SpotRepository.swift
//  dropspot
//
//  Created by Bert Van eeckhoutte on 06/01/2021.
//

import Foundation

class SpotRepository {

    private let spotService = SpotService()
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    private let spotsFileURL = FileManager.createJSONDir().appendingPathComponent("spots.json")

    func fetchSpots(completion: @escaping (Result<[Spot],Error>) -> Void) {
        spotService.fetchSpots(completion: completion)
    }
    
    func getSpots() -> [Spot]? {
        if let localSpotsData = try? Data(contentsOf: spotsFileURL),
           let decodedSpots : [Spot] = try? decoder.decode([Spot].self, from: localSpotsData){
            print("spots locally retrieved:")
            print(decodedSpots)
            return decodedSpots
        }
        return nil
    }
    
    func resetSpotsInLocalDir() {
        try? FileManager.default.removeItem(at: spotsFileURL)
    }
    
    func saveSpotsInLocalDir(spots: [Spot]){
        spots.forEach { spot in
            saveSpotInLocalDir(spot: spot)
        }
    }
    
    func saveSpotInLocalDir(spot: Spot){
        print("try Saving spot in local doc:")
        print(spot.description)
        let encodedSpot = try? encoder.encode(spot)
        try? encodedSpot?.write(to: spotsFileURL)
    }
    
}


