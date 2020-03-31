//
//  DetailViewController.swift
//  dogs
//
//  Created by Chad Brokaw on 3/30/20.
//  Copyright © 2020 Chad Brokaw. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var dogTypeLabel: UILabel!
    @IBOutlet weak var fluffinessLabel: UILabel!
    @IBOutlet weak var notesLabel: UILabel!
    
    var dog: Dog?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let myDog = dog {
            dogTypeLabel.text = myDog.dogType
            fluffinessLabel.text = String(myDog.fluffiness)
            notesLabel.text = String(myDog.notes)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
