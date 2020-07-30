//
//  EntityViewModel.swift
//  PolicyBuddy
//
//  Created by Rupali on 25/07/2020.
//  Copyright © 2020 rghate. All rights reserved.
//

import UIKit

class EntityViewModel {
    var policies: [PolicyViewModel]?
    var hasActivePolicy: Bool
    let vrm: String
    let prettyVrm: String
    let make: Make
    let model: String
    let variant: String?
    let color: String?
    
    enum Make: String {
        case volkswagen = "volkswagen"
        case nissan = "nissan"
        case mercedes = "mercedes-benz"
        case ford = "ford"
        case mini = "mini"
        case none
        
        var imageName: String {
            switch self {
            case .volkswagen:
                return IMG_VOLKSWAGEN
            case .nissan:
                return IMG_NISSAN
            case .mercedes:
                return IMG_MERCEDES
            case .ford:
                return IMG_FORD
            case .mini:
                return IMG_MINI
            default:
                return IMG_MOTOR
            }
        }
    }
    
    init() {
        self.vrm = ""
        self.prettyVrm = ""
        self.make = Make.none
        self.model = ""
        self.variant = ""
        self.color = ""
        self.hasActivePolicy = false
    }
    
    init(vehicle: Vehicle) {
        self.vrm = vehicle.vrm
        self.prettyVrm = vehicle.prettyVrm
        self.make = EntityViewModel.Make(rawValue: vehicle.make.lowercased()) ?? Make.none
        self.model = vehicle.model
        self.variant = vehicle.variant
        self.color = vehicle.color
        
        self.policies = vehicle.policies.map { policy -> PolicyViewModel in
            PolicyViewModel(policy: policy)
        }
        self.hasActivePolicy = false
    }
    
    private let policyDataFileName: String = "PolicyData"
    private let fileExtension: String = "json"
    
    func fetchPolicies(loadFreshdata: Bool, completion: @escaping (Result<GroupedEntities, CustomError>) -> Void) {
        // if loading fresh data or data file is not present on the disk
        if loadFreshdata || !isFilePresent(fileName: "\(policyDataFileName).\(fileExtension)"){
            loadFromNetwork { result in
                switch result {
                case .failure(let err):
                    completion(.failure(err))
                case .success(let data):
                    self.handleResult(data: data, completion: completion)
                    
                }
            }
        } else {
            do {
                try loadFromLocalFile { result in
                    switch result {
                    case .failure(let err):
                        completion(.failure(err))
                    case .success(let data):
                        self.handleResult(data: data, completion: completion)
                    }
                }
            } catch let err {
                completion(.failure(CustomError(description: err.localizedDescription)))
            }
        }
    }
    
    private func loadFromLocalFile(completion: @escaping (Result<Data, CustomError>) -> Void) throws {
        // load data from saved file
        do {
            let jsonObj = try JSONSerialization.loadJSON(withFilename: policyDataFileName, andExtension: fileExtension)
            
            guard let json = jsonObj else {
                completion(.failure(CustomError(description: "")))
                return
            }
            let data = try JSONSerialization.data(withJSONObject: json, options: .fragmentsAllowed)
            
            completion(.success(data))
        } catch let err {
            print("Error while reading policy data locally: ", err)
            
            completion(.failure(CustomError(description: err.localizedDescription)))
        }
    }
    
    private func loadFromNetwork(completion: @escaping (Result<Data, CustomError>) -> Void) {
        let scheme = "https"
        let host = "cuvva.herokuapp.com"
        let path = ""
        
        let config = NetworkConfiguration(scheme: scheme, host: host, path: path, queryItems: [])
        
        let apiServiceMgr = APIService()
        
        let err = apiServiceMgr.fetch(configuration: config) { result in
            //            var groupedEntities = GroupedEntities()
            completion(result)
            
        }
        if let err = err {
            completion(.failure(err))
        }
        
    }
    
    private func handleResult(data: Data, completion: @escaping (Result<GroupedEntities, CustomError>) -> Void) {
        
        var groupedEntities = GroupedEntities()
        
        do {
            let policies = try DataParser.parsePolicies(data: data)
            let entity = DataParser.groupPoliciesForEntity(policies: policies)
            
            entity.forEach { key, value in
                groupedEntities[key] = EntityViewModel(vehicle: value)
            }
            
            // save the data into the file for offline use
            let jsonObj = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            try JSONSerialization.save(jsonObject: jsonObj, toFilename: policyDataFileName, withExtension: fileExtension)
            
            completion(.success(groupedEntities))
        } catch let err {
            print(err)
            completion(.failure(CustomError(description: "Data parsing error")))
        }
    }

    private func isFilePresent(fileName: String) -> Bool {
        var present: Bool = false
        
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let url = NSURL(fileURLWithPath: path)
        if let pathComponent = url.appendingPathComponent(fileName) {
            let filePath = pathComponent.path
            let fileManager = FileManager.default
            if fileManager.fileExists(atPath: filePath) {
                present = true
            }
        }
        return present
    }
}

extension EntityViewModel {
    func getActivePolicy() -> PolicyViewModel? {
        return self.policies?.first(where: { $0.endDate > Date() })
    }
}

typealias GroupedEntities = [String: EntityViewModel]

