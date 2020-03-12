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
    case HeightDataNotAvailable
    case BFPDataNotAvailable
    case BirthdayNotAvailable
    case ActivityLevelNotAvailable
    case SomethingWentWrong
}

struct Macros {
    var protein: Double
    var fat: Double
    var carbohydrates: Double
    
    init(protein: Double, fat: Double, carbohydrates: Double) {
        self.protein = protein
        self.fat = fat
        self.carbohydrates = carbohydrates
    }
}

class MacroDataController {
    var allData = [MacroDataModel]()
    let fileName = "macros"
    let dataFileName = "WrittenMacroData.plist"
    
    let PROTEIN = 0
    let CARBOHYDRATE = 1
    let FAT = 2
    
    init() {
        let app = UIApplication.shared

        NotificationCenter.default.addObserver(self, selector: #selector(MacroDataController.writeData(_:)), name: UIApplication.willResignActiveNotification, object: app)
    }
    
    func getDataFile(dataFile: String) -> URL {
        let dirPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        let docDir = dirPath[0]
        
        return docDir.appendingPathComponent(dataFile)
    }
    
    @objc func writeData(_ notification: NSNotification) throws {
        print("Writing")
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
    
    func updateData(macroCode: Int, newData: Int) {
        allData[macroCode].data = newData
    }
    
    func calculateMacros() throws -> Macros {
        print("calculating")
        do {
            let kgWeight = try getWeight()
            let height = try getHeight()
            let BodyFatPercentage = try getBodyFatPercentage()
            let age = try getAge()
            let activityLevel = try getActivityLevel()
            
            print("""
                height: \(height)
                weight: \(kgWeight)
                Body Fat PErcentage: \(BodyFatPercentage)
                Age: \(age)
                ActivityLevel: \(activityLevel)
            """
            )
            
            let BMR_KatchMcArdle = calculateBMR_KatchMcArdle(BFP: BodyFatPercentage, kgWeight: kgWeight)
            let BMR_MifflinStJeor = calculateBMR_MifflinStJeor(kgWeight: kgWeight, cmHeight: height, age: age)
            
            let BMR_Avg = (BMR_KatchMcArdle + BMR_MifflinStJeor) / 2
            
            let TDEE_Grams = BMR_Avg * activityLevel
            
            return Macros(protein: TDEE_Grams*0.4, fat: TDEE_Grams*0.3, carbohydrates: TDEE_Grams*0.3)
        }
        catch {
            print(error)
            throw DataRetrievalErrors.SomethingWentWrong
        }
    }
    
    func getWeight() throws -> Double {
        let weightArray = FitnessDataController.shared.getDataForMetric(metricIndex: FitnessDataController.shared.WEIGHT)
        
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
    
    func getHeight() throws -> Double {
        let heightArray = FitnessDataController.shared.getDataForMetric(metricIndex: FitnessDataController.shared.HEIGHT)
        
        if heightArray.count == 0 {
            throw DataRetrievalErrors.HeightDataNotAvailable
        }
        
        if let inchHeight = Double(heightArray[0].value) {
            let cmHeight = inchHeight * 2.54
            return cmHeight
        }
        else {
            throw DataRetrievalErrors.HeightDataNotAvailable
        }
    }
    
    func getBodyFatPercentage() throws -> Double {
        let BFPArray = FitnessDataController.shared.getDataForMetric(metricIndex: FitnessDataController.shared.BODY_FAT_PERCENTAGE)
        
        if BFPArray.count == 0 {
            throw DataRetrievalErrors.BFPDataNotAvailable
        }
        
        if let bfp = Double(BFPArray[0].value) {
            return bfp
        }
        else {
            throw DataRetrievalErrors.BFPDataNotAvailable
        }
    }
    
    func getActivityLevel() throws -> Double {
        let activityLevelArray = FitnessDataController.shared.getDataForMetric(metricIndex: FitnessDataController.shared.ACTIVITY_LEVEL)
        
        if activityLevelArray.count == 0 {
            throw DataRetrievalErrors.ActivityLevelNotAvailable
        }
        
        if let activityLevel = Double(activityLevelArray[0].value) {
            return activityLevel
        }
        else {
            throw DataRetrievalErrors.ActivityLevelNotAvailable
        }
    }
    
    func getAge() throws -> Double {
        let birthdayArray = FitnessDataController.shared.getDataForMetric(metricIndex: FitnessDataController.shared.BIRTHDAY)
        if birthdayArray.count == 0 {
            throw DataRetrievalErrors.BirthdayNotAvailable
        }
        
        let birthday = birthdayArray[0].value
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        let date = df.date(from: birthday)
        
        if let dob = date {
            let cal = Calendar.current
            let age = cal.component(.year, from: Date()) -  cal.component(.year, from: dob)
            return Double(age)
        }
        else {
            throw DataRetrievalErrors.BirthdayNotAvailable
        }
    }
    
    
    
    func calculateBMR_KatchMcArdle(BFP: Double, kgWeight: Double) -> Double {
        let LeanBodyMass = (kgWeight * (100 - BFP)) / 100
        
        let BMR = 370 + (21.6 * LeanBodyMass)
        
        return BMR
    }
    
    func calculateBMR_MifflinStJeor(kgWeight: Double, cmHeight: Double, age: Double) -> Double {
        let BMR = (10 * kgWeight) + (6.25 * cmHeight) - (5 * age) + 5
        return BMR
    }
    
    
    
}
