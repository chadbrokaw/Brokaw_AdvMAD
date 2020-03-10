//
//  MacroData.swift
//  MTracker
//
//  Created by Chad Brokaw on 3/9/20.
//  Copyright © 2020 Chad Brokaw. All rights reserved.
//

import Foundation
import UIKit

struct MacroDataModel: Codable {
    var data: Int
    var macro: String
}

enum DataRetrievalErrors: Error {
    case WeightDataNotAvailable
}

class MacroDataController {
    var allData = [MacroDataModel]()
    let fileName = "macros"
    let dataFileName = "WrittenMacroData.plist"
    let fitnessData = FitnessDataController()
    
    let PROTEIN = 0
    let CARBOHYDRATE = 1
    let FAT = 2
    
//    init() {
//        let app = UIApplication.shared
//
//
//    }
    
    func getDataFile(dataFile: String) -> URL {
        let dirPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        let docDir = dirPath[0]
        
        return docDir.appendingPathComponent(dataFile)
    }
    
    @objc func writeData(_ notification: NSNotification) throws {
        let dataFileURL = getDataFile(dataFile: dataFileName)
        
        let encoder = PropertyListEncoder()
        
        encoder.outputFormat = .xml
        
        do {
            let data = try encoder.encode(allData.self)
            try data.write(to: dataFileURL)
        }
        catch {
            print(error)
            throw DataError.CouldNotEncode
        }
    }
    
    func writeDataLocally() throws {
        let dataFileURL = getDataFile(dataFile: dataFileName)
        
        let encoder = PropertyListEncoder()
        
        encoder.outputFormat = .xml
        
        do {
            let data = try encoder.encode(allData.self)
            try data.write(to: dataFileURL)
        }
        catch {
            print(error)
//            throw DataError.CouldNotEncode
        }
    }
    
    func loadMacroData() throws {
        let pathURL: URL?
        
        let dataFileURL = getDataFile(dataFile: dataFileName)
        
        if FileManager.default.fileExists(atPath: dataFileURL.path) {
            pathURL = dataFileURL
        }
        else {
            pathURL = Bundle.main.url(forResource: fileName, withExtension: "plist")
        }
        
        if let dataURL = pathURL {
            let decoder = PropertyListDecoder()
            do {
                let data = try Data(contentsOf: dataURL)
                allData = try decoder.decode([MacroDataModel].self, from: data)
            }
            catch {
                throw DataError.CouldNotDecode
            }
        }
        else {
            throw DataError.NoDataFile
        }
    }
    
    func loadFitnessData() {
        do {
            try fitnessData.loadData()
        }
        catch {
            print("Couldn't get fitnessData")
            print(error)
        }
    }
    
    func updateData(macroCode: Int, newData: Int) {
        allData[macroCode].data = newData
    }
    
    func calculateMacros() {
        do {
            let weight = try getWeight()
        }
        catch {
            
        }
        
    }
    
    func getWeight() throws -> Double {
        let weightArray = fitnessData.getDataForMetric(metricIndex: fitnessData.WEIGHT)
        
        if weightArray.count == 0 {
            throw DataRetrievalErrors.WeightDataNotAvailable
        }
        if let intWeight = Double(weightArray[0].value) {
            let kgWeight = intWeight / 2.205
            return kgWeight
        }
        else {
            throw DataRetrievalErrors.WeightDataNotAvailable
        }
    }
    
    
    
}
