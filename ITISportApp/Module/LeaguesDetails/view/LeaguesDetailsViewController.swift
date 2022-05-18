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
    
    //struct obj
    var legID:String=""
    var legName:String=""
    var myLeagueResult:LeaguesValues=LeaguesValues()
    var myTeamsResult:TeamsValues = TeamsValues()
    
    // Modle for View
    var latestResultView: [EventsValues]=[]
    var upcomingResultView: [EventsValues]=[]
    var teamResultView: [TeamsValues]=[]
    // collectionViews Outlets.....
    @IBOutlet weak var upComingEventsCollectionView: UICollectionView!
    @IBOutlet weak var latestEventsCollectionView: UICollectionView!
    @IBOutlet weak var teamsCollectionView: UICollectionView!
    
    //presenter
    var presenter :LeaguesDetailsPresenter!
    var favPresenter:FavPresenter!
    
    //coreData
    var appDelegate:AppDelegate=UIApplication.shared.delegate as! AppDelegate
    
    //indicator..
    let indicator = UIActivityIndicatorView(style: .large)
    
    //FavButton
    @IBAction func btnAddToFav(_ sender: Any) {
       print("ttest")
        favPresenter.inserNewLeague(myFavLeague: myLeagueResult,appDel: appDelegate)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favPresenter=FavPresenter()
        // Upcoming Events dataSource&delegete
        upComingEventsCollectionView.delegate = self
        upComingEventsCollectionView.dataSource = self
        // Latest Events dataSource&delegete
        latestEventsCollectionView.delegate = self
        latestEventsCollectionView.dataSource = self
        // Teams Events dataSource&delegete
        teamsCollectionView.delegate = self
        teamsCollectionView.dataSource = self
        
        //indicator
        indicator.center = self.view.center
        self.view.addSubview(indicator)
        indicator.startAnimating()
        
        //presenter
        presenter = LeaguesDetailsPresenter(NWService: NetworkService())
        presenter.attachView(view: self)
        presenter.getEventsFromAF(myEndPoint: legID)
        presenter.getUpcomingEventsFromAF(myEndPoint: legID)
        presenter.getTeamsFromAF(myEndPoint: legName)
        
        //upcominCell Layoout
       let upcomingEventCell_layout=UICollectionViewFlowLayout()
        upcomingEventCell_layout.scrollDirection = .horizontal
        upcomingEventCell_layout.itemSize=CGSize(width:upComingEventsCollectionView.frame.width*0.75, height: upComingEventsCollectionView.frame.height)
        upComingEventsCollectionView.collectionViewLayout=upcomingEventCell_layout
        
        // latestCell layout
        let latestEventCell_layout=UICollectionViewFlowLayout()
        latestEventCell_layout.scrollDirection = .vertical
        latestEventCell_layout.itemSize=CGSize(width:310, height:210)
        latestEventsCollectionView.collectionViewLayout=latestEventCell_layout
        
    
        //team cell Layout
        let teamCell_layout = UICollectionViewFlowLayout()
        teamCell_layout.scrollDirection = .horizontal
        teamCell_layout.itemSize = CGSize(width: teamsCollectionView.frame.width/3, height: teamsCollectionView.frame.height)
        teamsCollectionView.collectionViewLayout = teamCell_layout
        
        //test......
        print("leg \( myLeagueResult.leagueID)")
        print("leg \( myLeagueResult.leagueName)")
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == teamsCollectionView{
        var selectedIndex=indexPath.row
    
        let vc = storyboard?.instantiateViewController(withIdentifier: "teamDetailsID") as? TeamDetailsViewController
            vc?.resultView = teamResultView[indexPath.row]
           self.navigationController?.pushViewController(vc!, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(collectionView == upComingEventsCollectionView){
                    return upcomingResultView.count
               // return 5
                }
                 if(collectionView == latestEventsCollectionView){
                    //return latestEventsAraay.count
                    return latestResultView.count
                   // return 5
                
                }
                if(collectionView == teamsCollectionView) {
                   
                    return teamResultView.count
                    
                }
                return 0
       
    }

   
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(collectionView == upComingEventsCollectionView){
            let upcomingEvents_cell = collectionView.dequeueReusableCell(withReuseIdentifier: "upcomingEventCell", for: indexPath) as! UpcomingEventCell
            
            upcomingEvents_cell.backgroundColor = .yellow
            upcomingEvents_cell.layer.cornerRadius = 20.0
            
            // assign dumy data to views inside cell
            let url = URL(string: upcomingResultView[indexPath.row].eventImage)
            upcomingEvents_cell.cellbackgroundImage.kf.setImage(with: url,placeholder: UIImage(named: "sportbackground5.jpg"))
            upcomingEvents_cell.eventName.text = upcomingResultView[indexPath.row].eventName
            upcomingEvents_cell.dateLabel.text = upcomingResultView[indexPath.row].eventDate
            upcomingEvents_cell.timeLabel.text = upcomingResultView[indexPath.row].eventTime
            
            return upcomingEvents_cell
        }
         if( collectionView == latestEventsCollectionView){
            let latestEvents_cell = collectionView.dequeueReusableCell(withReuseIdentifier: "latestEventCell", for: indexPath) as! LatestEventsCell
            
            latestEvents_cell.backgroundColor = .black
            latestEvents_cell.layer.cornerRadius = 20.0
            
            let url = URL(string: latestResultView[indexPath.row].eventImage)
            latestEvents_cell.latestEvent_backgroundImage.kf.setImage(with: url,placeholder: UIImage(named: "sportbackground5.jpg"))
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
        let teams_cell = collectionView.dequeueReusableCell(withReuseIdentifier: "teamscell", for: indexPath) as! TeamsCollectionViewCell
        if collectionView==teamsCollectionView {
            teams_cell.layer.cornerRadius = 12.0
            
            let url = URL(string: teamResultView[indexPath.row].teamBadge)
            teams_cell.teamImage.kf.setImage(with: url,placeholder: UIImage(named: "arsnalbadge"))
            teams_cell.teamNameLabel.text = teamResultView[indexPath.row].teamName
            return teams_cell
        }
        else{
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
            var res:EventsValues=EventsValues(eventName: item.eventName ?? "" , eventStatus: item.eventStatus ?? "" , eventImage: item.eventImage ?? "", firstTeamName: item.firstTeamName ?? "", secondTeamName: item.secondTeamName ?? "", eventDate: item.eventDate ?? "", eventTime: item.eventTime ?? "", firstTeamScore: item.firstTeamScore ?? "", secondTeamScore: item.secondTeamScore ?? "")
            return res
        })
        upcomingResultView = presenter.upcommingResultFromAF.map({ (item) -> EventsValues in
            var res:EventsValues=EventsValues(eventName: item.eventName ?? "" , eventStatus: item.eventStatus ?? "" , eventImage: item.eventImage ?? "", firstTeamName: item.firstTeamName ?? "", secondTeamName: item.secondTeamName ?? "", eventDate: item.eventDate ?? "", eventTime: item.eventTime ?? "", firstTeamScore: item.firstTeamScore ?? "", secondTeamScore: item.secondTeamScore ?? "")
            return res
        })
        
        teamResultView = presenter.TeamResultFromAF.map({(item) -> TeamsValues in
            var teamResult:TeamsValues = TeamsValues(teamBadge: item.teamBadge ?? "", teamName: item.teamName ?? "", stadiumImage: item.stadiumImage ?? "", stadiumName: item.stadiumName ?? "", stadiumDescription: item.stadiumDescription ?? "", stadiumCapacity: item.stadiumCapacity ?? "", stadiumLocation: item.stadiumLocation ?? "", manager: item.manager ?? "", formedYear: item.formedYear ?? "", facebookLink: item.facebookLink ?? "", instgramLink: item.instgramLink, twitterLink: item.twitterLink ?? "", youtubeLink: item.youtubeLink ?? "")
            return teamResult
        })
        
        self.latestEventsCollectionView.reloadData()
      self.upComingEventsCollectionView.reloadData()
        self.teamsCollectionView.reloadData()
      

 
    }
}
   
   
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
