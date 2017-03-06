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
    
    class func getEpisodeData(completion: @escaping ([String:Any]) -> Void) {
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
    
        
        /*
         
         season 01 - 5
         season 02 - 12
         season 03 - 22
         season 04 - 22
         season 05 - 21
         season 06 - 23
         season 07 - 22
         season 08 - 22
         season 09 - 22
         
         */
}
