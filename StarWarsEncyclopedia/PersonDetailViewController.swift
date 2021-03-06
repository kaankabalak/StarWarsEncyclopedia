//
//  PersonDetailViewController.swift
//  StarWarsEncyclopedia
//
//  Created by Kaan Kabalak on 7/17/17.
//  Copyright © 2017 Kaan Kabalak. All rights reserved.
//

import UIKit

class PersonDetailViewController: UIViewController {

    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!

    @IBOutlet weak var birthYearLabel: UILabel!
    @IBOutlet weak var massLabel: UILabel!
    
    var id: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // specify the url that we will be sending the GET request to
        let url = URL(string: "http://swapi.co/api/people/" + String(Int(id!)!+1) + "/")
        // create a URLSession to handle the request tasks
        let session = URLSession.shared
        // create a "data task" to make the request and run completion handler
        let task = session.dataTask(with: url!, completionHandler: {
            // see: Swift closure expression syntax
            data, response, error in
            // data -> JSON data, response -> headers and other meta-information, error-> if one occurred
            // "do-try-catch" blocks execute a try statement and then use the catch statement for errors
            do {
                // Try converting the JSON object to "Foundation Types" (NSDictionary, NSArray, NSString, etc.)
                if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                    print(jsonResult)
                    DispatchQueue.main.async {
                        self.nameLabel.text = "Name: \(jsonResult["name"]! as! String)"
                        self.genderLabel.text = "Name: \(jsonResult["gender"]! as! String)"
                        self.birthYearLabel.text = "Birth Year: \(jsonResult["birth_year"]! as! String)"
                        self.massLabel.text = "Mass: \(jsonResult["mass"]! as! String)"
                    }
                }
            } catch {
                print("Something went wrong")
            }
        })
        // execute the task and then wait for the response
        // to run the completion handler. This is async!
        task.resume()
    }



    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
