//
//  Episode.swift
//  SeinfeldShuffle
//
//  Created by Robert Deans on 3/6/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import Foundation

enum Platform: String {
    case Hulu, Netflix
}

class Episode {
    
    let season: Int
    let episode: Int
    let code: Int
    let title: String
    let platform: Platform

    var seasonEpisode: String {
        var seasonString = "\(season)"
        if seasonString.characters.count == 1 {
            seasonString = "0\(seasonString)"
        }
        var episodeString = "\(episode)"
        if episodeString.characters.count == 1 {
            episodeString = "0\(episodeString)"
        }
        return "\(seasonString)\(episodeString)"
    }
    
    var hyperlink: String {
        
        switch platform {
        case .Hulu:
            return "hulu://w/\(code)"
        case .Netflix:
            return "nflx://w/\(code)"
        }

    }
        
    init(season: Int, episode: Int, title: String, code: Int, platform: Platform) {
        self.season = season
        self.episode = episode
        self.title = title
        self.code = code
        self.platform = platform
    }
    
}
