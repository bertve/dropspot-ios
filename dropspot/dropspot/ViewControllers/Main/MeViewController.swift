//
//  MeViewController.swift
//  dropspot
//
//  Created by Bert Van eeckhoutte on 06/01/2021.
//

import UIKit
import MaterialComponents

class MeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet var mySpotsCollView: UICollectionView!
    @IBOutlet var favoSpotsCollView: UICollectionView!
    @IBOutlet var skaterProfileView: UIView!
    @IBOutlet var usernameLblView: UIView!
    @IBOutlet var usernameLbl: UILabel!
    
    private let spotDetailRepository = SpotDetailRepository()
    private var mySpots = [SpotDetail]()
    private var favoSpots = [SpotDetail]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setup username vis
        let constraint = NSLayoutConstraint(item: skaterProfileView!, attribute: .bottom, relatedBy: .equal, toItem: usernameLblView, attribute: .centerY, multiplier: 1, constant: 0)
        skaterProfileView.addConstraint(constraint)
        usernameLbl.text = UserDefaultsHelper.getLoggedInUser()?.username ?? "username"
        usernameLblView.layer.borderColor = Theme.globalColorSheme().primaryColor.cgColor
        usernameLblView.layer.borderWidth = 4
        usernameLblView.layer.cornerRadius = 8
        usernameLblView.layer.masksToBounds = true
        
        // setup coll views
        mySpotsCollView.setCollectionViewLayout(genLayout(), animated: false)
        favoSpotsCollView.setCollectionViewLayout(genLayout(), animated: false)
        mySpotsCollView.delegate = self
        mySpotsCollView.dataSource = self
        mySpotsCollView.register(SpotDetailCollectionViewCell.self, forCellWithReuseIdentifier: "mySpotCell")
        favoSpotsCollView.delegate = self
        favoSpotsCollView.delegate = self
        mySpotsCollView.register(SpotDetailCollectionViewCell.self, forCellWithReuseIdentifier: "favoSpotCell")

        // fetch spotdetails
        spotDetailRepository.fetchMySpots{ (res) in
                switch res {
                case .success(let spots):
                    self.updateMySpots(with: spots)
                case .failure(let error):
                    self.displayError(error: error)
                }
        }
        
        spotDetailRepository.fetchFavoriteSpots { (res) in
                switch res {
                case .success(let spots):
                    self.updateFavoSpots(with: spots)
                case .failure(let error):
                    self.displayError(error: error)
                }
        }
        
    }
    
    private func updateMySpots(with spots: [SpotDetail]){
        DispatchQueue.main.async {
            self.mySpots = spots
            self.mySpotsCollView.reloadData()
        }
    }
    
    private func updateFavoSpots(with spots: [SpotDetail]){
        DispatchQueue.main.async {
            self.favoSpots = spots
            self.favoSpotsCollView.reloadData()
        }
    }
    
    
    private func displayError(error: Error){
        showSnackBar(message: error.localizedDescription)
    }
    
    private func genLayout() -> UICollectionViewLayout {
        // size and count
        let itemsize  = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item   = NSCollectionLayoutItem(layoutSize: itemsize)
        //item.contentInsets =  NSDirectionalEdgeInsets(top: sideSpacing, leading: sideSpacing, bottom: 0, trailing: sideSpacing)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.2))
            , subitem: item, count: 1)
        let padding = CGFloat(8)
        group.interItemSpacing = .fixed(padding)
        group.contentInsets = NSDirectionalEdgeInsets(
        top: 0, leading: padding, bottom: 0, trailing: padding
        )
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = padding
        section.contentInsets = NSDirectionalEdgeInsets(top: padding, leading: 0, bottom: padding, trailing: 0)
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == mySpotsCollView {
            print("count my spot cell")
            return mySpots.count
        } else {
            print("count favo spot cell")
            return favoSpots.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == mySpotsCollView {
            print("load my spot cell")
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mySpotCell", for: indexPath) as! SpotDetailCollectionViewCell
            cell.setSpot(spot: self.mySpots[indexPath.item])
            cell.contentView.layer.cornerRadius = 8
            cell.contentView.layer.masksToBounds = true
            cell.layer.masksToBounds = false
            cell.setShadowElevation(ShadowElevation(rawValue: 8), for: .normal)
            cell.applyTheme(withScheme: Theme.globalContainerSheme())
            
            return cell
        } else {
            print("load favo spot cell")
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "favoSpotCell", for: indexPath) as! SpotDetailCollectionViewCell
            cell.setSpot(spot: self.favoSpots[indexPath.item])
            cell.contentView.layer.cornerRadius = 8
            cell.contentView.layer.masksToBounds = true
            cell.layer.masksToBounds = false
            cell.setShadowElevation(ShadowElevation(rawValue: 8), for: .normal)
            cell.applyTheme(withScheme: Theme.globalContainerSheme())
            
            return cell
        }

    }
    
    
}
