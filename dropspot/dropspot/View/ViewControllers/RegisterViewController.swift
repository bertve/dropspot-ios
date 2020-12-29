//
//  RegisterViewController.swift
//  dropspot
//
//  Created by Bert Van eeckhoutte on 28/12/2020.
//

import UIKit
import MaterialComponents

class RegisterViewController: UIViewController {

    @IBOutlet var firstName: MDCOutlinedTextField!
    @IBOutlet var lastName: MDCOutlinedTextField!
    @IBOutlet var username: MDCOutlinedTextField!
    @IBOutlet var email: MDCOutlinedTextField!
    @IBOutlet var password: MDCOutlinedTextField!
    @IBOutlet var passwordConfirm: MDCOutlinedTextField!
    @IBOutlet var registerBtn: MDCButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyThemeToComponents()
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    private func applyThemeToComponents(){
        Theme.applyThemeToTextField(firstName)
        Theme.applyThemeToTextField(lastName)
        Theme.applyThemeToTextField(username)
        Theme.applyThemeToTextField(email)
        Theme.applyThemeToTextField(password)
        Theme.applyThemeToTextField(passwordConfirm)
        Theme.applyThemeToButton(registerBtn)
    }

    @IBAction func registerBtnPressed(_ sender: MDCButton) {
        register()
    }
    
    private func register(){
        print("register")
    }
    
}
