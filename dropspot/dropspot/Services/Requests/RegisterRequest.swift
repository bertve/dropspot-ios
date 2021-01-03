//
//  RegisterRequest.swift
//  dropspot
//
//  Created by Bert Van eeckhoutte on 02/01/2021.
//

import Foundation

class RegisterRequest: PostRequestModelBasedResourceApiRequest<RegisterRequestModel, MessageResponse> {
    
    init(registerRequestModel: RegisterRequestModel) {
        super.init(endpoint:"auth/signup/user", requestModel: registerRequestModel)
    }
}
