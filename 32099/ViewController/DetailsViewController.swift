//
//  ViewController.swift
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func loadValues() {
        
        if beer != nil {
            
            let resource = ImageResource(downloadURL: URL(string: (beer?.image_url)!)!, cacheKey: beer?.name)
            let name = beer?.name
            let tagline = beer?.tagline
            let abv = beer?.abv
            let ibu = beer?.ibu
            let descriptionBeer = beer?.descriptionBeer
            
            imageIv.kf.setImage(with: resource)
            nameLbl.text = name
            taglineLbl.text = tagline
            abvLbl.text = abv?.description
            
            if ibu == 0.0 {
                ibuLbl.text = "Não disponivel"
            } else {
                ibuLbl.text = ibu?.description
            }
            
            descriptionLbl.text = descriptionBeer
            
        }
        
    }
    
    
}

