//
//  LeaguesDetailsPresenter.swift
//  ITISportApp
//
//  Created by user189294 on 5/14/22.
//  Copyright © 2022 ititeam. All rights reserved.
//

import Foundation
class LeaguesDetailsPresenter {
    var latestResultFromAF:[EventsValues]!
    var upcommingResultFromAF:[EventsValues]!
    weak var view : SportsProtocol!
    init(NWService : SportService){
           // self.NWService = NWService
            //NWService = NetworkService() // no Dependency Injection
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
 
}
