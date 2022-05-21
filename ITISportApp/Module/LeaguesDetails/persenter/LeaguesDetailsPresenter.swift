//
//  LeaguesDetailsPresenter.swift
//  ITISportApp
//
//  Created by user189294 on 5/14/22.
//  Copyright © 2022 ititeam. All rights reserved.
//

import Foundation
class LeaguesDetailsPresenter {
    var latestResultFromAF:[EventsValues]=[]
    var upcommingResultFromAF:[EventsValues]=[]
    var  TeamResultFromAF:[TeamsValues]=[]
    
    weak var view : SportsProtocol!
    init(NWService : SportService){
          
        }
        func attachView(view: SportsProtocol){
            self.view = view
        }

    func getEventsFromAF(myEndPoint:String){
             let service=NetworkService()
        service.fetchEventsResultWithAF(endPoint: myEndPoint){[weak self] (result1) in
               
                 self?.latestResultFromAF = result1 ?? []
                
                 DispatchQueue.main.async {
                     self?.view.stopAnimating()
                     self?.view.renderTableView()
                 }
             }
         }
    func getUpcomingEventsFromAF(myEndPoint:String){
             let service=NetworkService()
        service.fetchUpcomingEventsResultWithAF(endPoint: myEndPoint){[weak self] (result1) in
               
            self?.upcommingResultFromAF = result1 ?? []
                
                 DispatchQueue.main.async {
                     self?.view.stopAnimating()
                     self?.view.renderTableView()
                 }
             }
         }
    // Team
    func getTeamsFromAF(myEndPoint:String){
             let service=NetworkService()
        service.fetchTeamsResultWithAF(endPoint: myEndPoint){[weak self] (result1) in
               
                 self?.TeamResultFromAF = result1 ?? []
                
                 DispatchQueue.main.async {
                     self?.view.stopAnimating()
                     self?.view.renderTableView()
                 }
             }
         }
 
}
