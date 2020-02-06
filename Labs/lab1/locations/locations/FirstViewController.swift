//
//  FirstViewController.swift
//  locations
//
//  Created by Chad Brokaw on 2/4/20.
//  Copyright © 2020 Chad Brokaw. All rights reserved.
//

import UIKit

let STATE = 0
let CITY = 1


class FirstViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var locationPicker: UIPickerView!
    @IBOutlet weak var locationLabel: UILabel!
    
    var stateCities = StateCitiesController()
    var states = [String]()
    var cities = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        do {
            try stateCities.loadData()
            states = try stateCities.getAllStates()
        }
        catch {
            print(error)
        }
        locationLabel.text = ""
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == STATE {
            return states.count
        }
        else if component == CITY {
            return cities.count
        }
        else {
            print("Unknown component")
            return -1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == STATE {
            return states[row]
        }
        else if component == CITY {
            return cities[row]
        }
        else {
            print("Unknown Component")
            return "Unkown Component"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == STATE {
            do {
                cities = try stateCities.getCities(index: row)
            }
            catch {
                print(error)
            }
            locationPicker.reloadComponent(CITY)
            locationPicker.selectRow(0, inComponent: CITY, animated: true)
        }
        
        let stateIndex = pickerView.selectedRow(inComponent: STATE)
        let cityIndex = pickerView.selectedRow(inComponent: CITY)
        
        locationLabel.text = "You like \(cities[cityIndex]), \(states[stateIndex])"
    }
}

