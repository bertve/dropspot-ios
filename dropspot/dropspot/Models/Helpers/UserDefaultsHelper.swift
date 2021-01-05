//
//  UserDefaultsHelper.swift
//  dropspot
//
//  Created by Bert Van eeckhoutte on 05/01/2021.
//

import Foundation

class UserDefaultsHelper{
    private static let userDefaults = UserDefaults.standard
    private static let encoder = JSONEncoder()
    private static let decoder = JSONDecoder()
    private static let loggedInUserKey = "loggedInUser"
    
    static func setLoggedInUser(user: AppUser){
        let userData = try? encoder.encode(user)
        userDefaults.set(userData, forKey: loggedInUserKey)
    }
    
    static func getLoggedInUser() -> AppUser? {
        let userData = userDefaults.data(forKey: loggedInUserKey)
        guard let data = userData else {
            return nil
        }
        return try? decoder.decode(AppUser.self, from: data)
    }
    
}
