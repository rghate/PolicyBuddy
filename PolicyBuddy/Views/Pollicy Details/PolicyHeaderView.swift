//
//  PolicyHeaderView.swift
//  PolicyBuddy
//
//  Created by Rupali on 22/07/2020.
//  Copyright © 2020 rghate. All rights reserved.
//

import UIKit
import Material

// MARK: Protocol

@objc protocol PolicyHeaderViewDelegate: class {
    func policyButtonPressed(sender: FlatButton)
}

@IBDesignable
class PolicyHeaderView: NibView {
    
    // MARK: Public Properties
    var cellData: EntityViewModel? {
        didSet {
            if let cellData = cellData {
                logoImageView.image = UIImage(named: cellData.make.imageName)
                titleLabel.text = "\(cellData.make.imageName.capitalized) \(cellData.model.capitalized) "
                subtitleLabel.text = cellData.prettyVrm
                totalPoliciesValueLabel.text = "\(cellData.policies?.count ?? 0)"
                
                if cellData.hasActivePolicy {
                    policyButton.isHidden =  false
                } else {
                    policyButton.isHidden =  true
                }
            }
        }
    }
    
    weak var delegate: PolicyHeaderViewDelegate?
    
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var logoContainerView: UIView! {
        didSet {
            logoContainerView.backgroundColor = .white
        }
    }
    
    @IBOutlet weak var logoImageView: UIImageView! {
        didSet {
            logoImageView.tintColor = Color.NAVIGATIONBAR_BACKGROUND_COLOR
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.textColor = Color.PRIMARY_BACKGROUND_COLOR
            titleLabel.font = UIFont(name: Fonts.sfTextRegular, size: 14)
        }
    }
    
    @IBOutlet weak var subtitleLabel: UILabel!{
        didSet {
            subtitleLabel.textColor = Color.PRIMARY_BUTTON_TEXT_COLOR
            subtitleLabel.font = UIFont(name: Fonts.sfTextBold, size: 20)
        }
    }
    
    @IBOutlet weak var totalPoliciesLabel: UILabel!{
        didSet {
            totalPoliciesLabel.textColor = Color.PRIMARY_BACKGROUND_COLOR
            totalPoliciesLabel.font = UIFont(name: Fonts.sfTextRegular, size: 12)
            if let text = screenText?.policyCountLabel {
                totalPoliciesLabel.text = text
            }
        }
    }
    
    @IBOutlet weak var totalPoliciesValueLabel: UILabel!{
        didSet {
            totalPoliciesValueLabel.textColor = Color.PRIMARY_BACKGROUND_COLOR
            totalPoliciesValueLabel.font = UIFont(name: Fonts.sfTextRegular, size: 12)
        }
    }
    
    @IBOutlet weak var policyButton: PBRoundedRectButton! {
        didSet {
            policyButton.titleLabel?.font = UIFont(name: Fonts.sfTextRegular, size: 15)
            
            if let text = screenText?.extendCta {
                policyButton.setTitle(text, for: .normal)
            }

        }
    }
    
    // MARK: Private Properties

    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private lazy var screenText = appDelegate.applicationStrings?.strings.policyDetail

    
    // MARK: Public Methods
    
    
    // MARK: Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupViews()
    }
    
    
    // MARK: Private Methods
    
    private func setupViews() {
        contentView.backgroundColor = Color.TEXT_HIGHLIGHT_COLOR
        policyButton.backgroundColor = Color.PRIMARY_BUTTON_COLOR
        policyButton.setTitleColor(Color.PRIMARY_BUTTON_TEXT_COLOR, for: .normal)
        
        logoContainerView.layer.cornerRadius = logoContainerView.frame.height / 2
        logoContainerView.clipsToBounds = true
    }
    
    
    // MARK: Action Handlers
    
    @IBAction func handlePolicyButton(_ sender: FlatButton) {
        delegate?.policyButtonPressed(sender: sender)
    }
}

