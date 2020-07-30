//
//  PolicyViewModelTests.swift
//  PolicyBuddyTests
//
//  Created by Rupali on 29/07/2020.
//  Copyright © 2020 rghate. All rights reserved.
//

import XCTest

@testable import PolicyBuddy

class PolicyViewModelTests: XCTestCase {
    
    override func setUp() {
        
    }
    
    override class func tearDown() {
        
    }
    
    func testPolicyViewModelWithValidData() {
        let vrm: String = "LB07SEO"
        let prettyVrm: String = "LB07 SEO"
        let make: String = "Volkswagen"
        let model: String = "Polo"
        let variant: String? = "SE 16V"
        let color: String = "Silver"
        let policies: [Policy] = [Policy]()
        
        let vehicleData: [String: Any] = ["vrm": vrm, "prettyVrm": prettyVrm, "make": make, "model": model, "variant": variant!, "color": color, "policies": policies]
        
        let payload: [String: Any] = ["user_id": "user_000000BSJ47k7mKYfWUhkWOrxLYGm",
                                      "policy_id": "dev_pol_000000BansDm7Jjbj3k4R1IUJwrEe",
                                      "original_policy_id": "dev_pol_000000BansDm7Jjbj3k4R1IUJwrEe",
                                      "start_date": "2019-01-18T10:15:30.000Z",
                                      "end_date": "2019-04-18T11:15:30.000Z",
                                      "incident_phone": "+442038287127",
                                      "vehicle": vehicleData
        ]
        
        
        
        let timestamp = "2019-01-18T10:15:29.979Z"
        
        let policy = Policy(policyType: PolicyType.valid, timestamp: timestamp, payload: payload)
        
        let policyVM = PolicyViewModel(policy: policy!)
        
        XCTAssertNotNil(policyVM)
        
        XCTAssertEqual(policyVM.userId, "user_000000BSJ47k7mKYfWUhkWOrxLYGm")
        XCTAssertEqual(policyVM.policyId, "dev_pol_000000BansDm7Jjbj3k4R1IUJwrEe")
        XCTAssertEqual(policyVM.originalPolicyId, "dev_pol_000000BansDm7Jjbj3k4R1IUJwrEe")
        XCTAssertEqual(policyVM.incidentPhone, "+442038287127")
        
        XCTAssertNotNil(policyVM.startDate)
        XCTAssertNotNil(policyVM.endDate)
        
        XCTAssertNil(policyVM.transactions)
    }
    
    func testPolicyViewModelWithInvalidVehicle() {
        let vehicleData: [String: Any] = [:]
        
        let payload: [String: Any] = ["user_id": "user_000000BSJ47k7mKYfWUhkWOrxLYGm",
                                      "policy_id": "dev_pol_000000BansDm7Jjbj3k4R1IUJwrEe",
                                      "original_policy_id": "dev_pol_000000BansDm7Jjbj3k4R1IUJwrEe",
                                      "start_date": "2019-01-18T10:15:30.000Z",
                                      "end_date": "2019-04-18T11:15:30.000Z",
                                      "incident_phone": "+442038287127",
                                      "vehicle": vehicleData
        ]
        
        let timestamp = "2019-01-18T10:15:29.979Z"
        
        let policy = Policy(policyType: PolicyType.valid, timestamp: timestamp, payload: payload)
        
        XCTAssertNil(policy)
    }
}
