//
//  AddDataViewController.swift
//  MTracker
//
//  Created by Chad Brokaw on 3/8/20.
//  Copyright © 2020 Chad Brokaw. All rights reserved.
//

import UIKit

class AddDataViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var promptText: UILabel!
    @IBOutlet weak var addDataStack: UIStackView!
    
    var selectedMetric = String()
    var addedData = String()
    var preparedData = FitnessDataDetail(date: "", value: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        promptText.text = determinePromptText()
        
        determineWhatsVisible()
    }
    
    
    func determineWhatsVisible() {
        if selectedMetric != "Birthday" {
            datePicker.isHidden = true
        }
        else {
            addDataStack.isHidden = true
        }
    }
    
    func determinePromptText() -> String {
        switch (selectedMetric) {
        case "Chest Size", "Waist Size", "Height":
            return "Please provide data in inches"
        case "Weight":
            return "Please provide data in pounds"
        case "Activity Level":
            return "Please provide a decimal value between 1 and 2"
        case "Body Fat Percentage":
            return "Please provide a percentage between 0 and 100"
        default:
            return ""
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "save" {
            if selectedMetric != "Birthday" {
                if textField.text?.isEmpty == false {
                    
                    let df = DateFormatter()
                    df.dateFormat = "yyyy-MM-dd"
                    let now = df.string(from: Date())
                    
                    preparedData.value =  textField.text!
                    preparedData.date = now
                }
            }
            else {
                let df = DateFormatter()
                df.dateFormat = "yyyy-MM-dd"
                let now = df.string(from: Date())
                
                preparedData.value = df.string(from: datePicker.date)
                preparedData.date = now
            }
            
        }
    }
    
    

}
