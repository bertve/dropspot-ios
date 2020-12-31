//
//  FormValidatingKeyboardHandlingViewController.swift
//  dropspot
//
//  Created by Bert Van eeckhoutte on 30/12/2020.
//

import UIKit

class FormValidatingKeyboardHandlingViewController: KeyboardHandlingViewController {
    
    var formValidator : FormValidator? = nil
    var fields : [UITextField] = [] {
        didSet {
            fields.forEach{
                field in field.delegate = self
            }
        }
    }
    var formConfirmingButton : UIButton? = nil {
        didSet {
            formConfirmingButton?.isEnabled = false
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func textFieldDidEndEditing(_ textField: UITextField) {
        super.textFieldDidEndEditing(textField)
        updateFormConfirmingButtonState()
    }
    
    override func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let returnVal = super.textFieldShouldReturn(textField)
        if let posCurrentField = fields.firstIndex(of: textField) ?? nil {
            let posNextField = posCurrentField + 1
            if fields.count == posNextField {
                textField.resignFirstResponder()
            } else {
                fields[posNextField].becomeFirstResponder()
            }
        }
        return returnVal
    }
    
    private func updateFormConfirmingButtonState() {
        if let validator = formValidator,
           let btn = formConfirmingButton {
            btn.isEnabled = validator.validate()
        }
    }

}
