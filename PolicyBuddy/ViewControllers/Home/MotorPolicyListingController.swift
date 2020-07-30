//
//  MotorPolicyListingController.swift
//  PolicyBuddy
//
//  Created by Rupali on 20/07/2020.
//  Copyright © 2020 rghate. All rights reserved.
//

import UIKit

class MotorPolicyListingController: BaseCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    // MARK: Private properties
    
    private enum HeaderTitle: Int {
        case activeSection
        case historicSection
        
        var description: String {
            switch self {
            case .activeSection:
                return "Active policies"
            case .historicSection:
                return "Vehicles"
            }
        }
        
        var cellSize: CGFloat {
            switch self {
            case .activeSection:
                return 138
            case .historicSection:
                return 118
            }
        }
    }
    
//    private let screenText = applicationStrings
    
    private let cellId = "homeCellId"
    private let sectionHeaderId = "sectionHeaderId"
    private let emptyCellId = "emptyCellId"
    private let footerId = "footerId"
    
    private var footerView: CustomFooter?
    
    private let sectionHeaderHeight: CGFloat = 32
    
    private var activePolicyEntities = [EntityViewModel]()
    
    private var historicEntities: [EntityViewModel] = [EntityViewModel]()
    
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private lazy var screenText = appDelegate.applicationStrings?.strings.homepage

    // MARK: Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupRefreshControl()
        
        baseCellDelegate = self
        
        downloadPolicyData(refreshData: false)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: Private Methods
    
    override func setupViews() {
        super.setupViews()
        
        //register header cell
        collectionView.register(UINib(nibName: String(describing: SectionHeaderCell.self), bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: sectionHeaderId)
        
        //register footer cell
        collectionView.register(CustomFooter.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: footerId)
        
        collectionView.register(UINib(nibName: String(describing: HomeCell.self), bundle: nil), forCellWithReuseIdentifier: cellId)
        
        // empty cell
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: emptyCellId)
        
        contentInset.left = 8
        contentInset.right = 8
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
    }
    
    private func prepareBeforeDataDownload() {
        //show wait indicator
        footerView?.setMessage(withText: "Please wait", visibleWaitIndicator: true)
        
        historicEntities.removeAll()
        activePolicyEntities.removeAll()
        
        reloadCollectionView()
    }
    
    private func prepareAfterDataDownload(err: CustomError?) {
        self.filterEntities()
        
        DispatchQueue.main.async {
            if let err = err {
                CustomAlert.showAlert(withTitle: "Error", message: err.localizedDescription, viewController: (self.window?.rootViewController)!)
                self.footerView?.setMessage(withText: "Something is wrong 😢.\n\n Drag down to try again.", visibleWaitIndicator:  false)
            } else {
                //show wait indicator
                self.footerView?.resetMessage(visibleWaitIndicator: false)
            }
            self.reloadCollectionView()
        }
    }
    
    
    private func downloadPolicyData(refreshData: Bool) {
        prepareBeforeDataDownload()
        
        let viewModel = EntityViewModel()
        
        DispatchQueue.global(qos: .background).async {
            viewModel.fetchPolicies(loadFreshdata: refreshData) { result in
                self.endRefresh()
                
                var error: CustomError?
                
                switch result {
                case .failure(let err):
                    print("Error: ", err)
                    error = err
                    
                case .success(let vehicles):
                    print("Success: \(vehicles.keys)")
                    
                    // convert dictionary result into an array (for sorting)
                    self.historicEntities = vehicles.values.map{$0}
                    
                    //sort entities
                    self.historicEntities = self.historicEntities.sorted{ $0.make.rawValue < $1.make.rawValue }
                }
                self.prepareAfterDataDownload(err: error)
            }
        }
    }
    
    // Categorize entities between the ones containing active policies and the ones which doesn't
    private func filterEntities() {
        
        for entity in historicEntities {
            //active pollicies have its end-date(and time) greater than current date(and time)
            if let isActiveCount = entity.policies?.contains(where: { $0.endDate > Date() }) {
                if isActiveCount {
                    let newEntity = entity
                    activePolicyEntities.append(newEntity)
                    entity.hasActivePolicy = true
                } else {
                    entity.hasActivePolicy = false
                }
            }
        }
        historicEntities.removeAll { $0.hasActivePolicy }
    }
    
    private func refreshEntities() {
        activePolicyEntities.forEach { entity in
            // if there are no active policies in the entity
            guard let containsActivePolicy = entity.policies?.contains(where: {$0.endDate > Date()}) else { return }
            if (!containsActivePolicy) {
                // no active policy
                entity.hasActivePolicy = false
                // add the entity back in main entities array
                let newEntity = entity
                self.historicEntities.append(newEntity)
                self.historicEntities = self.historicEntities.sorted{ $0.make.rawValue < $1.make.rawValue }
            }
        }
        // remove thosee policies from activePolicyEntities which are not active anymore
        activePolicyEntities.removeAll{ $0.hasActivePolicy == false }
    }
    
    private func getSectionDescription(section: Int) -> String {
        if section == 0 {
            return screenText?.activeSectionTitle ?? HeaderTitle.activeSection.description
        } else {
            return screenText?.historicSectionTitle ?? HeaderTitle.activeSection.description
        }
    }

}


