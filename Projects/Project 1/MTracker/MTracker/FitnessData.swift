//
//  FitnessData.swift
//  MTracker
//
//  Created by Chad Brokaw on 3/7/20.
//  Copyright © 2020 Chad Brokaw. All rights reserved.
//

import Foundation
import UIKit

struct FitnessDataDetail: Codable {
    var date: String
    var value: String
}

struct FitnessDataModel: Codable {
    var Data: [FitnessDataDetail]
    var type: String
}

enum DataError: Error {
    case NoDataFile
    case CouldNotDecode
    case CouldNotEncode
}

class FitnessDataController {
    var allData = [FitnessDataModel]()
    let fileName = "Data"
    let dataFileName = "WrittenData.plist"
    
    init() {
        let app = UIApplication.shared
        
        NotificationCenter.default.addObserver(self, selector: #selector(FitnessDataController.writeData(_:)), name: UIApplication.willResignActiveNotification, object: app)
    
    }
    
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
        //get an encoder
        let encoder = PropertyListEncoder()
        //set format — plist is a type of xml
        encoder.outputFormat = .xml
        do {
            let data = try encoder.encode(allData.self)
            try data.write(to: dataFileURL)
        } catch {
            print(error)
            throw DataError.CouldNotEncode
        }
    }
    
    func loadData() throws {
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
                allData = try decoder.decode([FitnessDataModel].self, from: data)
            }
            catch {
                throw DataError.CouldNotDecode
            }
        }
        else {
            throw DataError.NoDataFile
        }
    }
    
    func getDataForMetric(metricIndex: Int) -> [FitnessDataDetail] {
        return allData[metricIndex].Data
    }
    
    func getMetrics() -> [String] {
        var allMetrics = [String]()
        
        for item in allData {
            allMetrics.append(item.type)
        }
        
        return allMetrics
    }
    
    func deleteDataForMetric(metricIndex: Int, dataIndex: Int) {
        allData[metricIndex].Data.remove(at: dataIndex)
    }
    
    func addDataForMetric(metricIndex: Int, newElement: FitnessDataDetail) {
        allData[metricIndex].Data.append(newElement)
//
//        do {
//            try writeDataLocally()
//        }
//        catch {
//            print("Tried to write in local")
//            print(error)
//        }
    }
    
}
