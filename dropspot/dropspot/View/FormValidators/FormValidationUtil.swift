//
//  FormValidationUtil.swift
//  dropspot
//
//  Created by Bert Van eeckhoutte on 29/12/2020.
//

import Foundation
import MaterialComponents

class FormValidationUtil {
    
    static let messageReq = "Required"
    
    static func txtFieldIsRequired(_ s: String?) -> Validation {
        if let validationString : String = s?.trimmingCharacters(in: .whitespacesAndNewlines) {
            if validationString.isEmpty {
                return Validation(message: self.messageReq)
            } else {
                return Validation()
            }
        }else{
            return Validation(message: self.messageReq)
        }
    }
    
    static func isValidEmail(_ s: String) -> Validation {
        let trimmedString = s.trimmingCharacters(in: .whitespacesAndNewlines)
        let match = trimmedString.range(of: #"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"#,
                       options: .regularExpression) != nil
        if !match {
            return Validation(message: "Wrong email format")
        }
        
        return Validation()
    }
    
    static func maxLength(_ s: String, maxLength: Int) -> Validation {
        let trimmedString = s.trimmingCharacters(in: .whitespacesAndNewlines)
        if (trimmedString.count > maxLength){
            return Validation(message: "Max length is \(maxLength)")
        }
        return Validation()
    }
    
    static func minLength(_ s: String, minLength: Int) -> Validation {
        let trimmedString = s.trimmingCharacters(in: .whitespacesAndNewlines)
        if (trimmedString.count < minLength){
            return Validation(message: "Min length is \(minLength)")
        }
        return Validation()
    }
    
    static func passwordConfirmation(password: String?,confirmation: String?) -> Validation {
        if password != confirmation {
            if let trimmedPasswordString = password?.trimmingCharacters(in: .whitespacesAndNewlines),
               let trimmedConfirmString = confirmation?.trimmingCharacters(in: .whitespacesAndNewlines) {
                if trimmedPasswordString == trimmedConfirmString {
                    return Validation()
                }
            }
            return Validation(message: "Password must match")
        }
        return Validation()
    }
    
    static func isValidUsername(_ s: String) -> Validation {
        let trimmedString = s.trimmingCharacters(in: .whitespacesAndNewlines)
        let match = trimmedString.range(of: #"^[A-Za-z]\w{4,24}$"#,
                       options: .regularExpression) != nil
        if !match {
            return Validation(message: "May only contain alphanumeric characters and underscores, the first character must be alphabetic")
        }
        
        return Validation()
    }
    
    static func handleValidation(_ validation: Validation,_ field: MDCOutlinedTextField ) -> Bool {
        if validation.succes{
            field.resetTxtField()
        } else {
            field.applyErrorMessageToTxtField(errorMessage: validation.message)
        }
        
        return validation.succes
    }
    
}
