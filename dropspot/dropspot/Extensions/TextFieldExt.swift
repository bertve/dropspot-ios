//
//  MDCBaseTextFieldExt.swift
//  dropspot
//
//  Created by Bert Van eeckhoutte on 29/12/2020.
//

import Foundation
import MaterialComponents

extension MDCOutlinedTextField{
    
   func applyErrorMessageToTxtField(errorMessage: String) {
    self.applyErrorTheme(withScheme: Theme.globalContainerSheme())
        self.leadingAssistiveLabel.text = errorMessage
    }
    
    func resetTxtField(){
        self.applyTheme(withScheme: Theme.globalContainerSheme())
        self.leadingAssistiveLabel.text = ""
    }
}

