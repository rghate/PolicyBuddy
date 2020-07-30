//
//  Transaction.swift
//  PolicyBuddy
//
//  Created by Rupali on 25/07/2020.
//  Copyright © 2020 rghate. All rights reserved.
//

import Foundation

struct Transaction {
    let policyId: String
    let timestamp: Date
    let pricing: PricingPayload
    
    enum CodingKeys: String, CodingKey {
        case pricing, timestamp, policyId = "policy_id"
    }
    
    init?(timestamp timestampStr: String?, payload: [String: Any]) {
        guard let timestampStr = timestampStr,
            let  policyId = payload[CodingKeys.policyId.stringValue] as? String, policyId.count > 0,
            let pricingObj = payload[CodingKeys.pricing.stringValue] as? [String: Any],
            let  pricing = PricingPayload(dictionary: pricingObj) else { return nil }
        
        guard let timestamp =  DateFormatter.dateFormatterWithLongTime.date(from: timestampStr) else { return nil }
        
        self.policyId = policyId
        self.timestamp = timestamp
        self.pricing = pricing
    }
}

struct PricingPayload {
    let underwriterPremium: Double
    let commission: Double
    let totalPremium: Double
    let ipt: Double
    let iptRate: Double
    let extraFees: Double
    let vat: Double
    let deductions: Double
    let totalPayable: Double
    
    enum CodingKeys: String, CodingKey {
        case commission, ipt, vat, deductions
        case underwriterPremium = "underwriter_premium"
        case totalPremium = "total_premium"
        case iptRate = "ipt_rate"
        case extraFees = "extra_fees"
        case totalPayable = "total_payable"

        var prettyName: String {
            return self.stringValue.makePretty()
        }
    }
    
    init?(dictionary: [String: Any]) {
        let  underwriterPremium = dictionary[CodingKeys.underwriterPremium.stringValue] as? Double ?? 0
        let  commission = dictionary[CodingKeys.commission.stringValue] as? Double ?? 0
        let  totalPremium = dictionary[CodingKeys.totalPremium.stringValue] as? Double ?? 0
        let  ipt = dictionary[CodingKeys.ipt.stringValue] as? Double ?? 0
        let  iptRate = dictionary[CodingKeys.iptRate.stringValue] as? Double ?? 0
        let  extraFees = dictionary[CodingKeys.extraFees.stringValue] as? Double ?? 0
        let  vat = dictionary[CodingKeys.vat.stringValue] as? Double ?? 0
        let  deductions = dictionary[CodingKeys.deductions.stringValue] as? Double ?? 0
        let  totalPayable = dictionary[CodingKeys.totalPayable.stringValue] as? Double ?? 0
        
        self.underwriterPremium = underwriterPremium
        self.commission = commission
        self.totalPremium = totalPremium
        self.ipt = ipt
        self.iptRate = iptRate
        self.extraFees = extraFees
        self.vat = vat
        self.deductions = deductions
        self.totalPayable = totalPayable
    }
}
