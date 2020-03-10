//
//  FirstViewController.swift
//  MTracker
//
//  Created by Chad Brokaw on 3/5/20.
//  Copyright © 2020 Chad Brokaw. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet weak var proteinAmount: UILabel!
    @IBOutlet weak var proteinStackView: UIStackView!
    @IBOutlet weak var carbAmount: UILabel!
    @IBOutlet weak var fatAmount: UILabel!
    
    var fitnessData = FitnessDataController()
    var macroData = MacroDataController()
    
    @IBOutlet weak var calculateButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        calculateButton.layer.cornerRadius = 4
        
        do {
            try fitnessData.loadData()
            try macroData.loadMacroData()
            
            proteinAmount.text = String(macroData.allData[macroData.PROTEIN].data)
            carbAmount.text = String(macroData.allData[macroData.CARBOHYDRATE].data)
            fatAmount.text = String(macroData.allData[macroData.FAT].data)
        }
        catch {
            print(error)
        }
    }
}

