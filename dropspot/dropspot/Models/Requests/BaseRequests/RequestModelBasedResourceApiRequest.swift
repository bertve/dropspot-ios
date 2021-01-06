//
//  RequestModelBasedResourceApiRequest.swift
//  dropspot
//
//  Created by Bert Van eeckhoutte on 31/12/2020.
//

import Foundation

class RequestModelBasedResourceApiRequest<RequestModel: Codable,ResponseModel: Codable>: BasedResourceApiRequest<ResponseModel> {
    var requestModel : RequestModel

    init(endpoint: String, requestModel: RequestModel) {
        self.requestModel = requestModel
        super.init(endpoint: endpoint)
    }
    
    override var urlReq: URLRequest?{
        var req = super.urlReq
        req?.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        req?.httpBody = encodeRequest()
        if let token = Session.formattedSessionToken{
            print("setting token in header")
            req?.setValue(token, forHTTPHeaderField: Session.authHeader )
        }
        return req
    }
    
    private func encodeRequest() -> Data? {
        return try? JSONEncoder().encode(requestModel)
    }
    
}
