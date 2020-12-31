//
//  ViewController.swift
//  dropspot
//
//  Created by Bert Van eeckhoutte on 27/12/2020.
//

import UIKit
import MaterialComponents

class LoginViewController: FormValidatingKeyboardHandlingViewController {

    @IBOutlet var emailOrUsername: MDCOutlinedTextField!
    @IBOutlet var password: MDCOutlinedTextField!
    @IBOutlet var registerButton: MDCButton!
    @IBOutlet var loginButton: MDCButton!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.formValidator = LoginFormValidator(emailOrUsername: emailOrUsername, password: password)
        self.fields = [emailOrUsername, password]
        self.formConfirmingButton = loginButton
        
        password.isSecureTextEntry = true
        // theme
        applyThemeToComponents()
    }
    
    @IBAction func loginButtonPressed(_ sender: MDCButton) {
        login()
    }
    
    private func applyThemeToComponents(){
        Theme.applyThemeToTextField(emailOrUsername)
        Theme.applyThemeToTextField(password)
        Theme.applyThemeToButton(loginButton)
        Theme.applyThemeToButton(registerButton)
        
        // floating label
        emailOrUsername.label.text = "Email or Username"
        password.label.text = "password"
    }
    
    private func login(){
        print("LOGIN\nusernameEmail: \(String(describing: emailOrUsername.text))\npassword: \(String(describing: password.text))")
    }
    
}

