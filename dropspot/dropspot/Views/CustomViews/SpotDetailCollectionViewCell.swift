//
//  SpotCellViewControllerCollectionViewCell.swift
//  spotWebTest
//
//  Created by Bert Van eeckhoutte on 25/12/2020.
//

import UIKit
import MaterialComponents

class SpotDetailCollectionViewCell: MDCCardCollectionCell {
        
    private var spot: SpotDetail? = nil
    
    func setSpot(spot: SpotDetail){
        self.spot = spot
        let view = contentView as! spotDetailCollectionViewCellContent
        view.setSpotDetail(spotDetail: spot)
    }

 
}
