//
//  FormValidator.swift
//  dropspot
//
//  Created by Bert Van eeckhoutte on 29/12/2020.
//

import Foundation
import MaterialComponents.MDCBaseTextField

protocol FormValidator {
    func validate() -> Bool
}
