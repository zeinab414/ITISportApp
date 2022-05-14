//
//  LeaguesDetailsViewController.swift
//  ITISportApp
//
//  Created by user189294 on 5/13/22.
//  Copyright © 2022 ititeam. All rights reserved.
//

import UIKit

class LeaguesDetailsViewController: UIViewController ,UICollectionViewDelegate,UICollectionViewDataSource {
    
    
    @IBOutlet weak var upComingEventsCollectionView: UICollectionView!
    
    @IBOutlet weak var latestEventsCollectionView: UICollectionView!
    
    
    @IBOutlet weak var teamsCollectionView: UICollectionView!
    
//    let upcomingEventsAraay = [""]
//    let latestEventsAraay = [""]
//    let teamsAraay = [""]
    
//    fileprivate let collectionView:UICollectionView = {
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .horizontal
//        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        cv.translatesAutoresizingMaskIntoConstraints = false
//        cv.register(UpcomingEventCell.self, forCellWithReuseIdentifier: "upcomingEventCell")
//        return cv
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Upcoming Events dataSource&delegete
        upComingEventsCollectionView.delegate = self
        upComingEventsCollectionView.dataSource = self
        // Latest Events dataSource&delegete
        latestEventsCollectionView.delegate = self
        latestEventsCollectionView.dataSource = self
        // Teams Events dataSource&delegete
        teamsCollectionView.delegate = self
        teamsCollectionView.dataSource = self
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(collectionView == upComingEventsCollectionView){
            //return upcomingEventsAraay.count
        return 5
        }
        else if(collectionView == latestEventsCollectionView){
            //return latestEventsAraay.count
            return 10
        
        }
        else {
            //return teamsAraay.count
            return 5
        }
       
    }

   
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(collectionView == upComingEventsCollectionView){
            let upcomingEvents_cell = collectionView.dequeueReusableCell(withReuseIdentifier: "upcomingEventCell", for: indexPath) as! UpcomingEventCell
            // assign dumy data to views inside cell
            upcomingEvents_cell.cellbackgroundImage.image = UIImage(named: "sportbackground5")
            upcomingEvents_cell.firstTeamImage.image = UIImage(named: "sport.jpeg")
            upcomingEvents_cell.secondTeamImage.image = UIImage(named:"sport.jpeg")
            upcomingEvents_cell.firstTeamLabel.text = "First Team"
            upcomingEvents_cell.secondTeamLabel.text = "second Team"
            upcomingEvents_cell.dateLabel.text = "23 May"
            upcomingEvents_cell.timeLabel.text = "5:00 PM"
            
            return upcomingEvents_cell
        }
        else if( collectionView == latestEventsCollectionView){
            let latestEvents_cell = collectionView.dequeueReusableCell(withReuseIdentifier: "latestEventCell", for: indexPath) as! LatestEventsCell
            // assign dumy data to views inside cell
            latestEvents_cell.latestEvent_cellBackgroundImage.image = UIImage(named: "sportbackground6")
            latestEvents_cell.latestEvent_timeLabel.text = "10:00 PM"
            latestEvents_cell.latestEvent_dateLabel.text = "10 Feb"
            latestEvents_cell.latestEvent_firstTeamImage.image = UIImage(named: "sport.jpg")
            latestEvents_cell.latestEvent_secondTeamImage.image = UIImage(named: "sport.jpg")
            latestEvents_cell.firstTeamScoreLabel.text = "1"
            latestEvents_cell.latestEvent_VsLabel.text = ":"
            latestEvents_cell.secondTeamScoreLabel.text = "3"
            latestEvents_cell.latestEvent_firstTeamNameLabel.text = "First Team"
            latestEvents_cell.latestEvent_secondteamNameLabel.text = " Second Team"
            
            return latestEvents_cell
        }
        else {
            let teams_cell = collectionView.dequeueReusableCell(withReuseIdentifier: "teamscell", for: indexPath) as! TeamsCollectionViewCell
            teams_cell.teamImage.image = UIImage(named: "sport.jpg")
            teams_cell.teamNameLabel.text = "Team1"
            return teams_cell
        }
        
    }
    

 
  

}
