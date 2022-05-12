//
//  NetworkService.swift
//  ITISportApp
//
//  Created by zeinab ibrahim on 5/12/22.
//  Copyright © 2022 ititeam. All rights reserved.
//

import Foundation
protocol SportService{
  static func fetchResult(complitionHandler : @escaping (MySportResult?) -> Void)
}
class NetworkService : SportService{
    

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
}
