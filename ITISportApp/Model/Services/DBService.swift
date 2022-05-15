//
//  DBService.swift
//  ITISportApp
//
//  Created by zeinab ibrahim on 5/15/22.
//  Copyright © 2022 ititeam. All rights reserved.
//

import Foundation
import CoreData
protocol DBProtocole {
    func addLeague(favLeague:LeaguesValues)
        func getLeagues() -> Array<NSManagedObject>
}
class DBService:DBProtocole{
    
    var viewContext: NSManagedObjectContext!
       init(appDelegate: AppDelegate){
           viewContext = appDelegate.persistentContainer.viewContext
       }
      func addLeague(favLeague:LeaguesValues){
          
           let leagueEntity = NSEntityDescription.entity(forEntityName: "FavLeague", in: viewContext)
          let favouriteLeague = NSManagedObject(entity: leagueEntity!, insertInto: viewContext)
           
        favouriteLeague.setValue(favLeague.leagueID, forKey: "leagueID")
           favouriteLeague.setValue(favLeague.leagueImage, forKey: "leagueImage")
           favouriteLeague.setValue(favLeague.leagueName, forKey: "leagueName")
        favouriteLeague.setValue(favLeague.youtubeLink, forKey: "youtubeLink")
        favouriteLeague.setValue(favLeague.leagueCountry, forKey: "leagueCountry")
           do{
               try viewContext.save()
               print("saved successfully")
           }catch let error{
               print(error.localizedDescription)
           }
       }
       
        func getLeagues() -> Array<NSManagedObject> {
           let fetch = NSFetchRequest<NSManagedObject>(entityName: "FavLeague")
           var favouriteLeagues: [NSManagedObject] = []
           do{
               favouriteLeagues  = try viewContext.fetch(fetch)
              
           }catch{
               print("Error in fetch data")
           }
           return favouriteLeagues
       }
       
      
}
