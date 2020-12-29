//
//  ViewController.swift
//  dropspot
//
//  Created by Bert Van eeckhoutte on 27/12/2020.
//

import UIKit
import MaterialComponents

class LoginViewController: UIViewController {

    @IBOutlet var emailOrUsername: MDCOutlinedTextField!
    @IBOutlet var password: MDCOutlinedTextField!
    @IBOutlet var registerButton: MDCButton!
    @IBOutlet var loginButton: MDCButton!
    
    private var formValidator : LoginFormValidator {
        return LoginFormValidator(emailOrUsername: emailOrUsername, password: password)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        Theme.applyThemeToTextField(emailOrUsername)
        Theme.applyThemeToTextField(password)
        Theme.applyThemeToButton(loginButton)
        Theme.applyThemeToButton(registerButton)
    }

    @IBAction func loginButtonPressed(_ sender: MDCButton) {
        login()
    }
    
    private func login(){
        print("login")
    }
    

}

