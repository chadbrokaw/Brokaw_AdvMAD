//
//  ViewController.swift
//  planets
//
//  Created by Chad Brokaw on 2/18/20.
//  Copyright © 2020 Chad Brokaw. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var planetsList = [String]()
    var planetDataController = PlanetsDataController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        do {
            try planetDataController.loadData()
            planetsList = planetDataController.getPlanets()
        }
        catch {
            print(error)
        }
        
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return planetsList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let planetCell = tableView.dequeueReusableCell(withIdentifier: "PlanetCell", for: indexPath)
        
        planetCell.textLabel?.text = planetsList[indexPath.row]
        
        return planetCell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "moonSegue" {
            let detailViewController = segue.destination as! DetailViewController
            let indexPath = tableView.indexPath(for: sender as! UITableViewCell)
            
            if let selection = indexPath?.row {
                detailViewController.selectedPlanet = selection
                detailViewController.title = planetsList[selection]
                detailViewController.planetsData = planetDataController
            }
        }
    }


}

