//
//  FavPresenter.swift
//  ITISportApp
//
//  Created by zeinab ibrahim on 5/15/22.
//  Copyright © 2022 ititeam. All rights reserved.
//

import Foundation
import CoreData
class FavPresenter{
    
   
    func inserNewLeague(myFavLeague:LeaguesValues,appDel:AppDelegate){
        var db=DBService(appDelegate: appDel)
        db.addLeague(favLeague:myFavLeague)
      
        
    }
    func fetchAllLeagues(appDel:AppDelegate) -> Array<NSManagedObject> {
         var db=DBService(appDelegate: appDel)
          return db.getLeagues()
    }
    func deleteOneRow(appDel:AppDelegate,deleteLeage1: NSManagedObject){
        var db=DBService(appDelegate: appDel)
         db.deleteFromCoreData(deleteLeage:deleteLeage1 )
        
    }
}
