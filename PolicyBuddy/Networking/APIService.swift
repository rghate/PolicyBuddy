//
//  APIService.swift
//  PolicyBuddy
//
//  Created by Rupali on 23/07/2020.
//  Copyright © 2020 rghate. All rights reserved.
//
import Foundation

final class APIService {
    
    //MARK: Private properties
    
    private let session: NetworkSession

    
    // MARK: private initializer
    
    init(session: NetworkSession = URLSession.shared) {
      self.session = session
    }

    //MARK: Temp variable
    let readTestData: Bool = false
    
    
    //MARK: public methods
    /**
     Download all the policies with their details.
     
     @return Result property containing Data and CustomError
     */
    func fetch(configuration: NetworkConfiguration, completion: @escaping (Result<Data, CustomError>) -> Void)  -> CustomError? {
                
        guard let url = configuration.urlComponent?.url else {
            return CustomError(description: "Invalid URL")
        }

        #warning("temp. code for offline testing - remove/comment for realtime data testing")
        if readTestData {
                let fileData = self.readOfflineFromFile()
                completion(.success(fileData))
            return nil
        }

        DispatchQueue.global(qos: .background).async {
            let requestTimeout: TimeInterval = 30
            let cachePolicy: URLRequest.CachePolicy = .returnCacheDataElseLoad
            
            // use cache-policy to load cached data(if available), else make network request to download
            let request = URLRequest(url: url, cachePolicy: cachePolicy, timeoutInterval: requestTimeout)

            self.session.loadData(from: request) { data, response, err in
                //error handling
                if let err = err {
                    completion(.failure(CustomError(description: "Error: \(err.localizedDescription)")))
                    return
                }
                
                guard let data = data else {
                    completion(.failure(CustomError(description: "Response data error")))
                    return
                }
                
                guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                    completion(.failure(CustomError(description: "Server error")))
                    return
                }

                completion(.success(data))
            }
        }
        return nil
    }
    
    #warning("temp. code for offline testing - remove/comment for realtime data testing")
    
    private func readOfflineFromFile() -> Data {
        var data: Data?
        Bundle.main.path(forResource: "TestFile", ofType: "json")
        if let path = Bundle.main.path(forResource: "TestFile", ofType: "json") {
            do {
                let fileUrl = URL(fileURLWithPath: path)
                // Getting data from JSON file using the file URL
                data = try Data(contentsOf: fileUrl, options: .mappedIfSafe)
            } catch {
                // Handle error here
            }
        }
        return data!
    }
 
    
    
}
