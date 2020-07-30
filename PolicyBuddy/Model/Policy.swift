//
//  Policy.swift
//  PolicyBuddy
//
//  Created by Rupali on 25/07/2020.
//  Copyright © 2020 rghate. All rights reserved.
//

import Foundation

enum PolicyType: Int {
    case valid
    case voided
}

struct Policy {
    var type: PolicyType
    let timestamp: String
    var policyId: String
    let originalPolicyId: String?
    let userId: String?
    let startDate: Date?
    let endDate: Date
    let incidentPhone: String?
    var vehicle: Vehicle
    var policyFinancialTransaction: Transaction?
    
    enum CodingKeys: String, CodingKey {
        case policyId = "policy_id"
        case originalPolicyId = "original_policy_id"
        case type = "type"
        case userId = "user_id"
        case timestamp = "timestamp"
        case startDate = "start_date"
        case endDate = "end_date"
        case incidentPhone = "incident_phone"
        case vehicle
    }
    
    init?(policyType: PolicyType, timestamp: String?, payload: [String: Any]) {
        
        guard let policyId = payload[CodingKeys.policyId.stringValue] as? String,
            let endDateStr = policyType == .valid ? payload[CodingKeys.endDate.stringValue] as? String : timestamp,
            let endDateObj = DateFormatter.dateFormatterWithLongTime.date(from: endDateStr),
            let timestamp = timestamp
            
            else { return nil }
        
        if policyType == .valid {
            guard let vehicleDictionary = payload[CodingKeys.vehicle.stringValue] as? [String: Any],
                let vehicle = Vehicle(dictionary: vehicleDictionary) else { return nil }
            self.vehicle = vehicle
        } else {
            // for voided types
            self.vehicle = Vehicle()
        }
        
        self.policyId = policyId
        self.originalPolicyId = payload[CodingKeys.originalPolicyId.stringValue] as? String
        self.userId = payload[CodingKeys.userId.stringValue] as? String
        
        if let startDateStr = payload[CodingKeys.startDate.stringValue] as? String,
            let startDateObj = DateFormatter.dateFormatterWithLongTime.date(from: startDateStr) {
            self.startDate = startDateObj
        } else {
            self.startDate = nil
        }
        
        self.endDate = endDateObj
        self.incidentPhone = payload[CodingKeys.incidentPhone.stringValue] as? String
        self.policyFinancialTransaction = nil
        self.timestamp = timestamp
        self.type = policyType
    }
}
