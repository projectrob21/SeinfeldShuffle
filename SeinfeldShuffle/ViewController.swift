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
                guard let season = episode["season"] as? Int, let number = episode["number"] as? Int, let title = episode["name"] as? String else { print("trouble unwrapping dictionary (for loop)"); return }

                
                let newEpisode = Episode(season: season, episode: number, title: title)

                self.seinfeldEpisodes.append(newEpisode)
                
            }
            self.seinfeldEpisodes.sort {
                return $0.0.seasonEpisode < $0.1.seasonEpisode
            }
            for episode in self.seinfeldEpisodes {
                print("\(episode.seasonEpisode)")
            }
        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

