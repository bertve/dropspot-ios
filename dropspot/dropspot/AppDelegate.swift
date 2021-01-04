//
//  AppDelegate.swift
//  dropspot
//
//  Created by Bert Van eeckhoutte on 27/12/2020.
//

import UIKit
import MaterialComponents

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        if let token = checkIfAlreadyLoggedIn() {
            print(token)
            let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let rootVC = storyBoard.instantiateViewController(withIdentifier: "rootNav")
            self.window?.rootViewController = rootVC
        } else {
            print("not logged in")
            let storyBoard = UIStoryboard(name: "Auth", bundle: Bundle.main)
            let loginVC = storyBoard.instantiateViewController(withIdentifier: "loginVC") as! LoginViewController
            self.window?.rootViewController = loginVC
        }
        
        NotificationCenter.default.addObserver(self, selector:#selector(changeRootToHome(notification:)),name:LoginViewController.notificationLoginSuccess,object: nil)
        
        self.window?.makeKeyAndVisible()
        
        return true
    }
    
    private func checkIfAlreadyLoggedIn() -> String? {
       let query = [kSecClass as String: kSecClassGenericPassword as String,
                         kSecAttrAccount as String: "token",
                         kSecReturnData as String: kCFBooleanTrue,
                         kSecMatchLimit as String: kSecMatchLimitOne] as [String: Any]

            var dataTypeRef: AnyObject?
            let status: OSStatus = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
            if status == noErr {
                if let data = dataTypeRef as? Data {
                    let token = String(decoding: data, as: UTF8.self)
                    return token
                }
            }
        return nil
    }
    
    @objc func changeRootToHome(notification: Notification) {
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let rootVC = storyBoard.instantiateViewController(withIdentifier: "rootNav")
        self.window?.rootViewController = rootVC
    }

}

