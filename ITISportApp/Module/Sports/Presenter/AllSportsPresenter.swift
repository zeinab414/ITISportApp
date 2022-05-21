//
//  AllSportsPresenter.swift
//  ITISportApp
//
//  Created by zeinab ibrahim on 5/12/22.
//  Copyright © 2022 ititeam. All rights reserved.
//

import Foundation

class AllSportsPresenter {
    var result : [Sport]! 
    var resultFromAF:[ResultView]=[]
      weak var view : SportsProtocol!
      
      init(NWService : SportService){
        
      }
      func attachView(view: SportsProtocol){
          self.view = view
      }
    
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
