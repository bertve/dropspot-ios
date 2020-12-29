//
//  LoginFormValidator.swift
//  dropspot
//
//  Created by Bert Van eeckhoutte on 29/12/2020.
//

import Foundation
import MaterialComponents

class LoginFormValidator {
    
    private let emailOrUsername, password: MDCOutlinedTextField
    
    init(emailOrUsername: MDCOutlinedTextField,password: MDCOutlinedTextField) {
        self.emailOrUsername = emailOrUsername
        self.password = password
    }
    
    func validateEmailOrUserName(){
    }
    
    func validatePassword(){
        
    }

}
