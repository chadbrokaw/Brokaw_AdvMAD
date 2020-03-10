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
    
    @IBOutlet weak var calculateButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        calculateButton.layer.cornerRadius = 4
    }
}

