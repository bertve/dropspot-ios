//
//  ResourceApiRequest.swift
//  spotWebTest
//
//  Created by Bert Van eeckhoutte on 26/12/2020.
//

import Foundation

class ResourceApiRequest<T : Codable>: ApiRequest {
    typealias Response = T

    var url: String
    
    init(url : String) {
        self.url = url
    }
    
    var urlReq: URLRequest? {
        if let safeUrl = URL(string: url){
            return URLRequest(url: safeUrl)
        } else {
            return nil
        }
    }
    
    func decodeResponse(data: Data) throws -> T {
        return try JSONDecoder().decode(T.self, from: data)
    }
            
}
