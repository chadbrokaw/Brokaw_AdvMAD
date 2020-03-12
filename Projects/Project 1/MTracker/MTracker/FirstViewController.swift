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
    @IBAction func calculate(_ sender: Any) {
        setMacros()
    }
    
//    var fitnessData = FitnessDataController()
    var macroData = MacroDataController()
    
    @IBOutlet weak var calculateButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        calculateButton.layer.cornerRadius = 4
        
        do {
            try FitnessDataController.shared.loadData()
            try macroData.loadMacroData()
            setMacros()
        }
        catch {
            print(error)
        }
    }
    
    func setMacros() {
        do {
            print("button pressed")
            let macros = try macroData.calculateMacros()
            proteinAmount.text = "\(String(Int(macros.protein)))g"
            carbAmount.text = "\(String(Int(macros.carbohydrates)))g"
            fatAmount.text = "\(String(Int(macros.fat)))g"
            
        }
        catch {
            print(error)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        do {
//            try FitnessDataController.shared.loadData()
            try macroData.loadMacroData()
        }
        catch {
            print(error)
        }
    }
}

