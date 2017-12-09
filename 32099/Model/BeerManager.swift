//
//  BeerManager.swift
//  32099
//
//  Created by Vinicius Torres on 12/8/17.
//  Copyright © 2017 Vinicius Torres. All rights reserved.
//

import Foundation

class BeerManager {

    private var beers: [Beer] = []
    
    func returnBeersCount() -> Int {
        return beers.count
    }
    
    func addBeer(beer: Beer) {
        beers.append(beer)
    }
    
    func getBeerAtIndex(index: Int) -> Beer {
        return beers[index]
    }
    
    func downloadBeersList(page: Int, onComplete: @escaping (_ success: Bool)->()) {
        
        Service.getBeers(page: page, onComplete: { resultBeers in
            
            var result = false
            
            guard let beersDownloaded = resultBeers else {
                print("Falha ao baixar os dados")
                onComplete(result)
                return
            }
            
            if beersDownloaded.count > 0 {
                for beer in beersDownloaded {
                    self.beers.append(beer)
                }
                result = true
            }
            
            
            onComplete(result)
        })
    }

}
