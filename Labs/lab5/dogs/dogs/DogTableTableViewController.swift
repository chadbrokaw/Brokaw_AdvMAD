//
//  DogTableTableViewController.swift
//  dogs
//
//  Created by Chad Brokaw on 3/30/20.
//  Copyright © 2020 Chad Brokaw. All rights reserved.
//

import UIKit

class DogTableTableViewController: UITableViewController {
    
    var dogDC = DogDataController()
    
    var dogData = [Dog]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dogDC.onDataUpdate = {[weak self] (data: [Dog]) -> Void in self?.newData(data: data)}
        
        dogDC.loadData()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    @IBAction func unwindSegue(segue: UIStoryboardSegue) {
        if segue.identifier == "SaveSegue" {
            let sourceVC = segue.source as! AddDogController
            
            if let userDogType = sourceVC.dogType, let userFluffiness = sourceVC.fluffiness {
                if let userNotes = sourceVC.notes {
                    dogDC.writeData(dogType: userDogType, fluffiness: userFluffiness, notes: userNotes)
                }
                else {
                    dogDC.writeData(dogType: userDogType, fluffiness: userFluffiness, notes: "")
                }
            }
            
        }
    }
    
    func newData(data: [Dog]) {
        dogData = data
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dogData.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DogCell", for: indexPath)

        // Configure the cell...
        
        let dog = dogData[indexPath.row]
        
        cell.textLabel?.text = "\(dog.dogType)"
        cell.detailTextLabel?.text = "\(dog.fluffiness)"

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "DetailSegue" {
            let vc = segue.destination as! DetailViewController
            
            let index = tableView.indexPath(for: (sender as! UITableViewCell))
            
            vc.dog = dogData[index!.row]
        }
    }
    

}
