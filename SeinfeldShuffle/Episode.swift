//
//  Episode.swift
//  SeinfeldShuffle
//
//  Created by Robert Deans on 3/6/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import Foundation

class Episode {
    
    let seasonEpisode: String
    let title: String
    let url: URL? = nil
    
    init(seasonEpisode: String, title: String) {
        self.seasonEpisode = seasonEpisode
        self.title = title
    }
    
}
