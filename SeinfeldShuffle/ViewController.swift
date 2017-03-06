//
//  ViewController.swift
//  SeinfeldShuffle
//
//  Created by Robert Deans on 3/6/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var seinfeldEpisodes = [Episode]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        EpisodeData.getEpisodeData { (seinfeldData) in
            guard let seinfeld = seinfeldData["Seinfeld"] as? [String:Any] else { print("trouble unwrapping dictionary (seinfeld)"); return }
            
            guard let episodes = seinfeld["episodes"] as? [[String:Any]] else { print("trouble unwrapping dictionary (episodes)"); return }
            
            for episode in episodes {
                guard let seasondict = episode["season"] as? Int, let numberdict = episode["number"] as? Int, let name = episode["name"] as? String else { print("trouble unwrapping dictionary (for loop)"); return }

                
                var season = "\(seasondict)"
                if season.characters.count == 1 {
                    season = "0\(season)"
                }
                
                var episode = "\(numberdict)"
                if episode.characters.count == 1 {
                    episode = "0\(episode)"
                }
                
                let seasonEpisode = "\(season)\(episode)"
                
                let newEpisode = Episode(seasonEpisode: seasonEpisode, title: name)

                self.seinfeldEpisodes.append(newEpisode)
                
            }
            print("episode count = \(self.seinfeldEpisodes.count)")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

