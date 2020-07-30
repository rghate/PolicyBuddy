//
//  HomeController.swift
//  PolicyBuddy
//
//  Created by Rupali on 17/07/2020.
//  Copyright © 2020 rghate. All rights reserved.
//

import UIKit
import Material

class HomeController: BasePagingController {
    
    // MARK: Public properties

    @IBOutlet weak var headerView: HomeHeaderView!
    
    @IBOutlet weak var headerViewHeightConstraint: NSLayoutConstraint!

    
    // MARK: Private properties
    
    private enum PageInfo: Int {
        case Page1
        case Page2
        
        var pageId: String {
            switch self {
            case .Page1:
                return "motorPolicyListingId"
            case .Page2:
                return "travelPolicyListingId"
            }
        }
        
        var pageBackground: UIColor {
            switch self {
            case .Page1:
                return Color.PRIMARY_BACKGROUND_COLOR
            case .Page2:
                return Color.PRIMARY_BACKGROUND_COLOR
            }
        }
    }
    
    private var numberOfItemsInSection: Int = 2
        
    private var headerHeightConstraint: NSLayoutConstraint?
        
    // MARK: Initializers

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupViews()
    }
    
    
    // MARK: Acction handlers
    
    @IBAction func handleHelp(_ sender: Any) {
        print("Tapped get help button.....")
    }
    
    @IBAction func handleUserProfile(_ sender: Any) {
        print("Tapped user profile button.....")
    }

    
    // MARK: Private Methods

    private func setupNavigationBar() {
        if #available(iOS 13.0, *) {
            // Left bar button item
            navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: IMG_USER), style: .plain, target: self, action: #selector(handleUserProfile))

            // Right bar button item
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: IMG_QUESTION_FILLED), style: .plain, target: self, action: #selector(handleHelp))
        } else {
            navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: IMG_USER), style: .plain, target: self, action: #selector(handleUserProfile))
            
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: IMG_QUESTION_FILLED), style: .plain, target: self, action: #selector(handleHelp))
        }
    }

    private func setupViews() {
        view.backgroundColor = UIColor.white
        headerView.delegate = self
        
        headerViewHeightConstraint.constant = 80
        
        // collectionview
        view.addSubview(mainCollectionView)
        mainCollectionView.anchor(top: headerView.bottomAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
        
        mainCollectionView.register(MotorPolicyListingController.self, forCellWithReuseIdentifier: PageInfo.Page1.pageId)
        mainCollectionView.register(TravelPolicyListingController.self, forCellWithReuseIdentifier: PageInfo.Page2.pageId)
        mainCollectionView.dataSource = self
    }

    private func setHeaderView(header: UIView?, withHeight height: CGFloat) {
        guard let header = header else { return }
        
        view.addSubview(header)
        
        header.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, size: CGSize(width: 0, height: height))
    }
}

// MARK: Extensions

extension HomeController: HomeHeaderViewDelegate {
    func motorButtonPressed(sender: FlatButton) {
        print("Motor button pressed")
        scroll(toPage: 0)
    }
    
    func travelButtonPressed(sender: FlatButton) {
        print("Travel button pressed")
        scroll(toPage: 1)
    }
}


extension HomeController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PageInfo(rawValue: indexPath.item)!.pageId, for: indexPath) as! BaseCell
        
        cell.backgroundColor = PageInfo(rawValue: indexPath.row)?.pageBackground
        cell.navigationController = self.navigationController
        
        return cell
    }
    
    func scroll(toPage pageNumber: Int) {
        let indexPath = IndexPath(item: pageNumber, section: 0)
        mainCollectionView.scrollToItem(at: indexPath, at: [], animated: true)
    }
}
