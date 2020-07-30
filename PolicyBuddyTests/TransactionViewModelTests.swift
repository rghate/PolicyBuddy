//
//  TransactionViewModelTests.swift
//  PolicyBuddyTests
//
//  Created by Rupali on 29/07/2020.
//  Copyright © 2020 rghate. All rights reserved.
//

import XCTest

@testable import PolicyBuddy

class TransactionViewModelTests: XCTestCase {
    
    override func setUp() {
        
    }
    
    override class func tearDown() {
        
    }
    
    func testTransactionViewModelForValidData() {
        
        let timestamp = "2019-01-18T10:15:29.979Z"
        
        let pricingPayload: [String: Double] = ["underwriter_premium": 499,
                                                "commission": 166,
                                                "total_premium": 665,
                                                "ipt": 80,
                                                "ipt_rate": 1200,
                                                "extra_fees": 125,
                                                "vat": 0,
                                                "deductions": 0,
                                                "total_payable": 870
        ]
        
        let payload: [String: Any] = ["policy_id": "dev_pol_000000BansDm7Jjbj3k4R1IUJwrEe",
                                      "pricing": pricingPayload]
        
        let transaction = Transaction(timestamp: timestamp, payload: payload)
        XCTAssertNotNil(transaction)
        
        let transactionVM = TransactionViewModel(transaction: transaction)
        XCTAssertNotNil(transactionVM)
        
        XCTAssertEqual(transactionVM?.pricing.underwriterPremium, 499)
        XCTAssertEqual(transactionVM?.pricing.commission, 166)
        XCTAssertEqual(transactionVM?.pricing.totalPremium, 665)
        XCTAssertEqual(transactionVM?.pricing.ipt, 80)
        XCTAssertEqual(transactionVM?.pricing.iptRate, 1200)
        XCTAssertEqual(transactionVM?.pricing.extraFees, 125)
        XCTAssertEqual(transactionVM?.pricing.vat, 0)
        XCTAssertEqual(transactionVM?.pricing.deductions, 0)
        XCTAssertEqual(transactionVM?.pricing.totalPayable, 870)
    }
    
    func testTransactionViewModelForInvalidData() {
        
        let pricingPayload: [String: Double] = [:]
        
        
        // with invalid timestamp
        
        let payload: [String: Any] = ["policy_id": "dev_pol_000000BansDm7Jjbj3k4R1IUJwrEe",
                                      "pricing": pricingPayload]
        
        let invalidTimestamp = ""  // should not be empty
        
        var transaction = Transaction(timestamp: invalidTimestamp, payload: payload)
        XCTAssertNil(transaction)
        
        var transactionVM = TransactionViewModel(transaction: transaction)
        XCTAssertNil(transactionVM)
        
        // with invalid policy ID
        
        let invalidPolicyId = ""    // should not be empty
        
        let invalidPayload: [String: Any] = ["policy_id": invalidPolicyId,
                                             "pricing": pricingPayload]
        
        let timestamp = "2019-01-18T10:15:29.979Z"
        
        transaction = Transaction(timestamp: timestamp, payload: invalidPayload)
        XCTAssertNil(transaction)
        
        transactionVM = TransactionViewModel(transaction: transaction)
        XCTAssertNil(transactionVM)
    }
}
