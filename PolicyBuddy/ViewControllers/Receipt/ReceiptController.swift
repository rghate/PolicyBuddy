//
//  ReeceiptController.swift
//  PolicyBuddy
//
//  Created by Rupali on 24/07/2020.
//  Copyright © 2020 rghate. All rights reserved.
//

import UIKit

class ReceiptController: BaseController {
    
    // MARK: Public properties
    
    var transaction: TransactionViewModel? {
        didSet {
            guard let transaction = transaction else { return }
            
            headerData =  DateFormatter.dateFormatterWithShortTime.string(from: transaction.timestamp)
            cellData = transaction.pricing
            
            totalRowCount = transaction.pricing.displayable.count
        }
    }
    
    var isPolicyVoided: Bool = false
    
    @IBOutlet weak var bannerLabel: UILabel! {
        didSet {
            bannerLabel.textAlignment = .center
            bannerLabel.textColor = .white
            bannerLabel.backgroundColor = Color.ALERT_COLOR
            bannerLabel.font = UIFont.systemFont(ofSize: 11, weight: .bold)
        }
    }
    
    @IBOutlet weak var messageLabelHeightConstraint: NSLayoutConstraint! {
        didSet {
            messageLabelHeightConstraint.constant = 22
        }
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    // MARK: Private properties
    
    private var headerData: String?
    
    private var cellData: Pricing?
    
    private var totalRowCount: Int = 0
    
    private let receiptCellId = "receiptCellId"
    
    private let sectionHeaderId = "sectionHeaderId"
    
    private let numberOfSections: Int = 2
    
    private let sectionHeaderHeight: CGFloat = 50
    
    private let lastSectionHeaderHeight: CGFloat = 20
    
    private let cellHeight: CGFloat = 38
    
    
    // MARK: Initializers
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    
    // MARK: Private methods
    
    private func isLastSection(section: Int) -> Bool {
        return (section == numberOfSections - 1)
    }
    
    private func setupViews() {
        setupNavigationBar()
        
        bannerLabel.isHidden = isPolicyVoided ? false : true
        
        collectionView.backgroundColor = Color.PRIMARY_BACKGROUND_COLOR
        
        let headerNib = UINib(nibName: String(describing: SectionHeaderCell.self), bundle: nil)
        collectionView.register(headerNib, forSupplementaryViewOfKind:UICollectionView.elementKindSectionHeader , withReuseIdentifier: sectionHeaderId)
        let cellNib = UINib(nibName: String(describing: ReceiptCell.self), bundle: nil)
        collectionView.register(cellNib, forCellWithReuseIdentifier: receiptCellId)
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Receipt"
        
        customizeNavigationBar(backgroundColor: Color.PRIMARY_BACKGROUND_COLOR, tintColor: Color.TEXT_HIGHLIGHT_COLOR, titleColor: Color.NAVIGATIONBAR_BACKGROUND_COLOR)
        
        if #available(iOS 13.0, *) {
            // Left bar button item
            navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: IMG_ARROW_LEFT), style: .plain, target: self, action: #selector(handleClose))
            
            // Right bar button item
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: IMG_QUESTION_FILLED), style: .plain, target: self, action: #selector(handleHelp))
        } else {
            navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: IMG_ARROW_LEFT), style: .plain, target: self, action: #selector(handleClose))
            
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: IMG_QUESTION_FILLED), style: .plain, target: self, action: #selector(handleHelp))
        }
    }
    
    
    // MARK: Action Handlers
    
    @objc func handleClose() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func handleHelp() {
        print("Handle help")
    }
    
}

// MARK: Extensions

extension ReceiptController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: Collectionview Mathods
    // number of sections
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return numberOfSections
    }
    
    // MARK: Collectionview Header Methods
    // header size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        let height = isLastSection(section: section) ? lastSectionHeaderHeight : sectionHeaderHeight
        
        return CGSize(width: collectionView.bounds.width, height: height)
    }
    
    // header view
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: sectionHeaderId, for: indexPath) as! SectionHeaderCell
        
        // no text for last section header
        if indexPath.section == numberOfSections - 1 {
            header.text = ""
        }else {
            header.text = headerData
        }
        
        return header
    }
    
    // MARK: Collectionview item cell Methods
    // number of section items
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section == numberOfSections - 1 ? 1 : totalRowCount - 1
    }
    
    //section line spacing
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    //set size of cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width: CGFloat = view.frame.width
        let height = cellHeight
        
        return CGSize(width: width, height:height)
    }
    
    // item cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: receiptCellId, for: indexPath) as! ReceiptCell
        
        // if its a last section
        if indexPath.section == collectionView.numberOfSections - 1 {
            // change font weight to 'bold' for last row of each section or last row of the last section
            cell.isRowContentProminant = true
            
            cell.itemLabel.text = cellData?.displayable[totalRowCount - 1].text
            let amount = cellData?.displayable[totalRowCount - 1].value ?? 0
            cell.amountLabel.text = amount.toCurrency()
            
        } else {
            cell.itemLabel.text = cellData?.displayable[indexPath.row].text
            let amount = cellData?.displayable[indexPath.row].value ?? 0
            cell.amountLabel.text = amount.toCurrency()
        }
        
        return cell
    }
    
    // celll selection
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("row selected")
    }
}
