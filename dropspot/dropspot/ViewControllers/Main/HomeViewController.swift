//
//  HomeViewController.swift
//  dropspot
//
//  Created by Bert Van eeckhoutte on 29/12/2020.
//

import UIKit
import MaterialComponents
import KYDrawerController

class HomeViewController: UIViewController, NavDrawerNavigationDelegate, MapDelegate{
    
    static let notificationLogout = NSNotification.Name(rawValue: "logout")
    var spotCLicked : Int?
    
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
        closeDrawer()
        performSegue(withIdentifier: "toMe", sender: self)
    }
    
    func spotsNavItemWasClicked() {
        closeDrawer()
        performSegue(withIdentifier: "toSpots", sender: self)
    }
    
    func logoutNavItemWasClicked() {
        closeDrawer()
        logout()
    }
    
    func spotMarkerClicked(spotId: Int) {
        spotCLicked = spotId
        performSegue(withIdentifier: "toSpotDetail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "embedMap"){
            let dest = segue.destination as! MapViewController
            dest.delegate = self
        }
        if (segue.identifier == "toSpotDetail") {
            let destination = segue.destination as! SpotDetailViewController
            if let id = spotCLicked {
                destination.setSpotDetailById(id)
            }
        }
    }

    private func logout(){
        let query = [kSecClass as String: kSecClassGenericPassword as String,
                kSecAttrAccount as String: "token"] as [String:Any]
        
        SecItemDelete(query as CFDictionary)
        UserDefaults.standard.removeObject(forKey: "loggedInUser")

        NotificationCenter.default.post(name: HomeViewController.notificationLogout, object: nil)
    }
    
}
