//
//  DetailViewController.swift
//  MTracker
//
//  Created by Chad Brokaw on 3/7/20.
//  Copyright © 2020 Chad Brokaw. All rights reserved.
//

import UIKit

class DetailViewController: UITableViewController {
    
    var fitnessData = FitnessDataController()
    var selectedMetric = 0
    var selectedMetricTitle = String()
    var dataList = [FitnessDataDetail]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//         self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        dataList = fitnessData.getDataForMetric(metricIndex: selectedMetric)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dataList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dataDetailCell", for: indexPath)
        
        cell.textLabel?.text = dataList[indexPath.row].value
        // Configure the cell...

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
            dataList.remove(at: indexPath.row)
            
            fitnessData.deleteDataForMetric(metricIndex: selectedMetric, dataIndex: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    @IBAction func unwindSegue(_ segue: UIStoryboardSegue) {
        if segue.identifier == "save" {
            let source = segue.source as! AddDataViewController
            
            dataList.append(source.preparedData)
            
            fitnessData.addDataForMetric(metricIndex: selectedMetric, newElement: source.preparedData)
            
            tableView.reloadData()
        }
    }
    

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
        print("prepare for segue DetailView")
        if segue.identifier == "addData" {
            let addDataVC = segue.destination as! AddDataViewController
            
            addDataVC.selectedMetric = selectedMetricTitle

        }
        
    }
    

}
