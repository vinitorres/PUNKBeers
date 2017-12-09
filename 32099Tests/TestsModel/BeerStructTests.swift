//
//  BeerStructTests.swift
//  32099Tests
//
//  Created by Vinicius Torres on 12/8/17.
//  Copyright © 2017 Vinicius Torres. All rights reserved.
//

import XCTest
@testable import _2099
class BeerStructTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testInit_SetBeerParameters() {
        let beer = Beer(imageUrl: "www.google.com.br", name: "cerveja", tagline: "cerveja da boa", abv: 1.0, ibu: 4.3, descriptionBeer: "cerveja gelada sempre é bom")
        
        XCTAssertEqual(beer.name, "cerveja")
    }
    
    func testInit_SetBeerParametersWithoutIBU() {
        let beer = Beer(imageUrl: "www.google.com.br", name: "cerveja", tagline: "cerveja da boa", abv: 1.0, ibu: nil, descriptionBeer: "cerveja gelada sempre é bom")
        
        XCTAssertEqual(beer.ibu, 0.0)
    }
}
