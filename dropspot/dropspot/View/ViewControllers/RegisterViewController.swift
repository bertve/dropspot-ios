//
//  RegisterViewController.swift
//  dropspot
//
//  Created by Bert Van eeckhoutte on 28/12/2020.
//

import UIKit
import MaterialComponents

class RegisterViewController: FormValidatingKeyboardHandlingViewController {

    @IBOutlet var firstName: MDCOutlinedTextField!
    @IBOutlet var lastName: MDCOutlinedTextField!
    @IBOutlet var username: MDCOutlinedTextField!
    @IBOutlet var email: MDCOutlinedTextField!
    @IBOutlet var password: MDCOutlinedTextField!
    @IBOutlet var passwordConfirm: MDCOutlinedTextField!
    @IBOutlet var registerBtn: MDCButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.formValidator = RegisterFormValidator(firstName: firstName, lastName: lastName, username: username, email: email,password: password, passwordConfirm: passwordConfirm)
        self.fields = [firstName ,lastName ,username ,email ,password ,passwordConfirm]
        self.formConfirmingButton = registerBtn
        
        password.isSecureTextEntry = true
        passwordConfirm.isSecureTextEntry = false
        
        applyThemeToComponents()
    }
    
    private func applyThemeToComponents(){
        Theme.applyThemeToTextField(firstName)
        Theme.applyThemeToTextField(lastName)
        Theme.applyThemeToTextField(username)
        Theme.applyThemeToTextField(email)
        Theme.applyThemeToTextField(password)
        Theme.applyThemeToTextField(passwordConfirm)
        Theme.applyThemeToButton(registerBtn)
        firstName.label.text = "First Name"
        lastName.label.text = "Last name"
        username.label.text = "Username"
        email.label.text = "Email"
        password.label.text = "Password"
        passwordConfirm.label.text = "Password Confirmation"
    }
    
    @IBAction func registerBtnPressed(_ sender: MDCButton) {
        register()
    }

    private func register(){
        print("first:\(String(describing: firstName)), last:\(String(describing: lastName)), username:\(String(describing: username)), email:\(String(describing: email)), password:\(String(describing: password)),confirm:\(String(describing: passwordConfirm))")
    }
    
}
