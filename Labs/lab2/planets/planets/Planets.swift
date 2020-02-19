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
    
    func loadData() throws {
        if let dataURL = Bundle.main.url(forResource: filename, withExtension: "plist") {
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
    
    func addMoon(planetIndex: Int, newPlanet: String, moonIndex: Int) {
        planetData[planetIndex].moons.insert(newPlanet, at: planetIndex)
    }
    
    func deleteMoon(planetIndex: Int, moonIndex: Int) {
        planetData[planetIndex].moons.remove(at: moonIndex)
    }
    
    
}
