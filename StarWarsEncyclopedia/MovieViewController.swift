//
//  ViewController.swift
//  StarWarsEncyclopedia
//
//  Created by Kaan Kabalak on 7/14/17.
//  Copyright © 2017 Kaan Kabalak. All rights reserved.
//

import UIKit

class MovieViewController: UITableViewController {
    // Hardcoded data for now
    var films = [String]()
    var urls = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        StarWarsModel.getAllFilms(completionHandler: { // passing what becomes "completionHandler" in the 'getAllPeople' function definition in StarWarsModel.swift
            data, response, error in
            do {
                // Try converting the JSON object to "Foundation Types" (NSDictionary, NSArray, NSString, etc.)
                if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                    if let results = jsonResult["results"] as? NSArray {
                        for person in results {
                            let personDict = person as! NSDictionary
                            self.films.append(personDict["title"]! as! String)
                            self.urls.append(personDict["url"]! as! String)
                        }
                    }
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch {
                print("Something went wrong")
            }
        })
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! UINavigationController
        let nav = destination.topViewController as! MovieDetailViewController
        print(sender!)
        nav.filmUrl = String(describing: sender!)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "movieDetailSegue", sender: urls[indexPath.row])
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        // if we return - sections we won't have any sections to put our rows in
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return the count of people in our data array
        return films.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Create a generic cell
        let cell = UITableViewCell()
        // set the default cell label to the corresponding element in the people array
        cell.textLabel?.text = films[indexPath.row]
        // return the cell so that it can be rendered
        return cell
    }
}
