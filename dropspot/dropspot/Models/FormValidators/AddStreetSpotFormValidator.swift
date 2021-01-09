//
//  AddStreetSpotFormValidator.swift
//  dropspot
//
//  Created by Bert Van eeckhoutte on 08/01/2021.
//

import Foundation
import MaterialComponents

class AddStreetSpotFormValidator: FormValidator {
    
    var spotName: MDCOutlinedTextField
    
    init(spotName: MDCOutlinedTextField) {
        self.spotName = spotName
    }
    
    func validateSpotName() -> Bool {
        let field = self.spotName
        
        // required
        let handledReqVal =  validateRequiredField(field)
        if !handledReqVal {
            return false
        }
        
        // max 25
        let maxVal : Validation = FormValidationUtil.maxLength(field.text!, maxLength: 25)
        let handledMaxVal = FormValidationUtil.handleValidation(maxVal, field)
        
        return handledMaxVal
    }
    
    func validateRequiredField(_ field :MDCOutlinedTextField) -> Bool {
        let reqVal = FormValidationUtil.txtFieldIsRequired(field.text)
        return FormValidationUtil.handleValidation(reqVal, field)
    }
    
    func validate() -> Bool {
        return validateSpotName()
    }
    
}

