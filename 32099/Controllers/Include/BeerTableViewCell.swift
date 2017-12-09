//
//  BeerTableViewCell.swift
//  32099
//
//  Created by Vinicius Torres on 11/21/17.
//  Copyright © 2017 Vinicius Torres. All rights reserved.
//

import UIKit
import Kingfisher

class BeerTableViewCell: UITableViewCell {
    
    @IBOutlet weak var beerImageIV: UIImageView!
    @IBOutlet weak var beerNameLbl: UILabel!
    @IBOutlet weak var beerABVLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func prepare(beer: Beer) {
        
        beerImageIV.kf.indicatorType = .activity
        let resource = ImageResource(downloadURL: URL(string: beer.image_url)!, cacheKey: beer.name)
        beerImageIV.kf.setImage(with: resource, placeholder: nil, options: nil, progressBlock: { (received, total) in
            self.beerImageIV.kf.indicator?.startAnimatingView()
        }, completionHandler: { (image, error, cache, url) in
            self.beerImageIV.kf.indicator?.stopAnimatingView()
        })
        self.beerNameLbl.text = beer.name
        self.beerABVLbl.text = String(format: "%.1f", beer.abv)
        
    }

}
