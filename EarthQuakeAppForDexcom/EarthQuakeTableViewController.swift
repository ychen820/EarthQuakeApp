//
//  ViewController.swift
//  EarthQuakeAppForDexcom
//
//  Created by Nathan Chen on 28/06/2017.
//  Copyright © 2017 Nathan Chen. All rights reserved.
//

import UIKit

class EarthQuakeTableViewController: UIViewController {
    @IBOutlet weak var earthQuakeTableView: UITableView!
    var features = [EarthQuakeFeature]()
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDataFromApi()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
extension EarthQuakeTableViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return features.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EarthQuakeCell", for: indexPath)
        let currentFeature = features[indexPath.row]
        if let id = currentFeature.id , let mag = currentFeature.mag{
             cell.textLabel?.text = "id: " + id
             cell.detailTextLabel?.text = "Magnitude: " + String(mag)
        }
        return cell
       
        
    }
}
extension EarthQuakeTableViewController{
    func loadDataFromApi(){
        EarthquakeDownloadManager.getFeatureObjectsFromArray(url: EarthquakeDownloadManager.api, arrayKey: "features") { (featuresArray) in
            if let features = featuresArray as? [EarthQuakeFeature]{
                self.features = features
                DispatchQueue.main.async {
                    self.earthQuakeTableView.reloadData()
                }
            }
        }
    }
}
