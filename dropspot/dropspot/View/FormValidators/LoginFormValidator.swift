//
//  LoginFormValidator.swift
//  dropspot
//
//  Created by Bert Van eeckhoutte on 29/12/2020.
//

import Foundation
import MaterialComponents

class LoginFormValidator : FormValidator {
    
    private let emailOrUsername, password: MDCOutlinedTextField
    
    init(emailOrUsername: MDCOutlinedTextField,password: MDCOutlinedTextField) {
        self.emailOrUsername = emailOrUsername
        self.password = password
    }
    
    func validateEmailOrUserName() -> Bool{
        let field = self.emailOrUsername
        let validation = FormValidationUtil.txtFieldIsRequired( field.text)
        return FormValidationUtil.handleValidation(validation,field)
    }
    
    func validatePassword() -> Bool {
        let field = self.password
        let validation = FormValidationUtil.txtFieldIsRequired( field.text)
        return FormValidationUtil.handleValidation(validation,field)
    }
    
    func validate() -> Bool {
        return  validateEmailOrUserName() && validatePassword()
    }
    
}
