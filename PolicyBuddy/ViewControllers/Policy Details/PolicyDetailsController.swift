//
//  PolicyDetailsController.swift
//  PolicyBuddy
//
//  Created by Rupali on 23/07/2020.
//  Copyright © 2020 rghate. All rights reserved.
//

import UIKit

class PolicyDetailsController: BaseCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    // MARK: Public properties
    
    var entityViewModel: EntityViewModel? {
        didSet {
            guard let entity = entityViewModel else { return }
            
            filterPolicies(entity: entity)
            reloadCollectionView()
        }
    }
    
    
    // MARK: Private properties
    
    private enum HeaderTitle: Int {
        case ActivePolicy
        case PreviousPolicies
        
        var description: String {
            switch self {
            case .ActivePolicy:
                return "Active driving policy"
            case .PreviousPolicies:
                return "Previous driving policies"
            }
        }
        
        var cellHeight: CGFloat {
            switch self {
            case .ActivePolicy:
                return 160
            case .PreviousPolicies:
                return 45
            }
        }
    }
    
    private var activePolicy: PolicyViewModel?
    
    private var previousPolicies = [PolicyViewModel]()
    
    private var isActivePolicyAvailable: Bool = false
    
    private let activePolicyCellId = "policyCellId"
    
    private let previousPolicyCellId = "previousPolicyCellId"
    
    private let emptyCellId = "emptyCellId"
    
    private let sectionHeaderId = "sectionHeaderId"
    
    private let numberOfSections: Int = 2
    
    private let sectionHeaderHeight: CGFloat = 22
    
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private lazy var screenText = appDelegate.applicationStrings?.strings.policyDetail

    
    // MARK: Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupViews() {
        super.setupViews()
        
        collectionView.register(UINib(nibName: String(describing: SectionHeaderCell.self), bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: sectionHeaderId)
        
        collectionView.register(UINib(nibName: String(describing: ActivePolicyCell.self), bundle: nil), forCellWithReuseIdentifier: activePolicyCellId)
        collectionView.register(UINib(nibName: String(describing: PreviousPolicyCell.self), bundle: nil), forCellWithReuseIdentifier: previousPolicyCellId)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: emptyCellId)
        
        collectionView.showsVerticalScrollIndicator = false
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    
    // MARK: Collectionview Header Methods
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return numberOfSections
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: sectionHeaderHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: sectionHeaderId, for: indexPath) as! SectionHeaderCell
        
        // If there are no active policiees, use headerview to display the no-active-policiees message
        if indexPath.section == 0 && !isActivePolicyAvailable {
            header.text = NO_ACTIVE_POLICY
            header.label.textAlignment = .center
        }else {
            header.label.textAlignment = .left
            header.text = getSectionDescription(section: indexPath.section)
        }
        return header
    }
    
    
    // MARK: Collectionview item cell Methods
    
    // number of section items
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // in first section if there is any active policy return 1 item else 0
        if section == 0 {
            return isActivePolicyAvailable ? 1 : 0
        } else {
            return  previousPolicies.count
        }
    }
    
    // section insets
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 0 {
            return .init(top: 0, left: 10, bottom: 20, right: 10)
        } else {
            return .init(top: 0, left: 0, bottom: 0, right: 0)
        }
    }
    
    // line spacing
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    // cell size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = indexPath.section == 0 ? frame.width - (collectionView.contentInset.left + collectionView.contentInset.right) - 20 : frame.width
        
        // height of active policy cell would be 1 if there are no active policies
        let height = (indexPath.section == 0 && !isActivePolicyAvailable) ? 1 :
            indexPath.section == 0 ? HeaderTitle.ActivePolicy.cellHeight : HeaderTitle.PreviousPolicies.cellHeight
        
        return CGSize(width: width, height:height)
    }
    
    // cell item
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            //if there are no active policies, display an empty cell (just as a placeholder)
            if !isActivePolicyAvailable {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: emptyCellId, for: indexPath)
                return cell
            } else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: activePolicyCellId, for: indexPath) as! ActivePolicyCell
                
                let policy = activePolicy
                if let endDate = policy?.endDate {
                    cell.delegate = self
                    cell.beingCountdownAnimation(withendDate: endDate, showDefaultText: false)
                }
                return cell
            }
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: previousPolicyCellId, for: indexPath) as! PreviousPolicyCell
            
            let policies = previousPolicies
            let policy = policies[indexPath.row]
            cell.policy = policy
            return cell
        }
    }
    
    // cell selection
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "receiptController") as! ReceiptController
        
        let policy = indexPath.section == 0 ? self.activePolicy : self.previousPolicies[indexPath.row]
        vc.transaction = policy?.transactions
        vc.isPolicyVoided = policy?.isVoided ?? false
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    // MARK: Private Methods
    
    private func filterPolicies(entity: EntityViewModel) {
        guard let policies = entity.policies else { return }
        
        for policy in policies {
            if policy.isActive {
                self.activePolicy = policy
                isActivePolicyAvailable = true
            } else {
                self.previousPolicies.append(policy)
            }
        }
        previousPolicies.sort { $0.endDate > $1.endDate }
    }
    
    private func getSectionDescription(section: Int) -> String {
        if section == 0 {
            return screenText?.activeSectionTitle ?? HeaderTitle.ActivePolicy.description
        } else {
            return screenText?.historicSectionTitle ?? HeaderTitle.PreviousPolicies.description
        }
    }
}

// MARK: Extensions

extension PolicyDetailsController: ActivePolicyCellDelegate {
    func countdownComplete() {
        guard let policy = self.activePolicy else { return }
        
        isActivePolicyAvailable = false
        entityViewModel?.hasActivePolicy = false
        
        previousPolicies.append(policy)
        previousPolicies.sort { $0.endDate > $1.endDate }
        
        reloadCollectionView()
    }
}
