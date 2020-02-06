//
//  StateCitiesController.swift
//  locations
//
//  Created by Chad Brokaw on 2/4/20.
//  Copyright © 2020 Chad Brokaw. All rights reserved.
//

import Foundation

enum DataError: Error {
    case BadFilePath
    case CouldNotDecodeData
    case NoData
}

class StateCitiesController {
    var stateCitiesData: [StateCities]?
    let filename = "state-cities"
    
    func loadData() throws {
        if let pathURL = Bundle.main.url(forResource: filename, withExtension: "plist") {
            let decoder = PropertyListDecoder()
            
            do {
                let data = try Data(contentsOf: pathURL)
                
                stateCitiesData = try decoder.decode([StateCities].self, from: data)
            }
            catch {
                
            }
        }
    }
    
    func getAllStates() throws -> [String] {
        var states = [String]()
        
        
        if let data = stateCitiesData {
            for state in data {
                states.append(state.state)
            }
            
            return states
        }
        else {
            throw DataError.NoData
        }
    }
    
    func getCities(index: Int) throws -> [String] {
        if let data = stateCitiesData {
            return data[index].cities
        }
        else {
            throw DataError.NoData
        }
    }
}
