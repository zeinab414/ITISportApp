//
//  LeaguesDetailsViewController.swift
//  ITISportApp
//
//  Created by user189294 on 5/13/22.
//  Copyright © 2022 ititeam. All rights reserved.
//

import UIKit
import Kingfisher

class LeaguesDetailsViewController: UIViewController ,UICollectionViewDelegate,UICollectionViewDataSource {
    
    
    @IBAction func btnAddToFav(_ sender: Any) {
    }
    
    
    
    var legID:String=""
    var myLeagueResult:LeaguesValues=LeaguesValues()
    
    @IBOutlet weak var upComingEventsCollectionView: UICollectionView!
    
    @IBOutlet weak var latestEventsCollectionView: UICollectionView!
    
    
    @IBOutlet weak var teamsCollectionView: UICollectionView!
    
    let indicator = UIActivityIndicatorView(style: .large)
   var presenter :LeaguesDetailsPresenter!
      // Modle for View
      var latestResultView: [EventsValues]=[]
     var upcomingResultView: [EventsValues]=[]
    
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
        
        indicator.center = self.view.center
        self.view.addSubview(indicator)
        indicator.startAnimating()
        
        presenter = LeaguesDetailsPresenter(NWService: NetworkService())
        presenter.attachView(view: self)
        
        presenter.getEventsFromAF(myEndPoint: myLeagueResult.leagueID)
    //  presenter.getUpcomingEventsFromAF(myEndPoint: legID)
        let latestEventCell_layout=UICollectionViewFlowLayout()
        latestEventCell_layout.scrollDirection = .vertical
        latestEventCell_layout.itemSize=CGSize(width:latestEventsCollectionView.frame.width, height: 100)
        latestEventsCollectionView.collectionViewLayout=latestEventCell_layout
        
        //upcominCell
       let upcomingEventCell_layout=UICollectionViewFlowLayout()
        upcomingEventCell_layout.scrollDirection = .horizontal
        upcomingEventCell_layout.itemSize=CGSize(width:upComingEventsCollectionView.frame.width, height: 200)
upComingEventsCollectionView.collectionViewLayout=upcomingEventCell_layout
           print("leg \( myLeagueResult.leagueID)")
         print("leg \( myLeagueResult.leagueName)")
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(collectionView == upComingEventsCollectionView){
           
        return 5
        }
        else if(collectionView == latestEventsCollectionView){
            //return latestEventsAraay.count
            return latestResultView.count
           // return 5
        
        }
        else {
           
            return 5
        }
       
    }

   
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(collectionView == upComingEventsCollectionView){
            let upcomingEvents_cell = collectionView.dequeueReusableCell(withReuseIdentifier: "upcomingEventCell", for: indexPath) as! UpcomingEventCell
            // assign dumy data to views inside cell
            upcomingEvents_cell.cellbackgroundImage.image = UIImage(named: "sport.jpeg")
            upcomingEvents_cell.eventName.text = "Event1"
            upcomingEvents_cell.dateLabel.text = "23 May"
            upcomingEvents_cell.timeLabel.text = "5:00 PM"
            
            return upcomingEvents_cell
        }
        else if( collectionView == latestEventsCollectionView){
            let latestEvents_cell = collectionView.dequeueReusableCell(withReuseIdentifier: "latestEventCell", for: indexPath) as! LatestEventsCell
            //latestEvents_cell
            let url = URL(string: latestResultView[indexPath.row].eventImage)
            latestEvents_cell.latestEvent_backgroundImage.kf.setImage(with: url,placeholder: UIImage(named: "sport.jpeg"))
           // latestEvents_cell.latestEvent_backgroundImage.image=UIImage(named: "sport.jpeg")
            //name
            latestEvents_cell.latestEvent_firstTeamNameLabel.text = latestResultView[indexPath.row].firstTeamName
            latestEvents_cell.latestEvent_secondTeamNameLabel.text = latestResultView[indexPath.row].secondTeamName
            //score
            latestEvents_cell.latestEvent_firstTeamScoreLabel.text = latestResultView[indexPath.row].firstTeamScore
            latestEvents_cell.latestEvent_secondTeamScoreLabel.text = latestResultView[indexPath.row].secondTeamScore
            
            //date
            latestEvents_cell.latestEvent_dateLabel.text = latestResultView[indexPath.row].eventDate
            
            //time
            latestEvents_cell.latestEvent_timeLabel.text = latestResultView[indexPath.row].eventTime
         
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
extension LeaguesDetailsViewController : SportsProtocol {
    func stopAnimating() {
        indicator.stopAnimating()
        // I have the result
        //presenter.result
    }
    func renderTableView(){
        
        latestResultView = presenter.latestResultFromAF.map({ (item) -> EventsValues in
            var res:EventsValues=EventsValues(eventName: item.eventName , eventStatus: item.eventStatus , eventImage: item.eventImage, firstTeamName: item.firstTeamName, secondTeamName: item.secondTeamName, eventDate: item.eventDate, eventTime: item.eventTime, firstTeamScore: item.firstTeamScore, secondTeamScore: item.secondTeamScore)
            return res
        })
        /*
        upcomingResultView = presenter.upcommingResultFromAF.map({ (item) -> EventsValues in
            var res:EventsValues=EventsValues(eventName: item.eventName , eventStatus: item.eventStatus , eventImage: item.eventImage, firstTeamName: item.firstTeamName, secondTeamName: item.secondTeamName, eventDate: item.eventDate, eventTime: item.eventTime, firstTeamScore: item.firstTeamScore, secondTeamScore: item.secondTeamScore)
            return res
        })
 */
        /*
        if latestResultView.count==0{
                   latestEventsCollectionView.isHidden=true
                   let img=UIImageView(frame: CGRect(x:50,y:400,width:100,height:100))
                        img.image=UIImage(systemName: "icloud.slash")
                        img.tintColor = .gray
                        self.view.addSubview(img)
                        let labelNoData=UILabel(frame: CGRect(x: img.frame.minX, y: img.frame.maxY+15, width: img.frame.width, height: 30))
                        labelNoData.text="No Data"
                        labelNoData.textAlignment = .center
                        self.view.addSubview(labelNoData)
               }
 */
        self.latestEventsCollectionView.reloadData()
     //  self.upComingEventsCollectionView.reloadData()
        //self.teamsCollectionView.reloadData()
      

 
    }
}
   
   
       
