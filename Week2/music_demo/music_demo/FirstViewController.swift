//
//  FirstViewController.swift
//  music_demo
//
//  Created by Chad Brokaw on 1/23/20.
//  Copyright © 2020 Chad Brokaw. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let genres = ["Rock", "Country", "Indie", "Hip Hop", "Pop"]
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var musicPicker: UIPickerView!
    
    @IBOutlet weak var choice: UILabel!
    
    // MARK: dataSource methods
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return genres.count
    }
    
    // MARK: Picker Delegate Methods
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return genres[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        choice.text = "You like \(genres[row])"
    }
}

