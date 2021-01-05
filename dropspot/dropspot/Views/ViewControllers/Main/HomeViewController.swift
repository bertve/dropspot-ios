//
//  HomeViewController.swift
//  dropspot
//
//  Created by Bert Van eeckhoutte on 29/12/2020.
//

import UIKit
import MaterialComponents
import KYDrawerController

class HomeViewController: UIViewController, NavDrawerNavigationDelegate{
    
    static let notificationLogout = NSNotification.Name(rawValue: "logout")

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func menuPressed(_ sender: Any) {
        presentDrawer()
    }
    
    func presentDrawer(){
        if let drawerController = navigationController?.parent as? KYDrawerController {
            drawerController.setDrawerState(.opened, animated: true)
        }
    }
    
    func closeDrawer(){
        if let drawerController = navigationController?.parent as? KYDrawerController {
            drawerController.setDrawerState(.closed, animated: true)
        }
    }

    //MARK: NavDrawerNavigationDelegate
    func meNavItemWasClicked() {
        performSegue(withIdentifier: "test", sender: self)
        closeDrawer()
    }
    
    func spotsNavItemWasClicked() {
        performSegue(withIdentifier: "toSpots", sender: self)
        closeDrawer()
    }
    
    func logoutNavItemWasClicked() {
        closeDrawer()
        logout()
    }
    
    private func logout(){
        let query = [kSecClass as String: kSecClassGenericPassword as String,
                kSecAttrAccount as String: "token"] as [String:Any]
        
        SecItemDelete(query as CFDictionary)
        UserDefaults.standard.removeObject(forKey: "loggedInUser")

        NotificationCenter.default.post(name: HomeViewController.notificationLogout, object: nil)
    }
    
}
