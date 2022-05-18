//
//  LeaguesPresenter.swift
//  ITISportApp
//
//  Created by zeinab ibrahim on 5/13/22.
//  Copyright © 2022 ititeam. All rights reserved.
//

import Foundation
class LeaguesPresenter{
     var resultFromAF:[LeaguesValues]!
     weak var view : SportsProtocol!
    init(NWService : SportService){
           // self.NWService = NWService
            //NWService = NetworkService() // no Dependency Injection
        }
        func attachView(view: SportsProtocol){
            self.view = view
        }
    func getLeaguesFromAF(myEndPoint:String){
             let service=NetworkService()
        service.fetchSLeagesResultWithAF(endPoint: myEndPoint){[weak self] (result1) in
               
                 self?.resultFromAF = result1 ?? []
                 DispatchQueue.main.async {
                     self?.view.stopAnimating()
                     self?.view.renderTableView()
                 }
             }
         }
    
}
