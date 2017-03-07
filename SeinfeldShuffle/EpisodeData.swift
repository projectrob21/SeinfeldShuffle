//
//  EpisodeData.swift
//  SeinfeldShuffle
//
//  Created by Robert Deans on 3/6/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import Foundation

class EpisodeData {
    
    typealias SeinfeldDictionary = [String:[String:Any]]
    
    var seinfeldDictionary: SeinfeldDictionary = [:]
    
    class func getEpisodeDataAPI(completion: @escaping ([String:Any]) -> Void) {
        let url = URL(string: "https://imdbapi.poromenos.org/js/?name=seinfeld")
        
        if let unwrappedURL = url {
            let session = URLSession.shared
            let dataTask = session.dataTask(with: unwrappedURL) { (data, response, error) in
                if let unwrappedData = data {
                    do {
                        let responseJSON = try JSONSerialization.jsonObject(with: unwrappedData, options: []) as! [String:Any]
                        completion(responseJSON)
                    } catch {
                        print("ERROR: \(error)")
                    }
                }
            }
            dataTask.resume()
            
        }
    }
    
    class func getEpisodeDataJSON(with jsonFilename: String, completion: @escaping ([String : Any]) -> Void) {
        guard let filePath = Bundle.main.path(forResource: jsonFilename, ofType: "json") else { print("error unwrapping json file path"); return }
        
        do {
            let data = try NSData(contentsOfFile: filePath, options: NSData.ReadingOptions.uncached)
            
            guard let seinfeldData = try JSONSerialization.jsonObject(with: data as Data, options: []) as? [String : Any] else { print("error typecasting json dictionary"); return }
            completion(seinfeldData)
        } catch {
            print("error reading data from file in json serializer")
        }
    }
    
}
