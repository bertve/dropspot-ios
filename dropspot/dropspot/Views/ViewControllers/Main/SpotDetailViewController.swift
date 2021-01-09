//
//  ViewController.swift
//  dropspot
//
//  Created by Bert Van eeckhoutte on 09/01/2021.
//

import UIKit
import MaterialComponents

class SpotDetailViewController: UIViewController {

    @IBOutlet var spotNameLbl: UILabel!
    @IBOutlet var creatorNameLbl: UILabel!
    @IBOutlet var locationLbl: UILabel!
    @IBOutlet var parkCatLbl: UILabel!
    @IBOutlet var damageLbl: UILabel!
    @IBOutlet var spotInfoStack: UIStackView!
    private let activityIndicator: MDCActivityIndicator = MDCActivityIndicator()

    private let spotDetailRepository = SpotDetailRepository()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func setSpotDetailById(_ id: Int){
        activityIndicator.sizeToFit()
        activityIndicator.cycleColors = [Theme.globalColorSheme().secondaryColor]
        view.addSubview(activityIndicator)
        let constraintx = NSLayoutConstraint(item: view!, attribute: .centerX, relatedBy: .equal, toItem: activityIndicator, attribute: .centerX, multiplier: 1, constant: 0)
        let constrainty = NSLayoutConstraint(item: view!, attribute: .centerY, relatedBy: .equal, toItem: activityIndicator, attribute: .centerY, multiplier: 1, constant: 0)
        
        view.addConstraint(constraintx)
        view.addConstraint(constrainty)
        activityIndicator.startAnimating()
        
        spotDetailRepository.fetchSpotDetail(id: id){ (res) in
            switch res {
            case .success(let spot):
                self.updateUI(with: spot)
            case .failure(let error):
                self.displayError(error: error)
            }
        }
    }
    
    func updateUI(with spotDetail: SpotDetail){
        DispatchQueue.main.async {
            self.spotNameLbl.text = spotDetail.spotName
            self.creatorNameLbl.text = spotDetail.creatorName
            self.locationLbl.text = spotDetail.locationString
            self.parkCatLbl.text = spotDetail.parkCategory?.rawValue
            self.damageLbl.text = spotDetail.entranceFee?.formatAsEuroCurrency()
            self.spotInfoStack.visibility = .visible
            self.spotInfoStack.layer.cornerRadius = 4
            self.spotInfoStack.layer.masksToBounds = true
            self.activityIndicator.stopAnimating()
        }
    }
    
    private func displayError(error: Error){
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.showSnackBar(message: error.localizedDescription)
        }
    }

}
