//
//  HomeHeaderView.swift
//  PolicyBuddy
//
//  Created by Rupali on 16/07/2020.
//  Copyright © 2020 rghate. All rights reserved.
//

import UIKit
import Material

// MARK: Protocol
@objc protocol HomeHeaderViewDelegate: class {
    func motorButtonPressed(sender: FlatButton)
    func travelButtonPressed(sender: FlatButton)
}

@IBDesignable
class HomeHeaderView: NibView {
    
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var motorButton: FlatButton! {
        didSet {
            motorButton.titleLabel?.font = UIFont(name: Fonts.sfTextBold, size: 15)
            motorButton.setTitleColor(Color.TEXT_HIGHLIGHT_COLOR, for: .normal)
        }
    }
    
    @IBOutlet weak var travelButton: FlatButton! {
        didSet {
            travelButton.titleLabel?.font = UIFont(name: Fonts.sfTextBold, size: 15)
            travelButton.setTitleColor(Color.TEXT_HIGHLIGHT_COLOR, for: .normal)
        }
    }
    
    
    // MARK: Public properties

    weak var delegate: HomeHeaderViewDelegate?
    
    
    // MARK: Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupViews()
    }
    
    
    // MARK: Private properties
    
    private func setupViews() {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        motorButton.layer.cornerRadius = 8
        travelButton.layer.cornerRadius = 8
        
        contentView.backgroundColor = Color.NAVIGATIONBAR_BACKGROUND_COLOR
        motorButton.tintColor = Color.SECONDARY_CTA_COLOR
        travelButton.tintColor = Color.SECONDARY_CTA_COLOR
    }
    
    
    // MARK: Action Handlers
    
    @IBAction func handleMotorButton(_ sender: FlatButton) {
        delegate?.motorButtonPressed(sender: sender)
    }
    
    @IBAction func handleTravelButton(_ sender: FlatButton) {
        delegate?.travelButtonPressed(sender: sender)
    }
    
}
