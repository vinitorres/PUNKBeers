//
//  Beer.swift
//  32099
//
//  Created by Vinicius Torres on 11/21/17.
//  Copyright © 2017 Vinicius Torres. All rights reserved.
//

import UIKit

struct Beer {
    
    let image_url: String
    let name: String
    let tagline: String
    let abv: Float
    let ibu: Float
    let descriptionBeer: String
    
    init(imageUrl: String, name: String, tagline: String, abv: Float?, ibu: Float?, descriptionBeer: String ) {
        self.image_url = imageUrl
        self.name = name
        self.tagline = tagline
        self.abv = abv ?? 0.0
        self.ibu = ibu ?? 0.0
        self.descriptionBeer = descriptionBeer
    }
}