// MARK: Extensions

extension MotorPolicyListingController {
    
    // MARK: Collectionview Methods
    
    // section count
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return historicEntities.count > 0 ? 2 : 1
    }

    // item count in section
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section == 0 ? activePolicyEntities.count : (historicEntities.count)
    }
    
    // MARK: Collectionview Header and Footer Methods
    // header size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return historicEntities.count > 0 ? CGSize(width: collectionView.bounds.width, height: sectionHeaderHeight) :
            CGSize(width: collectionView.bounds.width, height: 0)
    }
    
    // footer size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if historicEntities.count > 0 {
            return CGSize(width: collectionView.frame.width, height: 0)
        } else {
            // if no data to display, display full screen footer to show either activity indicator or message for user
            return CGSize(width: collectionView.frame.width, height: 400)
        }
    }
    
    // header/footer cell
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: sectionHeaderId, for: indexPath) as! SectionHeaderCell
            
            // If there are no active policiees, use headerview to display the no-active-policiees message
            if indexPath.section == 0 && activePolicyEntities.count == 0 {
                header.text = NO_ACTIVE_POLICY
                header.label.textAlignment = .center
                
            }else {
                header.label.text = getSectionDescription(section: indexPath.section)
                header.label.textAlignment = .left
            }
            
            return header
        } else {
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: footerId, for: indexPath) as! CustomFooter
            
            self.footerView = footer
            
            return footer
        }
    }
        
    // MARK: Collectionview data cell Methods
    
    // cell size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = frame.width - (collectionView.contentInset.left + collectionView.contentInset.right)
        
        // height of active policy cell would be 1 if there are no active policies
        let height = indexPath.section == 0 ?
            activePolicyEntities.count == 0 ? 1 : HeaderTitle.activeSection.cellSize :
            HeaderTitle.historicSection.cellSize
        
        return CGSize(width: width,
                      height: height)
    }
        
    // item cell view
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //if there are no active policies, display an empty cell (just as a placeholder)
        if indexPath.section == 0 && activePolicyEntities.count == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: emptyCellId, for: indexPath)
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! HomeCell
        
        if indexPath.section == 0 {
            let entity = activePolicyEntities[indexPath.row]
            cell.cellData = entity
            cell.isActivePolicy = true
            
            let policy = entity.getActivePolicy()
            if let endDate = policy?.endDate {
                cell.delegate = self
                cell.beingCountdownAnimation(withendDate: endDate)
            }
        } else {
            cell.cellData = historicEntities[indexPath.row]
            cell.isActivePolicy = false
        }
        
        return cell
    }
    
    // cell selection
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Motor Policy Item selected...")
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "PolicyPagingController") as! PolicyPagingController
        
        vc.itemEntity = indexPath.section == 0 ? activePolicyEntities[indexPath.row] : historicEntities[indexPath.row]
        let navController = UINavigationController(rootViewController: vc)
        navigationController?.present(navController, animated: true)
    }
}


extension MotorPolicyListingController: BaseCellDelegate {
    func handleRefresh() {
        footerView?.setMessage(withText: "Please wait", visibleWaitIndicator: false)
        downloadPolicyData(refreshData: true)
    }
    
}

extension MotorPolicyListingController: HomeCellDelegate {
    // countdown complete delegate based on progrssbar delegate from HomeCell
    func countdownComplete() {
        refreshEntities()
        reloadCollectionView()
    }
}
