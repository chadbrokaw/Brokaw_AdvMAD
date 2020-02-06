//
//  ThirdViewController.swift
//  music_demo
//
//  Created by Chad Brokaw on 1/23/20.
//  Copyright © 2020 Chad Brokaw. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        <#code#>
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        <#code#>
    }
    
    
    // constants
    let artistComp = 0
    let albumComp = 1
    
    // vars
    var artistAlbums = ArtistAlbumsController()
    var artists = [String]()
    var albums = [String]()
    
    @IBOutlet weak var artistPicker: UIPickerView!
    @IBOutlet weak var choiceLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
        
        do {
            try artistAlbums.loadData()
            
            // populate initial artists and albums arrays
            artists = try artistAlbums.getAllArtists()
            albums = try artistAlbums.getAlbums(idx: 0)
        }
        catch {
            print(error)
        }

        // Do any additional setup after loading the view.
        
        // DataSouce methods
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 2
        }
        
        
        
        
        //Delegate
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            // check which component was changed
            if component == artistComp {
                // task 1
                do {
                    albums = try artistAlbums.getAlbums(idx: row)
                } catch {
                    print(error)
                }
                artistPicker.reloadComponent(albumComp)
                artistPicker.selectRow(0, inComponent: albumComp, animated: true)
            }
            
            // got the currently selected indexes artist and album
            let artistIdx = pickerView.selectedRow(inComponent: artistComp)
            let albumIdx = pickerView.selectedRow(inComponent: albumComp)
            
            choiceLabel.text = "You Like \(albums[albumIdx]) by \(artists[artistIdx])"
        }
    }
    
}
