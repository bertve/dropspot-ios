//
//  ResourceRepository.swift
//  dropspot
//
//  Created by Bert Van eeckhoutte on 06/01/2021.
//

import Foundation


 
protocol ResourceRepository {
    associatedtype Resource

   func getAll() -> [Resource]
   func get( id:Int ) -> Resource?
   func create( article:Resource) -> Bool
   func update( article:Resource) -> Bool
   func delete( article:Resource ) -> Bool
}

