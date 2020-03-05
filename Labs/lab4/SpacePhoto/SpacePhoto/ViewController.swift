//
//  ViewController.swift
//  SpacePhoto
//
//  Created by Chad Brokaw on 3/3/20.
//  Copyright © 2020 Chad Brokaw. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var selectedDate = String()
    var spacePhotoDataController = SpacePhotoDataController()
    
    var data = [SpacePhoto]()
    
    @IBAction func searchDate(_ sender: Any) {
        do {
            
            let searchDate = getDate()
            try spacePhotoDataController.loadJSON(date: searchDate)
            
            
            // thank you Isaac
            let alert = UIAlertController(title: nil, message: "Searching with \(selectedDate)...", preferredStyle: .alert)

            let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 5, width: 50, height: 50))
            loadingIndicator.hidesWhenStopped = true
            loadingIndicator.style = UIActivityIndicatorView.Style.medium
            loadingIndicator.startAnimating();

            alert.view.addSubview(loadingIndicator)
            present(alert, animated: true, completion: nil)
        }
        
        catch {
            print(error)
        }
    }
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    func getDate() -> String {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        return dateFormatter.string(from: datePicker.date)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        spacePhotoDataController.onDataUpdate = {[weak self] (data:[SpacePhoto]) in self?.searchDone(spaceData: data)}
        
        datePicker.maximumDate = Date()
        datePicker.minimumDate = Date.init(timeIntervalSinceReferenceDate: 0)
    }
    
    func searchDone(spaceData: [SpacePhoto]) {
        dismiss(animated: true, completion: nil)
        
        //set data property
        data = spaceData
    }


}

