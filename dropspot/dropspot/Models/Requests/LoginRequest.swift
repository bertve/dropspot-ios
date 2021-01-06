//
//  LoginRequest.swift
//  dropspot
//
//  Created by Bert Van eeckhoutte on 31/12/2020.
//

import Foundation

class LoginRequest: PostRequestModelBasedResourceApiRequest<LoginRequestModel,JwtResponse> {
    
    init(loginRequestModel: LoginRequestModel) {
        super.init(endpoint: "auth/signin", requestModel: loginRequestModel)
    }
}
