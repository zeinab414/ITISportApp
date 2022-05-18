//
//  TeamDetailsViewController.swift
//  ITISportApp
//
//  Created by user189294 on 5/18/22.
//  Copyright © 2022 ititeam. All rights reserved.
//

import UIKit
import Kingfisher

class TeamDetailsViewController: UIViewController {
   
    
  
       var resultView:TeamsValues=TeamsValues()
    
    @IBOutlet weak var teamBadgeImageView: UIImageView!
    @IBOutlet weak var teamNameLabel: UILabel!
    @IBOutlet weak var stadiumImageView: UIImageView!
    @IBOutlet weak var stadiumNameLabel: UILabel!
    
   
    
    @IBAction func facebookButton(_ sender: UIButton) {
    }
    @IBAction func instgramButton(_ sender: Any) {
    }
    @IBAction func youtubeButton(_ sender: Any) {
    }
    @IBAction func twitterButton(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        teamNameLabel.text=resultView.teamName
        stadiumNameLabel.text=resultView.stadiumName
        let stediumUrl = URL(string: resultView.stadiumImage)
        stadiumImageView.kf.setImage(with: stediumUrl,placeholder: UIImage(named: ""))
        let teamBadgeUrl = URL(string: resultView.teamBadge)
        teamBadgeImageView.kf.setImage(with: teamBadgeUrl)
        
       
    }
    

   

}
