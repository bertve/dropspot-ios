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
    @IBOutlet var contentStack: UIStackView!
    private let activityIndicator: MDCActivityIndicator = MDCActivityIndicator()
    private let authService = AuthService()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.formValidator = LoginFormValidator(emailOrUsername: emailOrUsername, password: password)
        self.fields = [emailOrUsername, password]
        self.formConfirmingButton = loginButton
        
        password.isSecureTextEntry = true
        activityIndicator.sizeToFit()
        activityIndicator.cycleColors = [Theme.globalColorSheme().secondaryColor]
        contentStack.addArrangedSubview(activityIndicator)
        
        // theme
        applyThemeToComponents()
        checkIfAlreadyLoggedIn()
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
        if let usernameOrEmail = emailOrUsername.text?.trim(),
           let password = password.text?.trim() {
            activityIndicator.startAnimating()
            authService.login(loginRequestModel: LoginRequestModel(usernameOrEmail: usernameOrEmail.trimmingCharacters(in: .whitespacesAndNewlines), password: password.trimmingCharacters(in: .whitespacesAndNewlines))){ (res) in
                switch (res) {
                    case .success(let jwtResponse):
                        print(jwtResponse.token)
                        DispatchQueue.main.async {
                            self.handleLoginSuccess(jwtResponse)
                        }
                    case .failure(let error):
                        DispatchQueue.main.async {
                            self.handleLoginFailure(error)
                        }
                }
                
            }
        }
    }
    
    private func handleLoginSuccess(_ jwtResponse: JwtResponse){
        print(jwtResponse.message)
        activityIndicator.stopAnimating()
        if jwtResponse.success {

            // store token in keychain
            if let valueData = jwtResponse.token.data(using: .utf8) {
                
                let query = [kSecClass as String: kSecClassGenericPassword as String,
                        kSecAttrAccount as String: "token",
                        kSecValueData as String: valueData] as [String:Any]
                
                SecItemDelete(query as CFDictionary)
                SecItemAdd(query as CFDictionary, nil)
            }
            
            // store user
            let userData = try? JSONEncoder().encode(jwtResponse.user)
            UserDefaults.standard.set(userData, forKey: "loggedInUser")
            // nav to home
            navigateToHome()
            
        }else {
            showSnackBar(message: "Login Failed: " + jwtResponse.message)
        }
    }
    
    private func navigateToHome(){
        performSegue(withIdentifier: "loginSuccess", sender: self)
    }
    
    private func handleLoginFailure(_ error: Error){
        activityIndicator.stopAnimating()
        showSnackBar(message: "Login Failed: " + error.localizedDescription)
    }
    
    private func checkIfAlreadyLoggedIn(){
        let query = [kSecClass as String: kSecClassGenericPassword as String,
                         kSecAttrAccount as String: "token",
                         kSecReturnData as String: kCFBooleanTrue,
                         kSecMatchLimit as String: kSecMatchLimitOne] as [String: Any]

            var dataTypeRef: AnyObject?
            let status: OSStatus = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
            if status == noErr {
                if let data = dataTypeRef as? Data {
                    let token = String(decoding: data, as: UTF8.self)
                    print(token)
                    navigateToHome()
                }
                
            }
    }
    
}

