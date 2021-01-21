//
//  SpotCollectionViewController.swift
//  spotWebTest
//
//  Created by Bert Van eeckhoutte on 25/12/2020.
//

import UIKit
import MaterialComponents

class SpotsCollectionViewController: UICollectionViewController, UISearchResultsUpdating {

    private let spotRepository = SpotDetailRepository()
    private let searchController = UISearchController(searchResultsController: nil)
    private var spots : [SpotDetail] = []
    lazy var filteredItems: [SpotDetail] = []
    var selectedSpot: SpotDetail?

    override func viewDidLoad() {
        super.viewDidLoad()

        // set false bcs presenting in the same VC
        searchController.obscuresBackgroundDuringPresentation = false
        // searchController
        searchController.searchResultsUpdater = self
        navigationItem.searchController = self.searchController
        collectionView.setCollectionViewLayout(genLayout(), animated: false)
        
        // load spots locally and fetch
        if let localSpots = spotRepository.getSpotDetails(){
            print("local spots response:")
            localSpots.forEach { spot in
                print(spot.description)
            }
            updateUI(withSpots: localSpots)
        } else {
            // TODO: start progress anim
            print("no local spots")
        }
        
        
        fetchSpots()
    }
    
    private func genLayout() -> UICollectionViewLayout {
        // spacing
        
        // size and count
        let itemsize  = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item   = NSCollectionLayoutItem(layoutSize: itemsize)
        //item.contentInsets =  NSDirectionalEdgeInsets(top: sideSpacing, leading: sideSpacing, bottom: 0, trailing: sideSpacing)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1/3))
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
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchString = searchController.searchBar.text,
           searchString.isEmpty == false {
            filteredItems = spots.filter{ (item) -> Bool in
                item.spotName.localizedCaseInsensitiveContains(searchString)
            }
        } else {
            filteredItems = spots
        }
        collectionView.reloadData()
    }
    
    private func updateUI(withSpots spots: [SpotDetail]){
        DispatchQueue.main.async {
            spots.forEach{ incomingSpot in
                
                if (!self.spots.contains(where: {spot in spot.spotId == incomingSpot.spotId})){
                    print("adding spot...")
                    self.spots.append(incomingSpot)
                }
            }
            self.filteredItems = self.spots
            self.collectionView.reloadData()
        }
    }
    
    private func fetchSpots(){
        spotRepository.fetchSpotDetails { (res) in
            switch res {
            case .success(let spots):
                self.updateUI(withSpots: spots)
                self.spotRepository.resetSpotDetailsInLocalDir()
                self.spotRepository.saveSpotDetailsInLocalDir(spots: spots)
            case .failure(let error):
                self.displayError(error)
            }
        }
    }
    
    private func displayError(_ error: Error){
        showSnackBar(message: error.localizedDescription)
    }

    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return filteredItems.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "spotCell", for: indexPath) as! SpotDetailCollectionViewCell
        cell.setSpot(spot: self.filteredItems[indexPath.item])
        cell.contentView.layer.cornerRadius = 8
        cell.contentView.layer.masksToBounds = true
        cell.layer.masksToBounds = false
        cell.setShadowElevation(ShadowElevation(rawValue: 8), for: .normal)
        cell.applyTheme(withScheme: Theme.globalContainerSheme())
        
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedSpot = self.filteredItems[indexPath.item]
        performSegue(withIdentifier: "toSpotDetail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toSpotDetail"){
            let dest = segue.destination as! SpotDetailViewController
            if let spot = selectedSpot {
                dest.spotDetail = spot
            }
        }
    }

}
