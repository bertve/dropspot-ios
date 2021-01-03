//
//  ApiRequest.swift
//  spotWebTest
//
//  Created by Bert Van eeckhoutte on 26/12/2020.
//

import Foundation

protocol ApiRequest {
    associatedtype Response
    
    var url : String { get }
    var urlReq : URLRequest? { get }
    func decodeResponse(data: Data) throws -> Response
}

