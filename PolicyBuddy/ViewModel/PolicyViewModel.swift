//
//  PolicyViewModel.swift
//  PolicyBuddy
//
//  Created by Rupali on 27/07/2020.
//  Copyright © 2020 rghate. All rights reserved.
//

import Foundation

struct PolicyViewModel {
    let isVoided: Bool
    var policyId: String
    let originalPolicyId: String?
    let userId: String?
    let startDate: Date?
    let endDate: Date
    let incidentPhone: String?
    var transactions: TransactionViewModel?
    
    init(policy: Policy) {
        self.policyId = policy.policyId
        self.originalPolicyId = policy.originalPolicyId
        self.userId = policy.userId
        self.startDate = policy.startDate
        self.endDate = policy.endDate
        self.incidentPhone = policy.incidentPhone
        self.transactions = TransactionViewModel(transaction: policy.policyFinancialTransaction)
        
        self.isVoided = policy.type == .voided
    }
}

extension PolicyViewModel {
    var isActive: Bool {
        self.endDate > Date()
    }
}
