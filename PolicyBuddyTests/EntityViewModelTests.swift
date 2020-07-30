//
//  EntityViewModelTests.swift
//  PolicyBuddyTests
//
//  Created by Rupali on 29/07/2020.
//  Copyright © 2020 rghate. All rights reserved.
//

import Foundation
import XCTest

@testable import PolicyBuddy

class EntityViewModelTests: XCTestCase {
    
    override func setUp() {
    }
    
    override func tearDown() {
        
    }
    
    func testEntityViewModel() {
        
        let vrm: String = "LB07SEO"
        let prettyVrm: String = "LB07 SEO"
        let make: String = "Volkswagen"
        let model: String = "Polo"
        let variant: String? = "SE 16V"
        let color: String = "Silver"
        let policies: [Policy] = [Policy]()
        
        let vehicleData: [String: Any] = ["vrm": vrm, "prettyVrm": prettyVrm, "make": make, "model": model, "variant": variant!, "color": color, "policies": policies]

        let entityViewModel = EntityViewModel(vehicle: Vehicle(dictionary: vehicleData)!)
        
        XCTAssertEqual(entityViewModel.vrm, vrm)
        XCTAssertEqual(entityViewModel.prettyVrm, prettyVrm)
        XCTAssertEqual(entityViewModel.make, EntityViewModel.Make.volkswagen)
        XCTAssertEqual(entityViewModel.model, model)
        XCTAssertEqual(entityViewModel.variant, variant)
        XCTAssertEqual(entityViewModel.color, color)
    }
    
    func testMake() {
        
        let ford = "ford"
        let mercedes = "mercedes-benz"
        let mini = "mini"
        let nissan = "nissan"
        let volkswagen = "volkswagen"
        
        XCTAssertEqual(EntityViewModel.Make.ford.rawValue, "ford")
        XCTAssertEqual(EntityViewModel.Make.mercedes.rawValue, "mercedes-benz")
        XCTAssertEqual(EntityViewModel.Make.mini.rawValue, "mini")
        XCTAssertEqual(EntityViewModel.Make.nissan.rawValue, "nissan")
        XCTAssertEqual(EntityViewModel.Make.volkswagen.rawValue, "volkswagen")
        
        XCTAssertEqual(EntityViewModel.Make(rawValue: ford)?.imageName, IMG_FORD)
        XCTAssertEqual(EntityViewModel.Make(rawValue: mercedes)?.imageName, IMG_MERCEDES)
        XCTAssertEqual(EntityViewModel.Make(rawValue: mini)?.imageName, IMG_MINI)
        XCTAssertEqual(EntityViewModel.Make(rawValue: nissan)?.imageName, IMG_NISSAN)
        XCTAssertEqual(EntityViewModel.Make(rawValue: volkswagen)?.imageName, IMG_VOLKSWAGEN)
    }
    
    
}
