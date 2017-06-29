//
//  MapViewController.swift
//  EarthQuakeAppForDexcom
//
//  Created by Nathan Chen on 28/06/2017.
//  Copyright © 2017 Nathan Chen. All rights reserved.
//

import UIKit
import GoogleMaps
class MapViewController: UIViewController {
    var currenFeature:EarthQuakeFeature?
    override func viewDidLoad() {
        super.viewDidLoad()
        loadMap()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadMap(){
        if let lng = currenFeature?.coordinates?[0] , let lat = currenFeature?.coordinates?[1], let title = currenFeature?.title{
            let coordinate = CLLocationCoordinate2DMake(lat, lng)
            let camera = GMSCameraPosition.camera(withLatitude: coordinate.latitude, longitude: coordinate.longitude, zoom: 4.0)
            let marker = GMSMarker(position: coordinate)
            let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
            view = mapView
            marker.title = title
            self.navigationItem.title = title
            marker.map = mapView
            animateMarker(marker: marker)
            
        }
        
    }
    
    func animateMarker(marker:GMSMarker) {
        var frames : Array<UIImage> = []
        for i in 26...44 {
            frames.append(UIImage(named: "Anim 2_\(i)")!)
        }
        marker.icon = UIImage.animatedImage(with: frames, duration: 3.0)
        
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
