//
//  spotDetailCollectionViewCellContent.swift
//  dropspot
//
//  Created by Bert Van eeckhoutte on 09/01/2021.
//

import UIKit

class spotDetailCollectionViewCellContent: UIView {

    let nibName = "SpotDetailCollectionViewCellContent"
    
    @IBOutlet var spotNameLbl: UILabel!
    @IBOutlet var spotLocationLbl: UILabel!
    @IBOutlet var imgRank: UIImageView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    func commonInit() {
        guard let view = loadViewFromNib() else { return }
        view.frame = self.bounds
        self.addSubview(view)
    }

    func loadViewFromNib() -> UIView? {
        let nib = UINib(nibName: nibName, bundle: nil)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
    func setSpotDetail(spotDetail: SpotDetail){
        updateUI(with: spotDetail)
    }
    
    private func updateUI(with spotDetail: SpotDetail){
        spotNameLbl.text = spotDetail.spotName.capitalized
        spotLocationLbl.text = spotDetail.locationString
        imgRank.image = UIImage(named: String(spotDetail.rank))
    }

}
