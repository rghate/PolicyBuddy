//
//  TravelPolicyListingController.swift
//  PolicyBuddy
//
//  Created by Rupali on 20/07/2020.
//  Copyright © 2020 rghate. All rights reserved.
//

import UIKit

class TravelPolicyListingController: BaseCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath)
    }
    
    
    // MARK: Private Properties
    

    private let footerId = "footerId"

    private let numberOfSections: Int = 1

    private let numberOfItemsInSection = 0
    
    
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
                
        collectionView.register(CustomFooter.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: footerId)
    
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    // MARK: Collectionview Header Methods
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height - 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let footerCell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: footerId, for: indexPath) as! CustomFooter
        
        footerCell.setMessage(withText: "Coming soon..", visibleWaitIndicator: false)
        
        return footerCell
        
    }
    
    
    // MARK: Collectionview item cell Methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfItemsInSection
    }

}
