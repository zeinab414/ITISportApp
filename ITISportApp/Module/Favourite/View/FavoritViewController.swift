//
//  FavoritViewController.swift
//  ITISportApp
//
//  Created by user189294 on 5/11/22.
//  Copyright © 2022 ititeam. All rights reserved.
//

import UIKit

class FavoritViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
 @IBOutlet weak var FavTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

    
        FavTableView.dataSource = self
       FavTableView.delegate = self
        
        
    }
    

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favCell", for: indexPath) as! FavouriteTableViewCell
        
        cell.favLeagueImageView.layer.cornerRadius =  cell.favLeagueImageView.frame.height / 2
        cell.favLeagueImageView.layer.masksToBounds = true
        cell.favLeagueImageView.backgroundColor = .black
        cell.favLeagueLable.text="hhhh"
        cell.favLeagueImageView.image=UIImage(named:"sport.jpeg")
      cell.favYoutubeBtn.tag=indexPath.row
        cell.favYoutubeBtn.addTarget(self, action: #selector(displayYoutubeVideo), for: .touchUpInside)
        return cell
    }
    @objc func displayYoutubeVideo(sender:UIButton){
          let myindexPath=IndexPath(row: sender.tag, section: 0)
        print("hello display from index \(myindexPath.row)")
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
  print("selectedddddd")

         
     }

}
