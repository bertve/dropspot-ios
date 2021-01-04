//
//  RegisterFormValidator.swift
//  dropspot
//
//  Created by Bert Van eeckhoutte on 30/12/2020.
//

import Foundation
import MaterialComponents

class RegisterFormValidator: FormValidator {
    
    private let firstName, lastName, username, email, password, passwordConfirm: MDCOutlinedTextField
    
    init(firstName: MDCOutlinedTextField,
         lastName: MDCOutlinedTextField,
         username: MDCOutlinedTextField,
         email: MDCOutlinedTextField,
         password: MDCOutlinedTextField,
         passwordConfirm: MDCOutlinedTextField) {
        self.firstName = firstName
        self.lastName = lastName
        self.username = username
        self.email = email
        self.password = password
        self.passwordConfirm = passwordConfirm
    }
    
    func validateFirstName() -> Bool {
        let field = self.firstName
        
        // required
        let reqVal : Validation = FormValidationUtil.txtFieldIsRequired(field.text)
        let handledReqVal = FormValidationUtil.handleValidation(reqVal, field)
        if !handledReqVal {
            return false
        }
        
        // max 50
        let maxVal : Validation = FormValidationUtil.maxLength(field.text!, maxLength: 50)
        let handledMaxVal = FormValidationUtil.handleValidation(maxVal, field)
        
        return handledMaxVal
    }
    
    func validateLastName() -> Bool {
        let field = self.lastName
        
        // required
        let reqVal : Validation = FormValidationUtil.txtFieldIsRequired(field.text)
        let handledReqVal = FormValidationUtil.handleValidation(reqVal, field)
        if !handledReqVal {
            return false
        }
        
        // max 50
        let maxVal : Validation = FormValidationUtil.maxLength(field.text!, maxLength: 50)
        let handledMaxVal = FormValidationUtil.handleValidation(maxVal, field)
        
        return handledMaxVal
    }
    
    func validateUsername() -> Bool {
        let field = self.username
        
        // required
        let reqVal : Validation = FormValidationUtil.txtFieldIsRequired(field.text)
        let handledReqVal = FormValidationUtil.handleValidation(reqVal, field)
        if !handledReqVal {
            return false
        }
        
        // min 5
        let minVal : Validation = FormValidationUtil.minLength(field.text! , minLength: 5)
        let handledMinVal = FormValidationUtil.handleValidation(minVal, field)
        if !handledMinVal {
            return false
        }
        
        // max 25
        let maxVal : Validation = FormValidationUtil.maxLength(field.text!, maxLength: 25)
        let handledMaxVal = FormValidationUtil.handleValidation(maxVal, field)
        if !handledMaxVal {
            return false
        }
        
        // regex github
        let usernameFormatVal : Validation = FormValidationUtil.isValidUsername(field.text!)
        let handledFormatVal = FormValidationUtil.handleValidation(usernameFormatVal, field)
        
        return handledFormatVal
    }
    
    func validateEmail() -> Bool {
        let field = self.email
        
        // required
        let reqVal : Validation = FormValidationUtil.txtFieldIsRequired(field.text)
        let handledReqVal = FormValidationUtil.handleValidation(reqVal, field)
        if !handledReqVal {
            return false
        }
        
        // max 100
        let maxVal : Validation = FormValidationUtil.maxLength(field.text!, maxLength: 100)
        let handledMaxVal = FormValidationUtil.handleValidation(maxVal, field)
        if !handledMaxVal {
            return false
        }
        
        // regex github
        let emailFormatVal : Validation = FormValidationUtil.isValidEmail(field.text!)
        let handledFormatVal = FormValidationUtil.handleValidation(emailFormatVal, field)
        
        return handledFormatVal
    }
    
    func validatePassword() -> Bool {
        let field = self.password
        
        // required
        let reqVal : Validation = FormValidationUtil.txtFieldIsRequired(field.text)
        let handledReqVal = FormValidationUtil.handleValidation(reqVal, field)
        if !handledReqVal {
            return false
        }
        
        // min 5
        let minVal : Validation = FormValidationUtil.minLength(field.text! , minLength: 6)
        let handledMinVal = FormValidationUtil.handleValidation(minVal, field)

        return handledMinVal
    }
    
    func validatePasswordConfirm() -> Bool {
        let field = self.passwordConfirm
        let password = self.password.text
        let sameVal : Validation = FormValidationUtil.passwordConfirmation(password: password, confirmation: field.text)
        let handledPasswordVal = FormValidationUtil.handleValidation(sameVal, field)
        
        return handledPasswordVal
    }
    
    func validate() -> Bool {
        return validateFirstName() && validateLastName() && validateUsername() && validateEmail() && validatePassword() && validatePasswordConfirm()
    }
    
}
