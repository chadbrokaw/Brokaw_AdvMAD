//
//  DetailViewController.swift
//  planets
//
//  Created by Chad Brokaw on 2/18/20.
//  Copyright © 2020 Chad Brokaw. All rights reserved.
//

import UIKit

class DetailViewController: UITableViewController {
    
    var planetsDataController = PlanetsDataController()
    var selectedPlanet = 0
    var moonList = [String]()
    
    var searchController = UISearchController()
    let resultsController = SearchResultsController()
    
    @IBAction func unwindSegue(_ segue: UIStoryboardSegue) {
        if segue.identifier == "save" {
            let source = segue.source as! AddMoonViewController
            
            if source.addedMoon.isEmpty == false {
                planetsDataController.addMoon(planetIndex: selectedPlanet, newMoon: source.addedMoon, moonIndex: moonList.count)
                
                moonList.append(source.addedMoon)
                resultsController.allMoons = moonList
                
                tableView.reloadData()
            }
        }
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        moonList = planetsDataController.getMoons(planetIndex: selectedPlanet)
        
        
        resultsController.allMoons = moonList
        
        
        searchController = UISearchController(searchResultsController: resultsController)
        
        searchController.searchBar.placeholder = "Filter"
        
        searchController.searchBar.sizeToFit()
        
        tableView.tableHeaderView = searchController.searchBar
        
        searchController.searchResultsUpdater = resultsController
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return moonList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MoonCell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = moonList[indexPath.row]

        return cell
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }


    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            moonList.remove(at: indexPath.row)
            
            planetsDataController.deleteMoon(planetIndex: selectedPlanet, moonIndex: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }



    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        
        let fromRow = fromIndexPath.row
        let toRow = to.row
        
        let moonBeingMoved = moonList[fromRow]
        
        moonList.swapAt(fromRow, toRow)
        
        planetsDataController.deleteMoon(planetIndex: selectedPlanet, moonIndex: fromRow)
        
        planetsDataController.addMoon(planetIndex: selectedPlanet, newMoon: moonBeingMoved, moonIndex: toRow)
    }


    
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
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
