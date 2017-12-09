//
//  BeerManagerTests.swift
//  32099Tests
//
//  Created by Vinicius Torres on 12/8/17.
//  Copyright © 2017 Vinicius Torres. All rights reserved.
//

import XCTest
@testable import _2099
class BeerManagerTests: XCTestCase {
    
    var sut: BeerManager!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = BeerManager()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testBeerManager_ReturnsZero() {
        XCTAssertEqual(sut.returnBeersCount(), 0)
    }
    
    func testBeerManager_AddBeer() {
        let beer = Beer(imageUrl: "www.google.com.br", name: "cerveja", tagline: "cerveja da boa", abv: 1.0, ibu: nil, descriptionBeer: "cerveja gelada sempre é bom")
        sut.addBeer(beer: beer)
        
        let returnedBeer = sut.getBeerAtIndex(index: 0)
        XCTAssertEqual(beer.name,returnedBeer.name)
    }
    
}
