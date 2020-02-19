//
//  Continents.swift
//  countries
//
//  Created by Chad Brokaw on 2/6/20.
//  Copyright © 2020 Chad Brokaw. All rights reserved.
//

import Foundation

// data model based on plist
struct ContinentsDataModel: Codable {
    var continent: String
    var countries: [String]
}

enum DataError: Error {
    case NoDataFile
    case CouldNotDecode
}
class ContinentsDataController {
    var allData = [ContinentsDataModel]()
    let filename = "continents2"
    
    func loadData() throws {
        if let dataUrl = Bundle.main.url(forResource: filename, withExtension:  "plist") {
            let decoder = PropertyListDecoder()
            do {
                let data = try Data(contentsOf: dataUrl)
                allData = try decoder.decode([ContinentsDataModel].self, from: data)
            }
            catch {
                throw DataError.CouldNotDecode
            }
        }
        else {
            throw DataError.NoDataFile
        }
    }
    
    func getContinents() -> [String] {
        var allContinents = [String]()
        for item in allData {
            allContinents.append(item.continent)
        }
        
        return allContinents
    }
    
    func getCountries(index: Int) -> [String] {
        return allData[index].countries
    }
    
    func addCountry(continentIndex: Int, newCountry: String, countryIndex: Int) {
        allData[continentIndex].countries.insert(newCountry, at: countryIndex)
    }
    
    func deleteCountry(dataIndex: Int, countryIndex: Int) {
        allData[dataIndex].countries.remove(at: countryIndex)
        
    }
}
