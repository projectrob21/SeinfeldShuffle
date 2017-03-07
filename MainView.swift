//
//  MainView.swift
//  SeinfeldShuffle
//
//  Created by Robert Deans on 3/6/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import UIKit
import SnapKit

class MainView: UIView {
    
    var tvImageView: UIImageView!
    var seinfeldButton: UIButton!
    
    // MARK: Initialization
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
        configure()
        constrain()
    }
    
    func configure() {
        tvImageView = UIImageView()
        tvImageView.image = #imageLiteral(resourceName: "oldTelevision1")
        tvImageView.contentMode = .scaleAspectFit
        
        seinfeldButton = UIButton()
        seinfeldButton.setImage(#imageLiteral(resourceName: "Seinfeld"), for: .normal)
        
    }
    
    func constrain() {
        addSubview(tvImageView)
        tvImageView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.height.width.equalToSuperview().multipliedBy(0.9)
        }
        
        tvImageView.addSubview(seinfeldButton)
        seinfeldButton.snp.makeConstraints {
            $0.centerX.equalToSuperview().offset(-125)
            $0.centerY.equalToSuperview()
            $0.height.width.equalToSuperview().dividedBy(2)
        }
                
    }
    
}
