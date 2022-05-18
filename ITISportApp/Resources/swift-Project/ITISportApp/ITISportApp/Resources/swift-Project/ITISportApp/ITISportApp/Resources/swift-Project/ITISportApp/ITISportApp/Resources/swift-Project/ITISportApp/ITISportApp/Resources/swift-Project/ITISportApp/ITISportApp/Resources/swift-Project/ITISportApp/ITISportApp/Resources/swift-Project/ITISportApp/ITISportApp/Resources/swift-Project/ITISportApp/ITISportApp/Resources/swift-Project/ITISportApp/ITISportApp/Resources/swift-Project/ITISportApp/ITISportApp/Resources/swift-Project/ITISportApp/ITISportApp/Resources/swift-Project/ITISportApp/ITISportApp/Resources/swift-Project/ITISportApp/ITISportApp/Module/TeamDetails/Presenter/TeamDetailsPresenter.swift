//
//  TeamDetailsPresenter.swift
//  ITISportApp
//
//  Created by user189294 on 5/18/22.
//  Copyright © 2022 ititeam. All rights reserved.
//

import Foundation
class TeamDetailsPresenter{
    
var resultFromAF:[LeaguesValues]!
weak var view : SportsProtocol!
init(NWService : SportService){
    
   }
   func attachView(view: SportsProtocol){
       self.view = view
   }
//func getTeamsDetailsFromAF(myEndPoint:String){
//        let service=NetworkService()
//   service.fetchTeamsResultWithAF(endPoint: myEndPoint){[weak self] (result1) in
//          
//            self?.resultFromAF = result1 ?? []
//            DispatchQueue.main.async {
//                self?.view.stopAnimating()
//                self?.view.renderTableView()
//            }
//        }
//    }
}
