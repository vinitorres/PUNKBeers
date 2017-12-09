//
//  DetailsViewController.swift
//  32099
//
//  Created by Vinicius Torres on 11/21/17.
//  Copyright © 2017 Vinicius Torres. All rights reserved.
//

import UIKit
import Kingfisher

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var imageIv: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var taglineLbl: UILabel!
    @IBOutlet weak var abvLbl: UILabel!
    @IBOutlet weak var ibuLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    
    var beer: Beer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadValues()
    }
    
    func loadValues() {
        
        if beer != nil {
            
            imageIv.kf.indicatorType = .activity
            
            let resource = ImageResource(downloadURL: URL(string: (beer?.image_url)!)!, cacheKey: beer?.name)
            let name = beer?.name
            let tagline = beer?.tagline
            let abv = beer?.abv.description
            let ibu = beer?.ibu.description
            let descriptionBeer = beer?.descriptionBeer
            
            
            imageIv.kf.setImage(with: resource, placeholder: nil, options: nil, progressBlock: { (received, total) in
                self.imageIv.kf.indicator?.startAnimatingView()
            }, completionHandler: { (image, error, cache, url) in
                self.imageIv.kf.indicator?.stopAnimatingView()
            })
            
            nameLbl.text = name
            taglineLbl.text = tagline
            abvLbl.text = abv
            
            if ibu == "0.0" {
                ibuLbl.text = "Não disponivel"
            } else {
                ibuLbl.text = ibu
            }
            
            descriptionLbl.text = descriptionBeer
            
        }
        
    }
    
    
}

