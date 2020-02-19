//
//  Planets.swift
//  planets
//
//  Created by Chad Brokaw on 2/18/20.
//  Copyright © 2020 Chad Brokaw. All rights reserved.
//

import Foundation
import UIKit

struct PlanetsDataModel: Codable {
    var planet: String
    var moons: [String]
}

enum DataErrorTypes: Error {
    case NoDataFile
    case CouldNotDecode
    case CouldNotEncode
}

class PlanetsDataController {
    var planetData = [PlanetsDataModel]()
    let filename = "planets"
    let persistenceName = "planetData.plist"
    
    init() {
        let app = UIApplication.shared
        
        NotificationCenter.default.addObserver(self, selector: #selector(PlanetsDataController.writeData(_:)), name: UIApplication.willResignActiveNotification, object: app)
    }
    
    func loadData() throws {
        let pathURL: URL?
        
        let persistenceFileURL = getDataFile(dataFile: persistenceName)
        
        if FileManager.default.fileExists(atPath: persistenceFileURL.path) {
            pathURL = persistenceFileURL
        }
        else {
            pathURL = Bundle.main.url(forResource: filename, withExtension: "plist")
        }
        
        if let dataURL = pathURL {
            let decoder = PropertyListDecoder()
            do {
                let data = try Data(contentsOf: dataURL)
                
                planetData = try decoder.decode([PlanetsDataModel].self, from: data)
            }
            catch {
                throw DataErrorTypes.CouldNotDecode
            }
        }
        else {
            throw DataErrorTypes.NoDataFile
        }
    }
    
    func getPlanets() -> [String] {
        var allPlanets = [String]()
        
        for planetObj in planetData {
            allPlanets.append(planetObj.planet)
        }
        
        return allPlanets
    }
    
    func getMoons(planetIndex: Int) -> [String] {
        return planetData[planetIndex].moons
    }
    
    func addMoon(planetIndex: Int, newMoon: String, moonIndex: Int) {
        planetData[planetIndex].moons.insert(newMoon, at: moonIndex)
    }
    
    func deleteMoon(planetIndex: Int, moonIndex: Int) {
        planetData[planetIndex].moons.remove(at: moonIndex)
    }
    
    func getDataFile(dataFile: String) -> URL {
        let directoryPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let docDirectory = directoryPath[0]
        
        return docDirectory.appendingPathComponent(dataFile)
    }
    
    @objc func writeData(_ notification: NSNotification) throws {
        let persistenceFileURL = getDataFile(dataFile: persistenceName)
        
        let encoder = PropertyListEncoder()
        
        encoder.outputFormat = .xml
        
        do {
            let data = try encoder.encode(planetData.self)
            try data.write(to: persistenceFileURL)
        }
        catch {
            print(error)
            throw DataErrorTypes.CouldNotEncode
        }
    }
    
    
}
