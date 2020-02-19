//
//  AddCountryViewController.swift
//  countries
//
//  Created by Chad Brokaw on 2/6/20.
//  Copyright © 2020 Chad Brokaw. All rights reserved.
//

import UIKit

class AddCountryViewController: UIViewController {

    // var to store user input
    var addedCountry = String()
    
    // connect to textfield
    @IBOutlet weak var textField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "save" {
            if textField.text?.isEmpty == false {
                addedCountry = textField.text!
            }
        }
        else
        
        
    }


}
