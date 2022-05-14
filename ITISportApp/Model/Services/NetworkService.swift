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
protocol SportService{
  static func fetchResult(complitionHandler : @escaping (MySportResult?) -> Void)
    func fetchSportResultWithAF(complitionHandler: @escaping ([ResultView]?) -> Void) ->Array<ResultView>
    func fetchSLeagesResultWithAF(endPoint:String,complitionHandler: @escaping ([LeaguesValues]?) -> Void) ->Array<LeaguesValues>
    
    
    func fetchEventsResultWithAF(endPoint:String,complitionHandler: @escaping ([EventsValues]?) -> Void) ->Array<EventsValues>
    //func fetchEventsResultWithAF() ->Array<EventsValues>
}

 

class NetworkService : SportService{
    
var myData:[ResultView] = []
var myLeaguesData:[LeaguesValues] = []
var latestEventsData:[EventsValues] = []
var upcomingEventsData:[EventsValues] = []

static func fetchResult(complitionHandler : @escaping (MySportResult?) -> Void){
    let url = URL(string: "https://www.thesportsdb.com/api/v1/json/2/all_sports.php")
    guard let newUrl = url else{
        return
    }
    let request = URLRequest(url: newUrl)
    let session = URLSession(configuration: URLSessionConfiguration.default)
    //URLSession.shared.dataTask(with: request) { (data, response, error) in
    //    //
    //}
    let task = session.dataTask(with: request) { (data, response, error) in
        guard let data = data else{
            return
        }
        do{
            let result = try JSONDecoder().decode(MySportResult.self, from: data)
            
            complitionHandler(result)
        }catch let error{
            print("Here")
            print(error.localizedDescription)
            complitionHandler(nil)
        }
        
        
    }

    task.resume()
    
    }
    
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
                 print("Can not get data")
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
                    print("Can not get data")
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
                        if(i ["strStatus"].stringValue == "Match Finished"){
                        var eventValues: EventsValues = EventsValues(eventName: i ["strEvent"].stringValue, eventStatus: i ["strStatus"].stringValue, eventImage: i ["strThumb"].stringValue, firstTeamName: i ["strHomeTeam"].stringValue, secondTeamName: i ["strAwayTeam"].stringValue, eventDate: i ["dateEvent"].stringValue, eventTime: i ["strTime"].stringValue, firstTeamScore: i ["intHomeScore"].stringValue, secondTeamScore: i ["intAwayScore"].stringValue)
                            self.latestEventsData.append(eventValues)
                        }
                        /*
                        else{
                        var eventValues: EventsValues = EventsValues(eventName: i ["strEvent"].stringValue, eventStatus: i ["strStatus"].stringValue, eventImage: i ["strThumb"].stringValue, firstTeamName: i ["strHomeTeam"].stringValue, secondTeamName: i ["strAwayTeam"].stringValue, eventDate: i ["dateEvent"].stringValue, eventTime: i ["strTime"].stringValue, firstTeamScore: i ["intHomeScore"].stringValue, secondTeamScore: i ["intAwayScore"].stringValue)
                            self.upcomingEventsData.append(eventValues)
                        }
 */
                        print("eventttt:  \( i ["dateEvent"].stringValue)")
                        
                    }
                    
                  //  complitionHandler(self.latestEventsData,self.upcomingEventsData)
                  
               
                case .failure:
                    print("Can not get data")
                  // complitionHandler(nil,nil)
                    break
                }
            }
           return latestEventsData
            
       }
}
