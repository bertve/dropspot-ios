//
//  AddParkSpotFormValidator.swift
//  dropspot
//
//  Created by Bert Van eeckhoutte on 08/01/2021.
//

import Foundation

import Foundation
import MaterialComponents

class AddParkSpotFormValidator: AddStreetSpotFormValidator {
    
    var parkCategory: MDCOutlinedTextField
    var street: MDCOutlinedTextField
    var houseNumber: MDCOutlinedTextField
    var city: MDCOutlinedTextField
    var postalCode: MDCOutlinedTextField
    var state: MDCOutlinedTextField
    var country: MDCOutlinedTextField
    
    init(spotName: MDCOutlinedTextField, parkCategory: MDCOutlinedTextField, street: MDCOutlinedTextField, houseNumber: MDCOutlinedTextField, city: MDCOutlinedTextField, postalCode: MDCOutlinedTextField, state: MDCOutlinedTextField, country: MDCOutlinedTextField ) {
        self.parkCategory = parkCategory
        self.street = street
        self.houseNumber = houseNumber
        self.city = city
        self.postalCode = postalCode
        self.state = state
        self.country = country
        super.init(spotName: spotName)
    }
    
    private func validateParkCategory() -> Bool {
        let field = self.parkCategory
        return super.validateRequiredField(field)
    }
    
    private func validateStreet() -> Bool {
        let field = self.street
        return super.validateRequiredField(field)
    }
    
    private func validateHouseNumber() -> Bool {
        let field = self.houseNumber
        return super.validateRequiredField(field)
    }
    
    private func validateCity() -> Bool {
        let field = self.city
        return super.validateRequiredField(field)
    }
    
    private func validatePostalCode() -> Bool {
        let field = self.postalCode
        return super.validateRequiredField(field)
    }
    
    private func validateState() -> Bool {
        let field = self.state
        return super.validateRequiredField(field)
    }
    
    private func validateCountry() -> Bool {
        let field = self.country
        return super.validateRequiredField(field)
    }
    
    override func validate() -> Bool {
        return super.validateSpotName() && validateParkCategory() && validateStreet() && validateHouseNumber() && validateCity() && validatePostalCode() && validateState() && validateCountry()
    }
    
}
