//
//  Validation.swift
//  dropspot
//
//  Created by Bert Van eeckhoutte on 29/12/2020.
//

import Foundation

struct Validation {
    var succes: Bool = true
    var message: String = "no message"
    
    init() {
        
    }
    
    init(message: String) {
        self.succes = false
        self.message  = message
    }
}
