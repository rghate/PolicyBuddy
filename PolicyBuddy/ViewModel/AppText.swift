//
//  AppText.swift
//  PolicyBuddy
//
//  Created by Rupali on 30/07/2020.
//  Copyright © 2020 rghate. All rights reserved.
//

import Foundation

struct AppText: Decodable {
    var strings: strings
    
    struct strings: Decodable {
        let global: global
        let homepage: homepage
        let policyDetail: policyDetail
        let motor: motor
    }
}

struct global: Decodable {
    let pricing: pricing
    
    struct  pricing: Decodable {
        let commissionExpl: String
        let extraFees: String
        let ipt: String
        let title: String
        let totalPayable: String
        let totalPremium: String
    }
}

struct homepage: Decodable {
    let activeSectionTitle: String
    let historicSectionTitle: String
    let insureCta: String
    let extendCta: String
    let vrmLabel: String
    let policyCountLabel: String
    let timeRemainingLabel: String
}

struct policyDetail: Decodable {
    let title : String
    let policyCountLabel: String
    let insureCta: String
    let extendCta: String
    let activeSectionTitle: String
    let historicSectionTitle: String
}

struct motor: Decodable {
    let policyExpiry: String
    let policyExpiryWarning: String
    let pricing: pricing
    
    struct pricing: Decodable {
        let extraFees: String
        let ipt: String
        let title: String
        let totalPayable: String
        let totalPremium: String
    }
}

