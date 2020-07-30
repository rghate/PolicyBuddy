//
//  PricingViewModelTests.swift
//  PolicyBuddyTests
//
//  Created by Rupali on 29/07/2020.
//  Copyright © 2020 rghate. All rights reserved.
//

import XCTest

@testable import PolicyBuddy

class PricingViewModelsTests: XCTestCase {
    
    override func setUp() {
        
    }
    
    override class func tearDown() {
        
    }
    
    func testPricingViewModelForZeroValues() {
        let pricingPayload = PricingPayload(dictionary: [:])
        
        XCTAssertNotNil(pricingPayload)
        
        let pricing = Pricing(pricing: pricingPayload!)
        
        XCTAssertNotNil(pricing)
        
        XCTAssertNotNil(pricing.underwriterPremium)
        XCTAssertNotNil(pricing.commission)
        XCTAssertNotNil(pricing.totalPremium)
        XCTAssertNotNil(pricing.ipt)
        XCTAssertNotNil(pricing.iptRate)
        XCTAssertNotNil(pricing.extraFees)
        XCTAssertNotNil(pricing.vat)
        XCTAssertNotNil(pricing.deductions)
        XCTAssertNotNil(pricing.totalPayable)
        
        XCTAssertEqual(pricing.underwriterPremium, 0)
        XCTAssertEqual(pricing.commission, 0)
        XCTAssertEqual(pricing.totalPremium, 0)
        XCTAssertEqual(pricing.ipt, 0)
        XCTAssertEqual(pricing.iptRate, 0)
        XCTAssertEqual(pricing.extraFees, 0)
        XCTAssertEqual(pricing.vat, 0)
        XCTAssertEqual(pricing.deductions, 0)
        XCTAssertEqual(pricing.totalPayable, 0)
        
    }
    
    func testPricingViewModelForNonZeroValues() {
        
        let payload: [String: Double] = ["underwriter_premium": 499,
                                         "commission": 166,
                                         "total_premium": 665,
                                         "ipt": 80,
                                         "ipt_rate": 1200,
                                         "extra_fees": 125,
                                         "vat": 0,
                                         "deductions": 0,
                                         "total_payable": 870
        ]
        
        let pricingPayload = PricingPayload(dictionary: payload)
        
        XCTAssertNotNil(pricingPayload)
        
        let pricing = Pricing(pricing: pricingPayload!)
        
        XCTAssertNotNil(pricing)
        
        XCTAssertEqual(pricing.underwriterPremium, 499)
        XCTAssertEqual(pricing.commission, 166)
        XCTAssertEqual(pricing.totalPremium, 665)
        XCTAssertEqual(pricing.ipt, 80)
        XCTAssertEqual(pricing.iptRate, 1200)
        XCTAssertEqual(pricing.extraFees, 125)
        XCTAssertEqual(pricing.vat, 0)
        XCTAssertEqual(pricing.deductions, 0)
        XCTAssertEqual(pricing.totalPayable, 870)
    }
    
}
