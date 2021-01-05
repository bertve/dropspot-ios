//
//  AppDelegate.swift
//  dropspot
//
//  Created by Bert Van eeckhoutte on 27/12/2020.
//

import UIKit
import KYDrawerController

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        if let token = checkIfAlreadyLoggedIn() {
            print(token)
            changeRootToHome()
        } else {
            print("not logged in")
            changeRootToLogin()
        }
        
        NotificationCenter.default.addObserver(self, selector:#selector(notifiedChangeRootToHome(notification:)),name:LoginViewController.notificationLoginSuccess,object: nil)
        NotificationCenter.default.addObserver(self, selector:#selector(notifiedChangeRootToLogin(notification:)),name:HomeViewController.notificationLogout,object: nil)

        self.window?.makeKeyAndVisible()
        
        return true
    }
    
    private func checkIfAlreadyLoggedIn() -> String? {
       let query = [kSecClass as String: kSecClassGenericPassword as String,
                         kSecAttrAccount as String: "token",
                         kSecReturnData as String: kCFBooleanTrue ?? "",
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
    
    @objc func notifiedChangeRootToHome(notification: Notification) {
        changeRootToHome()
    }
    
    @objc func notifiedChangeRootToLogin(notification: Notification) {
        changeRootToLogin()
    }
    
    private func changeRootToHome(){
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let navContent = storyBoard.instantiateViewController(withIdentifier: "navContent") as! NavDrawerContentViewController
        let rootVC = storyBoard.instantiateViewController(withIdentifier: "rootNav")
        let helper = rootVC as! UINavigationController
        let homeVC = helper.viewControllers.first as! HomeViewController
        navContent.delegate  = homeVC
        let drawerController = KYDrawerController(drawerDirection: .left, drawerWidth: 200)
        drawerController.mainViewController = rootVC
        drawerController.drawerViewController = navContent
        self.window?.rootViewController = drawerController
    }
    
    private func changeRootToLogin(){
        let storyBoard = UIStoryboard(name: "Auth", bundle: Bundle.main)
        let loginVC = storyBoard.instantiateViewController(withIdentifier: "loginVC") as! LoginViewController
        self.window?.rootViewController = loginVC
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}

