//
//  EarthquakeDownloadManager.swift
//  EarthQuakeAppForDexcom
//
//  Created by Nathan Chen on 28/06/2017.
//  Copyright © 2017 Nathan Chen. All rights reserved.
//

import Foundation
typealias completionHandle = (Any) -> ()
class EarthquakeDownloadManager{
    static let api = URL(string: "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/4.5_day.geojson")!
    class func downloadDataWithURL(url:URL, completion:@escaping completionHandle){
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url) { (rawData, reponse, err) in
            if err == nil, let data = rawData{
                do{
                let jsonData = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    completion(jsonData)
                }
                catch{
                    print(err?.localizedDescription ?? "Error in Downloading Data")
                }
            }
        }
        dataTask.resume()
    }
    class func getFeaturesArrayFromDict(url:URL,arrayKey:String,completion:@escaping completionHandle){
        downloadDataWithURL(url: url) { (data) in
            if let jsonDict = data as? [String:Any]{
                if let jsonArray = jsonDict[arrayKey] as? [[String:Any]]{
                    completion(jsonArray)
                }
            }
        }
    }
    class func getFeatureObjectsFromArray(url:URL, arrayKey:String,completion:@escaping completionHandle){
        getFeaturesArrayFromDict(url: url, arrayKey: arrayKey) { (arr) in
            if let jsonArray = arr as? [[String:Any]]{
                var features = [EarthQuakeFeature]()
                for item in jsonArray{
                    if let feature = EarthQuakeFeature(JSON: item){
                        features.append(feature)
                    }
                }
                completion(features)
            }
        }
    }
    
    
}
