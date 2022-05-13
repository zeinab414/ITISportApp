//
//  AllSportsPresenter.swift
//  ITISportApp
//
//  Created by zeinab ibrahim on 5/12/22.
//  Copyright © 2022 ititeam. All rights reserved.
//

import Foundation

class AllSportsPresenter {
    var result : [Sport]! // model
    var resultFromAF:[ResultView]=[]
      weak var view : SportsProtocol!  // DI
      
      init(NWService : SportService){
         // self.NWService = NWService
          //NWService = NetworkService() // no Dependency Injection
      }
      func attachView(view: SportsProtocol){
          self.view = view
      }
    /*
      func getSports(){
          NetworkService.fetchResult {[weak self] (result) in
              
              print(result?.sports[0].strSport ?? "")
              self?.result = result?.sports
              //self.tableView.reloadData()
              DispatchQueue.main.async {
                  self?.view.stopAnimating()
                  self?.view.renderTableView()
                  //self.label?.text = result.items[0].header ?? ""
              }
          }
      }
 */
    
   func getSportsFromAF(){
          let service=NetworkService()
          service.fetchSportResultWithAF{[weak self] (result1) in
             // print(result1?.sports[2].strSport ?? "")
              self?.resultFromAF = result1 ?? []
              DispatchQueue.main.async {
                  self?.view.stopAnimating()
                  self?.view.renderTableView()
              }
          }
      }
        
}
