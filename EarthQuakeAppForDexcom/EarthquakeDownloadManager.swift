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
    
    class func downloadDataWithURL(url:URL, completion:@escaping completionHandle){
        let session = URLSession.shared
        session.dataTask(with: url) { (rawData, reponse, err) in
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
    }
}
