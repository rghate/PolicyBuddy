//
//  AppDelegate.swift
//  PolicyBuddy
//
//  Created by Rupali on 30/07/2020.
//  Copyright © 2020 rghate. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var applicationStrings: AppText?
    
    private let appStandardTextFileName: String = "AppStandardText"
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        getAppStandardText()
        
        // Uncomment this code to get actual names of fonts
        //        for family in UIFont.familyNames.sorted() {
        //            let names = UIFont.fontNames(forFamilyName: family)
        //            print("Family: \(family) Font name: \(names)")
        //        }
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    private func getAppStandardText()  {
    
        //TODO: Caould be moved to a model layer?
        
        // load application standard text configuration from network
        let config = NetworkConfiguration(scheme: "http", host: "www.mocky.io", path: "/v2/5c699176370000a90a07fd6f", queryItems: [])
        
        _ = APIService().fetch(configuration: config) { result in
            
            switch result {
            case .failure(let err):
                print("Failed to get standard text data: ", err)
                // if file download failed, check if it was previously saved locally
                let jsonObj = try? JSONSerialization.loadJSON(withFilename: self.appStandardTextFileName, andExtension: "json")
                
                if let jsonObj = jsonObj {
                    // parse and display
                    self.applicationStrings = DataParser.parseStandardText(fromJsonObj: jsonObj)
                }
                
            case .success(let data):
                print("Received standard text data")
                
                if let jsonObj = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) {
                    self.applicationStrings = DataParser.parseStandardText(fromJsonObj: jsonObj)
                    
                    try? JSONSerialization.save(jsonObject: jsonObj, toFilename: self.appStandardTextFileName, withExtension: "json")
                    // if failed to save, app will display the default text from screen.
                    print("File saved")
                }
            }

        }
    }
    
}

