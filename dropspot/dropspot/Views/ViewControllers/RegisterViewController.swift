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
    private let activityIndicator = MDCActivityIndicator()
    
    @IBOutlet var contentStack: UIStackView!
    private let authService = AuthService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.formValidator = RegisterFormValidator(firstName: firstName, lastName: lastName, username: username, email: email,password: password, passwordConfirm: passwordConfirm)
        self.fields = [firstName ,lastName ,username ,email ,password ,passwordConfirm]
        self.formConfirmingButton = registerBtn
        
        password.isSecureTextEntry = true
        passwordConfirm.isSecureTextEntry = false
        activityIndicator.cycleColors = [Theme.globalColorSheme().secondaryColor]
        activityIndicator.sizeToFit()
        contentStack.addArrangedSubview(activityIndicator)
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
        
        if let firstName = firstName.text?.trim(),
           let lastName = lastName.text?.trim(),
           let username = username.text?.trim(),
           let password = password.text?.trim(),
           let email = email.text?.trim(){
            activityIndicator.startAnimating()
            
            let requestModel = RegisterRequestModel(firstName: firstName,
                                                    lastName: lastName,
                                                    username: username,
                                                    password: password,
                                                    email: email)
                
            authService.register(registerRequestModel: requestModel , completion: { (res) in
                switch (res) {
                case .success(let messageRes):
                    DispatchQueue.main.async {
                        self.handleRegisterSuccess(messageRes)
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        self.handleRegisterFailure(error)
                    }
                }
            })
        }

    }
    
    private func handleRegisterSuccess(_ messageResponse: MessageResponse){
        activityIndicator.stopAnimating()
        if messageResponse.success{
            if let presenter = presentingViewController as?  LoginViewController {
                presenter.emailOrUsername.text = self.username.text
                presenter.password.text = self.password.text
            }
            dismiss(animated: true, completion: nil)
        }else{
            showSnackBar(message: "Register Failure: " + messageResponse.message)
        }
    }
    
    private func handleRegisterFailure(_ error: Error){
        activityIndicator.stopAnimating()
        showSnackBar(message: "Register failure: " + error.localizedDescription)
    }
    
}
