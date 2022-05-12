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


protocol SportService{
  static func fetchResult(complitionHandler : @escaping (MySportResult?) -> Void)
    func fetchSportResultWithAF(complitionHandler: @escaping ([ResultView]?) -> Void) ->Array<ResultView>
}

 

class NetworkService : SportService{
    
var myData:[ResultView] = []

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
}
