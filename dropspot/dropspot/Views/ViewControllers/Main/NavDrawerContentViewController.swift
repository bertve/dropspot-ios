//
//  NavDrawerContentViewController.swift
//  dropspot
//
//  Created by Bert Van eeckhoutte on 03/01/2021.
//

import UIKit

class NavDrawerContentViewController: UIViewController {
    
    var delegate : NavDrawerNavigationDelegate? = nil
    @IBOutlet var usernameLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let loggedInUser = UserDefaultsHelper.getLoggedInUser()
        if let user = loggedInUser {
            usernameLbl.text = user.username
        }
    }
    
    @IBAction func mePressed(_ sender: UIButton) {
        delegate?.meNavItemWasClicked()
    }
    
    @IBAction func spotsPressed(_ sender: UIButton) {
        delegate?.spotsNavItemWasClicked()
    }
    
    @IBAction func logOutPressed(_ sender: UIButton) {
        delegate?.logoutNavItemWasClicked()
    }
    
}
