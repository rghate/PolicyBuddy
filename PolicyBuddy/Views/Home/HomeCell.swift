//
//  HomeCell.swift
//  PolicyBuddy
//
//  Created by Rupali on 16/07/2020.
//  Copyright © 2020 rghate. All rights reserved.
//

import UIKit
import Material


// MARK: Protocol

protocol HomeCellDelegate: class {
    func countdownComplete()
}


class HomeCell: BaseCardCell {
    
    // MARK: Public properties
    
    weak var delegate: HomeCellDelegate?
    
    var cellData: EntityViewModel? {
        didSet {
            if let cellData = cellData {
                logoImageView.image = UIImage(named: cellData.make.imageName)
                titleLabel.text = cellData.make.imageName.capitalized
                subtitleLabel.text = cellData.model
                leftDetailValue.text = cellData.prettyVrm
                rightDetailValue.text = "\(cellData.policies?.count ?? 0)"
            }
        }
    }
        
    var isActivePolicy: Bool? {
        didSet {
            if isActivePolicy == true {
                self.countdownProgressbar.isHidden = false
                self.policyButton.makePrimary()
                self.policyButton.setTitle(screenText?.extendCta ?? "Extend", for: .normal)
            } else {
                self.countdownProgressbar.isHidden = true
                self.policyButton.makeSecondary()
                self.policyButton.setTitle(screenText?.insureCta ?? "Insure", for: .normal)
            }
        }
    }
    
    @IBOutlet weak var logoImageView: UIImageView! {
        didSet {
            logoImageView.tintColor = Color.SUBTITLE_COLOR
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.textColor = Color.TITLE_COLOR
            titleLabel.font = UIFont(name: Fonts.sfTextBold, size: 16)
        }
    }
    
    @IBOutlet weak var subtitleLabel: UILabel! {
        didSet {
            subtitleLabel.textColor = Color.SUBTITLE_COLOR
            subtitleLabel.font = UIFont(name: Fonts.sfTextRegular, size: 13)
        }
    }
    
    @IBOutlet weak var leftDetailValue: UILabel! {
        didSet {
            leftDetailValue.textColor = Color.TEXT_GRAY_COLOR
            leftDetailValue.font = UIFont(name: Fonts.sfTextRegular, size: 13)
        }
    }
    
    @IBOutlet weak var rightDetailValue: UILabel! {
        didSet {
            rightDetailValue.textColor = Color.TEXT_GRAY_COLOR
            rightDetailValue.font = UIFont(name: Fonts.sfTextRegular, size: 13)
        }
    }
    
    @IBOutlet weak var vrmLabel: UILabel! {
        didSet {
            vrmLabel.textColor = Color.TEXT_GRAY_COLOR
            vrmLabel.font = UIFont(name: Fonts.sfTextRegular, size: 13)
            if let text = screenText?.vrmLabel {
                vrmLabel.text = text
            }
        }
    }
    
    @IBOutlet weak var policyCountLabel: UILabel!  {
        didSet {
            policyCountLabel.textColor = Color.TEXT_GRAY_COLOR
            policyCountLabel.font = UIFont(name: Fonts.sfTextRegular, size: 13)
            if let text = screenText?.policyCountLabel {
                policyCountLabel.text = text
            }
        }
    }
    
    @IBOutlet weak var policyButton: PBCapsulButton! {
        didSet {
            policyButton.setTitleColor(Color.PRIMARY_BUTTON_TEXT_COLOR, for: .normal)
            policyButton.titleLabel?.font = UIFont(name: Fonts.sfTextRegular, size: 16)
        }
    }
    
    @IBOutlet weak var countdownProgressbar: CircularCountdownProgrssbar!
    
    @IBOutlet weak var progressbarHeightConstraint: NSLayoutConstraint!
    
    
    // MARK: Private properties

    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private lazy var screenText = appDelegate.applicationStrings?.strings.homepage
    
    
    // MARK: Public Methods
    
    func beingCountdownAnimation(withendDate endDate: Date) {
        countdownProgressbar.delegate = self
        countdownProgressbar.animate(withendDate: endDate)
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
    @IBAction func handlePolicyAction(_ sender: Any) {
        print("handlePolicyAction")
    }
}

// MARK: Extensions

extension HomeCell: CountdownProgressDelegate {
    
    func counDownProgressUpdate(time: Int, type: String) {
    }
    
    func countdownComplete() {
        delegate?.countdownComplete()
    }
}
