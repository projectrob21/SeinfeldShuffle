//
//  ViewController.swift
//  SeinfeldShuffle
//
//  Created by Robert Deans on 3/6/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    var seinfeldEpisodes = [Episode]()
    
    var tvImageView: UIImageView!
    var seinfeldButton: UIButton!
    var randomEpisode: Episode?
    
    override var preferredFocusEnvironments: [UIFocusEnvironment] {
        return [seinfeldButton, tvImageView]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        constrain()
        
        EpisodeData.getEpisodeDataJSON(with: "Seinfeld") { (seinfeldData) in
            guard let seinfeld = seinfeldData["Seinfeld"] as? [String:Any] else { print("trouble unwrapping dictionary (seinfeld)"); return }
            
            guard let episodes = seinfeld["episodes"] as? [[String:Any]] else { print("trouble unwrapping dictionary (episodes)"); return }

            for episode in episodes {
                guard let season = episode["Season"] as? Int, let number = episode["Episode"] as? Int, let code = episode["Code"] as? Int, let title = episode["Name"] as? String else { print("trouble unwrapping dictionary (for loop)"); return }
                
                
                let newEpisode = Episode(season: season, episode: number, title: title, code: code)
                
                self.seinfeldEpisodes.append(newEpisode)
                
            }
            self.seinfeldEpisodes.sort {
                return $0.0.seasonEpisode < $0.1.seasonEpisode
            }
        
        }
        
        print(UIScreen.main.focusedView ?? "no focusedView")

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    func configure() {
       
        tvImageView = UIImageView()
        tvImageView.image = #imageLiteral(resourceName: "oldTelevision1")
        tvImageView.contentMode = .scaleAspectFit
        
        seinfeldButton = UIButton()
        seinfeldButton.setImage(#imageLiteral(resourceName: "Seinfeld"), for: .normal)
        seinfeldButton.addTarget(self, action: #selector(openHulu), for: .primaryActionTriggered)
        
    }
    
    func constrain() {

        view.addSubview(tvImageView)
        tvImageView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.height.width.equalToSuperview().multipliedBy(0.9)
        }
        
        view.addSubview(seinfeldButton)
        seinfeldButton.snp.makeConstraints {
            $0.centerX.equalToSuperview().offset(-125)
            $0.centerY.equalToSuperview()
            $0.height.width.equalToSuperview().dividedBy(2)
        }

    }
    
    
    func openHulu() {
        let randomIndex = Int(arc4random_uniform(173))
        randomEpisode = seinfeldEpisodes[randomIndex]
        print("Random episode is \(randomEpisode?.title)")
        if let randomEpisode = randomEpisode {
            let urlString = URL(string: randomEpisode.hyperlink)
            
            if let urlunwrapped = urlString {
                UIApplication.shared.open(urlunwrapped, options: [:]) { (didFinish) in
                    if didFinish {
                        print("SUCCESS")
                    } else {
                        
                        print("error...")
                    }
                }
            }
            
        }

    }
}

