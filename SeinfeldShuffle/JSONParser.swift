//
//  EpisodeData.swift
//  SeinfeldShuffle
//
//  Created by Robert Deans on 3/6/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import Foundation

final class JSONParser {
    
    static let alwaysSunnyLink = "https://imdbapi.poromenos.org/js/?name=it%27s+always+sunny+in+philadelphia"
    
    static let seinfeldLink = "https://imdbapi.poromenos.org/js/?name=seinfeld"
    
    typealias EpisodeDictionary = [String:[String:Any]]
    
    var seinfeldDictionary: EpisodeDictionary = [:]
    
    class func getEpisodeDataAPI(for episodeLink: String, completion: @escaping ([String:Any]) -> Void) {
        let url = URL(string: episodeLink)
        
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
                } else {
                    print("ERROR: \(error)")
                    print("RESPONSE: \(response)")
                    
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
