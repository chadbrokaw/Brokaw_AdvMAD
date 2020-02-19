//
//  AddMoonViewController.swift
//  planets
//
//  Created by Chad Brokaw on 2/18/20.
//  Copyright © 2020 Chad Brokaw. All rights reserved.
//

import UIKit

class AddMoonViewController: UIViewController {

    @IBOutlet weak var moonTextfield: UITextField!
    var addedMoon = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "save" {
            if moonTextfield.text?.isEmpty == false {
                addedMoon = moonTextfield.text!
            }
        }
    }


}
