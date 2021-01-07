//
//  FileManagerExt.swift
//  dropspot
//
//  Created by Bert Van eeckhoutte on 06/01/2021.
//

import Foundation

extension FileManager {
    static var documentDirectoryURL : URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    
    static func createJSONDir() -> URL{
        let newDir = documentDirectoryURL.appendingPathComponent("json")
        try? FileManager.default.createDirectory(at: newDir, withIntermediateDirectories: true , attributes: nil )
        return newDir
    }
}
