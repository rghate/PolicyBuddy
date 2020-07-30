//
//  ActivePolicyCell.swift
//  PolicyBuddy
//
//  Created by Rupali on 16/07/2020.
//  Copyright © 2020 rghate. All rights reserved.
//

import UIKit
import Material

// MARK: Protocol

protocol ActivePolicyCellDelegate: class {
    func countdownComplete()
}

class ActivePolicyCell: BaseCardCell {
    
    // MARK: Public properties
    
    weak var delegate: ActivePolicyCellDelegate?
    
    var endDate: Date?
    
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.textColor = Color.TITLE_COLOR
            titleLabel.text = "Active policy"
            titleLabel.font = UIFont(name: Fonts.sfTextBold, size: 13)
        }
    }
    
    @IBOutlet weak var messageLabel: UILabel! {
        didSet {
            messageLabel.textColor = Color.SUBTITLE_COLOR
            messageLabel.font = UIFont(name: Fonts.sfTextBold, size: 12)
        }
    }
    
    @IBOutlet weak var timeValueLabel: UILabel! {
        didSet {
            timeValueLabel.textColor = Color.TEXT_HIGHLIGHT_COLOR
            timeValueLabel.font = UIFont(name: Fonts.sfTextBold, size: 15)
        }
    }
    
    @IBOutlet weak var timeTypeLabel: UILabel! {
        didSet {
            timeTypeLabel.textColor = Color.TEXT_HIGHLIGHT_COLOR
            timeTypeLabel.font = UIFont(name: Fonts.sfTextRegular, size: 14)
        }
    }
    
    @IBOutlet weak var progressbar: CircularCountdownProgrssbar! {
        didSet {
            progressbar.circleSize = 45
        }
    }
    
    
    @IBOutlet weak var policyButton: PBRoundedRectButton! {
        didSet {
            policyButton.titleLabel?.font = UIFont(name: Fonts.sfTextBold, size: 14)
            policyButton.tintColor = Color.TEXT_HIGHLIGHT_COLOR
            policyButton.makeSecondary()
            
        }
    }
    
    @IBOutlet weak var helpButton: PBRoundedRectButton! {
        didSet {
            helpButton.makeSecondary()
            helpButton.tintColor = Color.ALERT_COLOR
            helpButton.setTitleColor(Color.ALERT_COLOR, for: .normal)
            helpButton.titleLabel?.font = UIFont(name: Fonts.sfTextBold, size: 14)
        }
    }
    
    @IBOutlet weak var progressbarHeightConstraint: NSLayoutConstraint!
    
    
    // MARK: Public Methods
    
    func beingCountdownAnimation(withendDate endDate: Date, showDefaultText: Bool) {
        progressbar.delegate = self
        progressbar.showDescriptionText = showDefaultText
        progressbar.animate(withendDate: endDate)
        
    }
    
    // MARK: Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setup()
    }
    
    // MARK: Private Methods
    
    private func setup() {
        tintColor = Color.NAVIGATIONBAR_BACKGROUND_COLOR
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    

    // MARK: Action Handlers
    
    @IBAction func handlePolicyDetailsAction(_ sender: Any) {
        print("Tapped policy details button.....")
    }
    
    @IBAction func handleHelp(_ sender: Any) {
        print("Tapped get help button.....")
    }
}


// MARK: Extension

extension ActivePolicyCell: CountdownProgressDelegate {
    func counDownProgressUpdate(time: Int, type: String) {
        timeValueLabel.text = "\(time)"
        
        timeTypeLabel.text = "\(type.lowercased())"
    }
    
    func countdownComplete() {
        delegate?.countdownComplete()
    }
}
