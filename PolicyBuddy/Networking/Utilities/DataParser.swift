//
//  DataParser.swift
//  PolicyBuddy
//
//  Created by Rupali on 25/07/2020.
//  Copyright © 2020 rghate. All rights reserved.
//

import Foundation

final class DataParser {
    static func parsePolicies(data: Data) throws -> [Policy] {
        var policies = [Policy]()
        
        do {
            let results: [[String: Any]] = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [[String: Any]]
            var policyIndex = -1
            
            
            for result in results {
                
                guard let type = result["type"] as? String else { continue }
                
                let timestamp = result["timestamp"] as? String
                
                if (type == "policy_created" || type == "policy_cancelled") {
                    policyIndex += 1
                    
                    if let payload = result["payload"] as? [String: Any] {
                        if type == "policy_cancelled" {
                            
                            let voidPolicy = Policy(policyType: .voided, timestamp: timestamp, payload: payload)
                            policies.append(voidPolicy!)
                        }
                        else {
                            if let policy = Policy(policyType: .valid, timestamp: timestamp, payload: payload) {
                                policies.append(policy)
                            }
                        }
                    }
                    
                } else if type == "policy_financial_transaction" {
                    if let payload = result["payload"] as? [String: Any] {
                        if let transaction = Transaction(timestamp: timestamp, payload: payload) {
                            if transaction.policyId == policies[policyIndex].policyId {
                                (policies[policyIndex]).policyFinancialTransaction = transaction
                            }
                        }
                    }
                }
            }
            
            // since server response has no vehicle details for VOID policy, below code searches valid policy whose policy id matches with void-policy,
            // and copies it's vehicle details to the VOID-policy vehicle to reflect it back in the main policies array.
            
            // get all the VOID-policies from the main policies array
            let voidedPolicies = policies.filter { $0.type == .voided }
            
            // iterate over every VOID policy to update its vehicle details.
            for vPolicy in voidedPolicies {
                // find matching valid policy for the VOID policy by comparing its policy id
                let matchingPolicy = policies.first(where: { $0.policyId == vPolicy.policyId && $0.type == .valid })
                // if foudn a matching valid policy
                if let matchingPolicy = matchingPolicy {
                    // get index of VOID-policy from the main policy array. This is to update the correct VOID policy vehicle details
                    let index = policies.firstIndex { policy -> Bool in
                        policy.type == .voided && policy.policyId == vPolicy.policyId
                    }
                    // assign vehicle details of other matching valid policy at the correct VOID-policy index in main policies array
                    policies[index!].vehicle = matchingPolicy.vehicle
                }
            }
        }
        return policies
    }
    
    static func groupPoliciesForEntity(policies: [Policy]) -> [String: Vehicle] {
        
        var groupedVehicles = [String: Vehicle]()    // vehicle number is the key
        
        // sort policies based on enddate
        let sortedPolicies = policies.sorted { $0.endDate > $1.endDate }
        
        sortedPolicies.forEach {policy in
            // check if entry for vehicl is present in the groupedVehicles dictionary.
            //If so, simply add policy in the policy array under the respectve vehicle.
            if groupedVehicles.keys.contains(policy.vehicle.vrm) {
                groupedVehicles[policy.vehicle.vrm]?.policies.append(policy)
            } else {
                // else make a new entry in to vehicle dictionary and add policy
                groupedVehicles[policy.vehicle.vrm] = policy.vehicle
                groupedVehicles[policy.vehicle.vrm]?.policies.append(policy)
            }
        }
        
        return groupedVehicles
    }
    
    static func parseStandardText(fromJsonObj jsonObj: Any) -> AppText? {
        
        var appText: AppText?
        if let data: Data = try? JSONSerialization.data(withJSONObject: jsonObj, options: .fragmentsAllowed) {
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                appText = try decoder.decode(AppText.self, from: data)
                
//                print(appText)
                
            } catch let err {
                print(err)
            }
        }
        return appText
    }
}
