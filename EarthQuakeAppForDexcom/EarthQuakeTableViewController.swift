//
//  ViewController.swift
//  EarthQuakeAppForDexcom
//
//  Created by Nathan Chen on 28/06/2017.
//  Copyright © 2017 Nathan Chen. All rights reserved.
//

import UIKit
import SVProgressHUD
class EarthQuakeTableViewController: UIViewController {
    @IBOutlet weak var earthQuakeTableView: UITableView!
    var features = [EarthQuakeFeature]()
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDataFromApi()
        earthQuakeTableView.tableFooterView = UIView()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
// MARK - TableViewDelegate
extension EarthQuakeTableViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedFeature = features[indexPath.row]
        if let mapVC = storyboard?.instantiateViewController(withIdentifier: "MapViewController") as? MapViewController{
            mapVC.currenFeature = selectedFeature
            self.navigationController?.pushViewController(mapVC, animated: true)
        }
    }
}
// MARK: - TableViewDataSource

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

// MARK: - Data Reading
extension EarthQuakeTableViewController{
    func loadDataFromApi(){
        SVProgressHUD.show()
        EarthquakeDownloadManager.getFeatureObjectsFromArray(url: EarthquakeDownloadManager.api, arrayKey: "features") { (featuresArray) in
            if let features = featuresArray as? [EarthQuakeFeature]{
                self.features = features
                DispatchQueue.main.async {
                    SVProgressHUD.dismiss()
                    self.earthQuakeTableView.reloadData()
                }
            }
        }
    }
}
