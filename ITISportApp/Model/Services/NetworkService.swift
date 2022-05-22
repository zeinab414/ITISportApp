//
//  NetworkService.swift
//  ITISportApp
//
//  Created by zeinab ibrahim on 5/12/22.
//  Copyright © 2022 ititeam. All rights reserved.
//
import Alamofire
import SwiftyJSON
import Foundation

struct LeaguesValues {
    var leagueImage:String=""
    var leagueName:String=""
    var youtubeLink:String=""
    var leagueCountry:String=""
    var leagueID:String=""
}
struct EventsValues {
    var eventName :String = ""
    var eventStatus : String = ""
    var eventImage:String=""
    var firstTeamName:String=""
    var secondTeamName:String=""
    var eventDate:String=""
    var eventTime:String=""
    var firstTeamScore:String=""
    var secondTeamScore:String=""
    
}
struct TeamsValues {
    //TeamCollectionView
    var teamBadge:String = ""
    var teamName:String = ""
    //TeamDetails
    var stadiumImage:String = ""
    var stadiumName:String = ""
    var stadiumDescription:String = ""
    var stadiumCapacity:String = ""
    var stadiumLocation:String = ""
    var manager:String = ""
    var formedYear:String = ""
    var facebookLink:String = ""
    var instgramLink:String = ""
    var twitterLink:String = ""
    var youtubeLink:String = ""
}
protocol SportService{
    // All Sports
    func fetchSportResultWithAF(complitionHandler: @escaping ([ResultView]?) -> Void) ->Array<ResultView>
    // All Leagues
    func fetchSLeagesResultWithAF(endPoint:String,complitionHandler: @escaping ([LeaguesValues]?) -> Void) ->Array<LeaguesValues>
    // Leagues Details...
    // Upcoming Events
    func fetchUpcomingEventsResultWithAF(endPoint:String,complitionHandler: @escaping ([EventsValues]?) -> Void) ->Array<EventsValues>
    //Latest events
    func fetchEventsResultWithAF(endPoint:String,complitionHandler: @escaping ([EventsValues]?) -> Void) ->Array<EventsValues>
    // All Teams
    func fetchTeamsResultWithAF(endPoint:String,complitionHandler: @escaping ([TeamsValues]?) -> Void) ->Array<TeamsValues>
    
    
  
}

 

