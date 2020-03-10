//
//  DetailViewController.swift
//  SpacePhoto
//
//  Created by Chad Brokaw on 3/9/20.
//  Copyright © 2020 Chad Brokaw. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBAction func viewImageAction(_ sender: Any) {
        openApp(scheme: results[0].url)
    }
    
    
    var results = [SpacePhoto]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = results[0].title
        dateLabel.text = results[0].date
        descriptionLabel.text = results[0].explanation
        // Do any additional setup after loading the view.
    }
    
    func openApp(scheme: String) {
      if let url = URL(string: scheme) {
        UIApplication.shared.open(url, options: [:], completionHandler: {
          (success) in
          print("Open \(scheme): \(success)")
        })
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
