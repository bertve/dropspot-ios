//
//  AuthService.swift
//  dropspot
//
//  Created by Bert Van eeckhoutte on 29/12/2020.
//

import Foundation

class AuthService : ResourceService {
    
    func login(loginRequestModel: LoginRequestModel, completion: @escaping (Result<JwtResponse,Error>) -> Void){
        super.sendRequest(LoginRequest(loginRequestModel: loginRequestModel), completion: completion)
    }
    
    func register(registerRequestModel: RegisterRequestModel, completion: @escaping (Result<MessageResponse,Error>) -> Void){
        super.sendRequest(RegisterRequest(registerRequestModel: registerRequestModel), completion: completion)
    }
}
