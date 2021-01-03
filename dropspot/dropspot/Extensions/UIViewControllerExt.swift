//
//  UIViewControllerExt.swift
//  dropspot
//
//  Created by Bert Van eeckhoutte on 03/01/2021.
//

import UIKit
import MaterialComponents

extension UIViewController {

    func showSnackBar(message: String){
        let sbMessage = MDCSnackbarMessage()
        sbMessage.text = message
        MDCSnackbarManager.default.show(sbMessage)
    }
    

}