class NetworkService : SportService{
    
var myData:[ResultView] = []
var myLeaguesData:[LeaguesValues] = []
var latestEventsData:[EventsValues] = []
var upcomingEventsData:[EventsValues] = []
    var teamsData:[TeamsValues] = []

    
    func fetchSportResultWithAF(complitionHandler: @escaping ([ResultView]?) -> Void ) ->Array<ResultView>{
        Alamofire.request("https://www.thesportsdb.com/api/v1/json/2/all_sports.php", method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { (responseData) in
             switch responseData.result{
             case .success:
         
                 let myResult = try? JSON(data: responseData.data!)
                 let resultArray = myResult!["sports"]
                 for i in resultArray.arrayValue {
                     var sportResultNeeded: ResultView = ResultView(title: i["strSport"].stringValue, image: i["strSportThumb"].stringValue)
                     self.myData.append(sportResultNeeded)
                     
                 }
                 complitionHandler(self.myData)
                 print(self.myData[3].title)
              //   print(self.myData[3].sportImage)
             case .failure:
                 print("Failed !!!")
                 complitionHandler(nil)
                 break
             }
         }
        return myData
         
    }
    func fetchSLeagesResultWithAF(endPoint:String,complitionHandler: @escaping ([LeaguesValues]?) -> Void) ->Array<LeaguesValues>{
        var baseURL:String="https://www.thesportsdb.com/api/v1/json/2/search_all_leagues.php?s="+endPoint
           Alamofire.request(baseURL, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { (responseData) in
                switch responseData.result{
                case .success:
            
                    let myResult = try? JSON(data: responseData.data!)
                    let resultArray = myResult!["countries"]
                    for i in resultArray.arrayValue {
                     
                        var leaguesValue: LeaguesValues = LeaguesValues(leagueImage: i["strBadge"].stringValue, leagueName: i["strLeague"].stringValue, youtubeLink: i["strYoutube"].stringValue,leagueCountry:i["strCountry"].stringValue,leagueID: i["idLeague"].stringValue)
                        self.myLeaguesData.append(leaguesValue)
                        
                    }
                    complitionHandler(self.myLeaguesData)
                  
               
                case .failure:
                   print("Failed !!!")
                   complitionHandler(nil)
                    break
                }
            }
           return myLeaguesData
            
       }
    func fetchEventsResultWithAF(endPoint:String,complitionHandler: @escaping ([EventsValues]?) -> Void) ->Array<EventsValues>{
        
        var baseURL:String = "https://www.thesportsdb.com/api/v1/json/2/eventsseason.php?id="+endPoint
        
   
           Alamofire.request(baseURL, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { (responseData) in
                switch responseData.result{
                case .success:
                    let myResult = try? JSON(data: responseData.data!)
                    let resultArray = myResult!["events"]
                    for i in resultArray.arrayValue {
                        if(self.compareDate(eventDate: i["dateEvent"].stringValue) == 2 || self.compareDate(eventDate: i["dateEvent"].stringValue) == 1 ){
                        var eventValues: EventsValues = EventsValues(eventName: i ["strEvent"].stringValue, eventStatus: i ["strStatus"].stringValue, eventImage: i ["strThumb"].stringValue, firstTeamName: i ["strHomeTeam"].stringValue, secondTeamName: i ["strAwayTeam"].stringValue, eventDate: i ["dateEvent"].stringValue, eventTime: i ["strTime"].stringValue, firstTeamScore: i ["intHomeScore"].stringValue, secondTeamScore: i ["intAwayScore"].stringValue)
                            self.latestEventsData.append(eventValues)
                        }
                     
                       
                        
                    }
                    
                  complitionHandler(self.latestEventsData)
                  
               
                case .failure:
                  print("Failed !!!")
                  complitionHandler(nil)
                    break
                }
            }
           return latestEventsData
            
       }
    func fetchUpcomingEventsResultWithAF(endPoint:String,complitionHandler: @escaping ([EventsValues]?) -> Void) ->Array<EventsValues>{
        
        var baseURL:String = "https://www.thesportsdb.com/api/v1/json/2/eventsseason.php?id="+endPoint
        
   
           Alamofire.request(baseURL, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { (responseData) in
                switch responseData.result{
                case .success:
                    let myResult = try? JSON(data: responseData.data!)
                    let resultArray = myResult!["events"]
                    for i in resultArray.arrayValue {
                        if(self.compareDate(eventDate: i["dateEvent"].stringValue) == 3){
                        var eventValues: EventsValues = EventsValues(eventName: i ["strEvent"].stringValue, eventStatus: i ["strStatus"].stringValue, eventImage: i ["strThumb"].stringValue, firstTeamName: i ["strHomeTeam"].stringValue, secondTeamName: i ["strAwayTeam"].stringValue, eventDate: i ["dateEvent"].stringValue, eventTime: i ["strTime"].stringValue, firstTeamScore: i ["intHomeScore"].stringValue, secondTeamScore: i ["intAwayScore"].stringValue)
                            self.upcomingEventsData.append(eventValues)
                        }
                      
 
                     
                        
                    }
                    
                  complitionHandler(self.upcomingEventsData)
                    
                    print("enventsCount:\(self.upcomingEventsData.count)")
                    
               
                case .failure:
                  print("Failed !!!")
                  complitionHandler(nil)
                    break
                }
            }
           return upcomingEventsData
            
       }
    func fetchTeamsResultWithAF(endPoint:String,complitionHandler: @escaping ([TeamsValues]?) -> Void) ->Array<TeamsValues>{
        var newEndPoint:String=""
        newEndPoint=endPoint.replacingOccurrences(of: " ", with: "%20", options: .literal, range: nil)
          var baseURL:String = "https://www.thesportsdb.com/api/v1/json/2/search_all_teams.php?l="+newEndPoint
        
        Alamofire.request(baseURL, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { (responseData) in
             switch responseData.result{
             case .success:
            
                 let myResult = try? JSON(data: responseData.data!)
                 let resultArray = myResult!["teams"]
                 for i in resultArray.arrayValue {
                     var teamsValues: TeamsValues = TeamsValues(teamBadge: i["strTeamBadge"].stringValue, teamName: i["strTeam"].stringValue, stadiumImage: i["strStadiumThumb"].stringValue, stadiumName: i["strStadium"].stringValue, stadiumDescription: i["strStadiumDescription"].stringValue, stadiumCapacity: i["intStadiumCapacity"].stringValue, stadiumLocation: i["strStadiumLocation"].stringValue, manager: i["strManager"].stringValue, formedYear: i["intFormedYear"].stringValue, facebookLink: i["strFacebook"].stringValue, instgramLink: i["strInstagram"].stringValue, twitterLink: i["strTwitter"].stringValue, youtubeLink: i["strYoutube"].stringValue)
                     self.teamsData.append(teamsValues)
                  
                 }
                
                 complitionHandler(self.teamsData)
              
                
             case .failure:
                 print("Failed !!!")
                 complitionHandler(nil)
                 break
             }
         }
        return teamsData
         
    }
    func compareDate(eventDate:String)->Int{
             var comparedValue=0
            let date = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let currentDate = dateFormatter.string(from: date)
            if eventDate.compare(currentDate) == .orderedSame {
                      comparedValue = 1
                   }
                   else if eventDate.compare(currentDate) == .orderedAscending{
                       comparedValue = 2
                   }
                   else if eventDate.compare(currentDate) == .orderedDescending{
                       comparedValue = 3
                   }
            else{
                comparedValue = 0
            }
            return comparedValue
        }
}
