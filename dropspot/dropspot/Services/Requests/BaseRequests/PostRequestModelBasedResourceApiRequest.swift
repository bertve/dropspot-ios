//
//  PostBasedResourceApiRequest.swift
//  dropspot
//
//  Created by Bert Van eeckhoutte on 31/12/2020.
//

import Foundation

class PostRequestModelBasedResourceApiRequest<RequestModel: Codable, ResponseModel: Codable>: RequestModelBasedResourceApiRequest<RequestModel,ResponseModel>{
    
    override init(endpoint: String, requestModel: RequestModel) {
        super.init(endpoint: endpoint,requestModel: requestModel)
    }
    
    override var urlReq: URLRequest? {
        var req = super.urlReq
        req?.httpMethod = "POST"
        return req
    }
    
}
