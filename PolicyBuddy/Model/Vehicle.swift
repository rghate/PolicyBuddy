//
//  Vehicle.swift
//  PolicyBuddy
//
//  Created by Rupali on 25/07/2020.
//  Copyright © 2020 rghate. All rights reserved.
//

import Foundation

struct Vehicle {
    let vrm: String
    let prettyVrm: String
    let make: String
    let model: String
    let variant: String?
    let color: String
    var policies: [Policy]
    
    enum CodingKeys: String, CodingKey {
        case vrm, prettyVrm, make, model, variant, color, policies
    }
    
    init() {
        vrm = ""
        prettyVrm = ""
        make = ""
        variant = ""
        model = ""
        color = ""
        
        policies = [Policy]()
    }
    
    init?(dictionary: [String: Any]) {
        guard let vrm = dictionary[CodingKeys.vrm.stringValue] as? String,
        let prettyVrm = dictionary[CodingKeys.prettyVrm.stringValue] as? String,
        let make = dictionary[CodingKeys.make.stringValue] as? String,
        let model = dictionary[CodingKeys.model.stringValue] as? String,
            let color = dictionary[CodingKeys.color.stringValue] as? String else {
                return nil
        }
        
        self.vrm = vrm
        self.prettyVrm = prettyVrm
        self.make = make
        self.model = model
        self.variant = dictionary[CodingKeys.variant.stringValue] as? String
        self.color = color
        self.policies = [Policy]()
    }
}
