//
//  TransactionViewModel.swift
//  PolicyBuddy
//
//  Created by Rupali on 27/07/2020.
//  Copyright © 2020 rghate. All rights reserved.
//

import Foundation

struct TransactionViewModel {
    let policyId: String
    let timestamp: Date
    let pricing: Pricing
    
    init?(transaction: Transaction?) {
        guard let policyId = transaction?.policyId,
            let  timestamp = transaction?.timestamp,
            let pricing = transaction?.pricing else { return nil }

        self.policyId = policyId
        self.timestamp = timestamp
        
        self.pricing = Pricing(pricing: pricing)
    }
}

struct Pricing {
    let underwriterPremium: Double
    let commission: Double
    let totalPremium: Double
    let ipt: Double
    let iptRate: Double
    let extraFees: Double
    let vat: Double
    let deductions: Double
    let totalPayable: Double
    
    init(pricing: PricingPayload) {
        self.underwriterPremium = pricing.underwriterPremium
        self.commission = pricing.commission
        self.totalPremium = pricing.totalPremium
        self.ipt = pricing.ipt
        self.iptRate = pricing.iptRate
        self.extraFees = pricing.extraFees
        self.vat = pricing.vat
        self.deductions = pricing.deductions
        self.totalPayable = pricing.totalPayable
    }
    
    enum Properties: String {
        case underwriterPremium = "Underwriter Premium"
        case commission = "Commission"
        case totalPremium = "Total Premium"
        case ipt = "IPT"
        case iptRate = "IPT Rate"
        case extraFees = "Extra Fees"
        case vat = "VAT"
        case deductions = "Deductions"
        case totalPayable = "Total Payable"
        
        var prettyName: String {
            return self.rawValue
        }
    }
    
    var displayable: [(text: String, value: Double)] {
        return [ (Properties.underwriterPremium.prettyName, underwriterPremium),
                 (Properties.commission.prettyName, commission),
                 (Properties.totalPremium.prettyName, totalPremium),
                 (Properties.ipt.prettyName, ipt),
                 (Properties.iptRate.prettyName, iptRate),
                 (Properties.extraFees.prettyName, extraFees),
                 (Properties.vat.prettyName, vat),
                 (Properties.deductions.prettyName, deductions),
                 (Properties.totalPayable.prettyName, totalPayable)]
        
    }
}
