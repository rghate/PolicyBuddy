//
//  PBButton.swift
//  PolicyBuddy
//
//  Created by Rupali on 17/07/2020.
//  Copyright © 2020 rghate. All rights reserved.
//

import UIKit
import Material

class PBButton: FlatButton {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func makePrimary() {
        self.backgroundColor = Color.PRIMARY_CTA_COLOR
        self.pulseColor = Color.PRIMARY_CTA_COLOR
        
        self.setTitleColor(Color.PRIMARY_BUTTON_TEXT_COLOR, for: .normal)
        
        self.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
//        self.titleLabel?.font = UIFont(name: FONT_BOLD, size: 16)
    }
    
    func makeSecondary() {
        self.backgroundColor = Color.PRIMARY_BACKGROUND_COLOR
        self.pulseColor =  Color.TEXT_HIGHLIGHT_COLOR
        self.setTitleColor(Color.TEXT_HIGHLIGHT_COLOR, for: .normal)
        
        self.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
//        self.borderColor = TEXT_HIGHLIGHT_COLOR
//        self.titleLabel?.font = UIFont(name: FONT_BOLD, size: 16)
    }
}

class PBCapsulButton: PBButton {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // set appropriate corner rasius based on button height
        (self as UIButton).layer.cornerRadius = self.frame.height / 2
        self.pulseOpacity = 0.02
    }
}

class PBRoundedRectButton: PBButton {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // set appropriate corner rasius based on button height
        (self as UIButton).layer.cornerRadius = 8
        self.pulseOpacity = 0.02
    }
}


//class PBCapsulButtonPrimary: PBCapsulButton {
//
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//
//        self.backgroundColor = PRIMARY_CTA_COLOR
//        self.pulseColor = PRIMARY_CTA_COLOR
//
//        self.setTitleColor(PRIMARY_BUTTON_COLOR, for: .normal)
//
//        self.titleLabel?.font = UIFont(name: FONT_BOLD, size: 16)
//    }
//
//}
//
//class PBCapsulButtonSecondary: PBCapsulButton {
//
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//
//        self.backgroundColor = TEXT_HIGHLIGHT_COLOR
//        self.pulseColor =  TEXT_HIGHLIGHT_COLOR ?? UIColor.gray
//        self.setTitleColor(SECONDARY_BUTTON_TEXT_COLOR, for: .normal)
//
//        self.titleLabel?.font = UIFont(name: FONT_BOLD, size: 16)
//    }
//}



