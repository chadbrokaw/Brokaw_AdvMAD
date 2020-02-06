//
//  SecondViewController.swift
//  locations
//
//  Created by Chad Brokaw on 2/4/20.
//  Copyright © 2020 Chad Brokaw. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    let googleMapsScheme = "googlemaps://"
    let appleMapsScheme = "maps://"
    let googleMapsURLScheme = "https://www.google.com/maps"

    @IBAction func mapAction(_ sender: Any) {
        if isSchemeAvailable(scheme: appleMapsScheme) {
            open(scheme: appleMapsScheme)
        }
        else if isSchemeAvailable(scheme: googleMapsScheme) {
            open(scheme: googleMapsScheme)
        }
        else {
            open(scheme: googleMapsURLScheme)
        }
    }
    
    func open(scheme: String) {
        if let url = URL(string: scheme) {
            UIApplication.shared.open(url, options: [:]) { (success) in
                print("Open \(scheme): \(success)")
            }
        }
    }
    
    func isSchemeAvailable(scheme: String) -> Bool {
        if let url = URL(string: scheme) {
            return UIApplication.shared.canOpenURL(url)
        }
        return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

