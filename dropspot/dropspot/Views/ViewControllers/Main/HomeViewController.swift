//
//  HomeViewController.swift
//  dropspot
//
//  Created by Bert Van eeckhoutte on 29/12/2020.
//

import UIKit
import MaterialComponents

class HomeViewController: UIViewController, MDCBottomDrawerViewControllerDelegate{

    let navDrawer = MDCBottomDrawerViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        // setup nav drawer
        
    }
    
    private func setupDrawer(){
        Theme.applyThemeToNavDrawer(navDrawer)
        navDrawer.contentViewController = NavDrawerContentViewController()
        navDrawer.headerViewController = NavDrawerHeaderViewController() as! UIViewController & MDCBottomDrawerHeader
        navDrawer.delegate = self
    }
    
    private func presentDrawer(){
        present(navDrawer, animated: true, completion: nil)
    }
    
    @IBAction func menuBtnPressed(_ sender: UIBarButtonItem) {
        presentDrawer()
    }
    
}
