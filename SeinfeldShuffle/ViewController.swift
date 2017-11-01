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
    
    let store = EpisodeDataStore.sharedInstance
    var randomEpisode: Episode?

    var tvImageView: UIImageView!
    var showScrollView: UIScrollView!
    var showStackView: UIStackView!
    var seinfeldButton: UIButton!
    var alwaysSunnyButton: UIButton!
    var pageControl: UIPageControl!
    
    override var preferredFocusEnvironments: [UIFocusEnvironment] {
        return [seinfeldButton, tvImageView]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        loadEpisodeData()
        constrain()
        

        
 
    }
    
    func configure() {
        
        pageControl = UIPageControl()
        pageControl.numberOfPages = 2
       
        showScrollView = UIScrollView()
        showScrollView.layer.cornerRadius = 15
        
        tvImageView = UIImageView()
        tvImageView.image = #imageLiteral(resourceName: "oldTelevision1")
        tvImageView.contentMode = .scaleAspectFit
        
        seinfeldButton = UIButton()
        seinfeldButton.tag = Sitcom.Seinfeld.rawValue
        seinfeldButton.setImage(#imageLiteral(resourceName: "Seinfeld"), for: .normal)
        seinfeldButton.imageView?.contentMode = .scaleAspectFit
        seinfeldButton.addTarget(self, action: #selector(startRandomEpisode), for: .primaryActionTriggered)
        
        alwaysSunnyButton = UIButton()
        alwaysSunnyButton.tag = Sitcom.AlwaysSunny.rawValue
        alwaysSunnyButton.setImage(#imageLiteral(resourceName: "AlwaysSunny"), for: .normal)
        alwaysSunnyButton.imageView?.contentMode = .scaleAspectFit
        alwaysSunnyButton.addTarget(self, action: #selector(startRandomEpisode), for: .primaryActionTriggered)

        showStackView = UIStackView()
        showStackView.alignment = .fill
        showStackView.distribution = .fillEqually
        showStackView.axis = .horizontal
        showStackView.backgroundColor = UIColor.magenta
        
        showStackView.addArrangedSubview(seinfeldButton)
        showStackView.addArrangedSubview(alwaysSunnyButton)
        
    }
    
    func constrain() {

        view.addSubview(tvImageView)
        tvImageView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.height.width.equalToSuperview().multipliedBy(0.9)
        }
        
        view.addSubview(showScrollView)
        showScrollView.snp.makeConstraints {
            $0.centerX.equalToSuperview().offset(-132)
            $0.centerY.equalToSuperview().offset(-23)
            $0.height.width.equalToSuperview().dividedBy(2.25)
        }
        
        showScrollView.addSubview(showStackView)
        showStackView.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
            $0.width.equalTo(tvImageView.snp.width)
        }
        
        view.addSubview(pageControl)
        pageControl.snp.makeConstraints {
            $0.centerX.equalTo(showScrollView.snp.centerX)
            $0.top.equalTo(showScrollView.snp.bottom).offset(20)
        }

    }
    
    func loadEpisodeData() {
        
        
        JSONParser.getEpisodeDataJSON(with: "Seinfeld") { (seinfeldData) in
            guard let seinfeld = seinfeldData["Seinfeld"] as? [String:Any] else { print("trouble unwrapping dictionary (seinfeld)"); return }
            
            guard let episodes = seinfeld["episodes"] as? [[String:Any]] else { print("trouble unwrapping dictionary (episodes)"); return }
            
            for episode in episodes {
                
                guard let season = episode["Season"] as? Int,
                    let number = episode["Episode"] as? Int,
                    let code = episode["Code"] as? Int,
                    let title = episode["Name"] as? String
                    else { print("trouble unwrapping dictionary (for loop)"); return }
                
                let newEpisode = Episode(season: season, episode: number, title: title, code: code, platform: .Hulu)
                
                self.store.seinfeldEpisodes.append(newEpisode)
                
            }
            
            self.store.seinfeldEpisodes.sort {
                return $0.0.seasonEpisode < $0.1.seasonEpisode
            }
            print("There are \(self.store.seinfeldEpisodes.count) episodes of Seinfeld")
        }
        
        
        
        
        JSONParser.getEpisodeDataJSON(with: "AlwaysSunny") { (alwaysSunnyData) in
            guard let alwaysSunny = alwaysSunnyData["It's Always Sunny in Philadelphia"] as? [String:Any] else { print("trouble unwrapping dictionary (It's Always Sunny in Philadelphia)"); return }
            
            guard let episodes = alwaysSunny["episodes"] as? [[String:Any]] else { print("trouble unwrapping dictionary (episodes)"); return }
            
            for episode in episodes {
                
                guard let season = episode["Season"] as? Int,
                    let number = episode["Episode"] as? Int,
                    let title = episode["Name"] as? String
                    else { print("trouble unwrapping dictionary (for loop)"); return }
                
                
                var code = 70224484
                if let unwrappedCode = episode["Code"] as? Int {
                    code = unwrappedCode
                }
                
                let newEpisode = Episode(season: season, episode: number, title: title, code: code, platform: .Netflix)

                self.store.alwaysSunnyEpisodes.append(newEpisode)
                
            }
            
            self.store.alwaysSunnyEpisodes.sort {
                return $0.0.seasonEpisode < $0.1.seasonEpisode
            }
            
            print("There are \(self.store.alwaysSunnyEpisodes.count) episodes of Always Sunny")
            
        }
        
        
    }
    
    
    func startRandomEpisode(_ sender: UIButton) {
        
        switch sender.tag {
        case 0:
            let randomIndex = Int(arc4random_uniform(UInt32(store.seinfeldEpisodes.count)))
            randomEpisode = store.seinfeldEpisodes[randomIndex]
            
        case 1:
            let randomIndex = Int(arc4random_uniform(UInt32(store.alwaysSunnyEpisodes.count)))
            randomEpisode = store.alwaysSunnyEpisodes[randomIndex]
            
        default:
            break
        }


        if let randomEpisode = randomEpisode {
            print("Random episode is season \(randomEpisode.season): \(randomEpisode.title) (code: \(randomEpisode.code))")
            
            let urlString = URL(string: randomEpisode.hyperlink)
            
            if let urlunwrapped = urlString {
                UIApplication.shared.open(urlunwrapped, options: [:]) { (didFinish) in
                    if didFinish {
                        print("SUCCESS with \(urlunwrapped)")
                    } else {
                        print("error...")
                    }
                }
            }
        }
    }
}

