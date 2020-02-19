//
//  SearchViewController.swift
//  planets
//
//  Created by Chad Brokaw on 2/18/20.
//  Copyright © 2020 Chad Brokaw. All rights reserved.
//

import UIKit

class SearchResultsController: UITableViewController, UISearchResultsUpdating {
    
    
    var allMoons = [String]()
    var filteredMoons = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MoonCell")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredMoons.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MoonCell", for: indexPath)
        cell.textLabel?.text = filteredMoons[indexPath.row]
        return cell
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchString = searchController.searchBar.text //get the text entered into search bar
        filteredMoons.removeAll() //empty array of filtered words
        
        //make sure we got a value
        if searchString?.isEmpty == false {
            
            //closure to filter through all words
            let searchFilter: (String) -> Bool = {word in
                let range = word.range(of: searchString!, options: .caseInsensitive)
                //range will be nil if the character sequence is no present in the given word
                return range != nil
            }
            
            //use the closure to filter through all words
            filteredMoons = allMoons.filter(searchFilter)
        }
        //update the table with relevant words
        tableView.reloadData()
    }
    
    
}
