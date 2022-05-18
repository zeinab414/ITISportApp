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
        let url = NSURL(string: "https://"+resultView.facebookLink)
              if UIApplication.shared.canOpenURL(url! as URL) {
                  UIApplication.shared.openURL(url! as URL)
              } else {
                  UIApplication.shared.openURL(NSURL(string: "http://facebook.com/")! as URL)
              }
    }
    @IBAction func instgramButton(_ sender: Any) {
        let url = NSURL(string:"https://"+resultView.instgramLink+"/")
               if UIApplication.shared.canOpenURL(url! as URL) {
                   UIApplication.shared.openURL(url! as URL)
               } else {
                   UIApplication.shared.openURL(NSURL(string: "https://www.instagram.com/"
       )! as URL)
               }
    }
    @IBAction func youtubeButton(_ sender: Any) {
        let youtube_id = "SxTYjptEzZs"
               var youtubeUrl = NSURL(string:"youtube://\(youtube_id)")!
               if UIApplication.shared.canOpenURL(youtubeUrl as URL){
                   UIApplication.shared.openURL(youtubeUrl as URL)
               } else{
                   var url = resultView.youtubeLink
                  if(url == ""){
                       url="www.youtube.com/watch?v=eRrMaxAE-SY"
                   }
                   youtubeUrl = NSURL(string:"https://"+url)!
                   UIApplication.shared.openURL(youtubeUrl as URL)
               }
    }
    @IBAction func twitterButton(_ sender: Any) {
        let url = NSURL(string: "https://"+resultView.twitterLink)
               if UIApplication.shared.canOpenURL(url! as URL) {
                   UIApplication.shared.openURL(url! as URL)
               } else {
                   UIApplication.shared.openURL(NSURL(string: "https://twitter.com/")! as URL)
               }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        teamNameLabel.text=resultView.teamName
        stadiumNameLabel.text = resultView.stadiumName
        let stdium_url = URL(string: resultView.stadiumImage)
        stadiumImageView.kf.setImage(with: stdium_url,placeholder: UIImage(named:"arsnalstaduim"))
        let teamBadge_url = URL(string: resultView.teamBadge)
        teamBadgeImageView.kf.setImage(with: teamBadge_url,placeholder: UIImage(named:"arsnalbadge"))
        
       
    }
    

   

}
