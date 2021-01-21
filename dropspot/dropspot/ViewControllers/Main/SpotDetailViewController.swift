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
    @IBOutlet var parkStaticLbl: UILabel!
    @IBOutlet var dmgStaticLbl: UILabel!
    @IBOutlet var rankImg: UIImageView!
    private let activityIndicator: MDCActivityIndicator = MDCActivityIndicator()

    private let spotDetailRepository = SpotDetailRepository()
    var spotDetail : SpotDetail?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let spot = spotDetail {
            updateUI(with: spot)
        }
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
                DispatchQueue.main.async {
                self.updateUI(with: spot)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                self.displayError(error: error)
                }
            }
        }
    }
    
    func updateUI(with spotDetail: SpotDetail){
        self.spotNameLbl.text = spotDetail.spotName
        self.creatorNameLbl.text = spotDetail.creatorName
        self.locationLbl.text = spotDetail.locationString
        self.spotInfoStack.visibility = .visible
        self.spotInfoStack.layer.cornerRadius = 4
        self.spotInfoStack.layer.masksToBounds = true
        self.rankImg.image = UIImage(named: String(spotDetail.rank))
        self.activityIndicator.stopAnimating()
        if let cat = spotDetail.parkCategory,
           let fee = spotDetail.entranceFee {
            self.parkCatLbl.text = cat.rawValue
            self.damageLbl.text = fee.formatAsEuroCurrency()
        } else {
            self.dmgStaticLbl.visibility = .gone
            self.parkStaticLbl.visibility = .gone
        }
    }
    

    
    private func displayError(error: Error){
            self.activityIndicator.stopAnimating()
            self.showSnackBar(message: error.localizedDescription)
    }

}
