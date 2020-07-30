//
//  Color.swift
//  PolicyBuddy
//
//  Created by Rupali on 16/07/2020.
//  Copyright © 2020 rghate. All rights reserved.
//

import UIKit

struct Color {
    static let PRIMARY_CTA_COLOR = UIColor(named: "primaryCTA") ?? UIColor.black

    static let SECONDARY_CTA_COLOR = UIColor(named: "secondaryCTA") ?? UIColor.black

    
    static let NAVIGATIONBAR_BACKGROUND_COLOR  = UIColor(hex: "#29198DFF") ?? UIColor.gray

    static let NAVIGATIONBAR_ITEM_TINT_COLOR = UIColor.white

    static let PRIMARY_BACKGROUND_COLOR = UIColor(hex: "#F1F1FEFF") ?? UIColor.white

    static let SECONDARY_BUTTON_TEXT_COLOR = SECONDARY_CTA_COLOR

    static let TITLE_COLOR = UIColor(hex: "#161656FF")

    static let SUBTITLE_COLOR = UIColor(hex: "#5D5DAEFF")

    static let TEXT_GRAY_COLOR = UIColor(hex: "#BCBCBCFF")

    static let TEXT_HIGHLIGHT_COLOR = UIColor(hex: "#5A55FFFF") ?? UIColor.blue

    static let PRIMARY_BUTTON_COLOR = UIColor(hex: "#1CC68CFF") ?? UIColor.blue

    static let PRIMARY_BUTTON_TEXT_COLOR = UIColor(hex: "#FFFFFFFF") ?? UIColor.white

    static let ALERT_COLOR = UIColor(hex: "E7423A") ?? UIColor.red

    static let WARNING_COLOR = UIColor(hex: "F8D858") ?? UIColor.yellow
}

