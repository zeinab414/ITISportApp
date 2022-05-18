//
//  FavoritViewController.swift
//  ITISportApp
//
//  Created by user189294 on 5/11/22.
//  Copyright © 2022 ititeam. All rights reserved.
//

import UIKit
import CoreData
import Kingfisher
class FavoritViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
 @IBOutlet weak var FavTableView: UITableView!
   
      var presenter :FavPresenter!
    var resultArray:[NSManagedObject]=[]
   var appDelegate:AppDelegate=UIApplication.shared.delegate as! AppDelegate
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

   
        FavTableView.dataSource = self
       FavTableView.delegate = self
         presenter=FavPresenter()
        
      
        resultArray = presenter.fetchAllLeagues(appDel:appDelegate)
        
        let img=UIImageView(frame: CGRect(x:50,y:100,width:100,height:100))
                  img.image=UIImage(systemName: "icloud.slash")
                  img.tintColor = .gray
                 img.tag=20
                let labelNoData=UILabel(frame: CGRect(x: img.frame.minX, y: img.frame.maxY+15, width: img.frame.width, height: 30))
                labelNoData.text="No Data"
                labelNoData.textAlignment = .center
                labelNoData.tag=21
                if(resultArray.count == 0){
                    FavTableView.isHidden=true
                    self.view.addSubview(img)
                                         
                  self.view.addSubview(labelNoData)
                    
                }
                    
                else{
                    FavTableView.isHidden=false
                    if let viewWithTag = self.view.viewWithTag(20) {
                            viewWithTag.removeFromSuperview()
                        }else{
                            print("Error")
                        }
                    if let viewWithTag = self.view.viewWithTag(21) {
                            viewWithTag.removeFromSuperview()
                        }else{
                            print("Error")
                        }
                    
                         
                }
       
        FavTableView.reloadData()
        
        
    }
    

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
    return resultArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favCell", for: indexPath) as! FavouriteTableViewCell
        
        cell.favLeagueImageView.layer.cornerRadius =  cell.favLeagueImageView.frame.height / 2
    cell.favLeagueImageView.layer.masksToBounds = true
        cell.favLeagueImageView.backgroundColor = .black
        cell.favLeagueLable.text=resultArray[indexPath.row].value(forKey: "leagueName") as? String ?? ""
       // cell.favLeagueImageView.image=UIImage(named:"sport.jpeg")
        let url = URL(string: resultArray[indexPath.row].value(forKey: "leagueImage") as? String ?? "sport.jpeg")
             cell.favLeagueImageView.kf.setImage(with: url)
      cell.favYoutubeBtn.tag=indexPath.row
        cell.favYoutubeBtn.addTarget(self, action: #selector(displayYoutubeVideo), for: .touchUpInside)
        return cell
    }
  
    
    @objc func displayYoutubeVideo(sender:UIButton){
           let myindexPath=IndexPath(row: sender.tag, section: 0)
           print("hello display")
                          let youtubeId = "SxTYjptEzZs"
           var youtubeLink = resultArray[myindexPath.row].value(forKey: "youtubeLink") as? String ?? ""
                              var youtubeUrl = NSURL(string:"youtube://\(youtubeId)")!
                              if UIApplication.shared.canOpenURL(youtubeUrl as URL){
                                  UIApplication.shared.openURL(youtubeUrl as URL)
                              } else{
                                    
                      
                                  var myUrl=youtubeLink
                                  if(myUrl.isEmpty){
                                      myUrl="https://www.youtube.com/watch?v=AcVtT2d8-kk"
                                  }
                                  youtubeUrl = NSURL(string:myUrl)!
                                  UIApplication.shared.openURL(youtubeUrl as URL)
                              }
       }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           if(NetworkConnection.shared.isConnected){
  let vc = storyboard?.instantiateViewController(withIdentifier: "LeaguesDetailsID") as? LeaguesDetailsViewController
          vc?.legID = resultArray[indexPath.row].value(forKey: "leagueID") as? String ?? ""
            vc?.legName = resultArray[indexPath.row].value(forKey: "leagueName") as? String ?? ""
         self.navigationController?.pushViewController(vc!, animated: true)
         
        }
           else{
            let disconnctedAlert = UIAlertController(title: "Check Internet", message: "Turn on the WIFI and try later", preferredStyle: .alert)
            disconnctedAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            present(disconnctedAlert, animated: true, completion: nil)
        }
     }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
           // favPresenter.deleteOneRow(appDelegate: appDelegate, leage: favLeagues[indexPath.row])
            presenter.deleteOneRow(appDel:appDelegate,deleteLeage1: resultArray[indexPath.row])
            resultArray.remove(at: indexPath.row)
            FavTableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
            
            let img=UIImageView(frame: CGRect(x:50,y:100,width:100,height:100))
                      img.image=UIImage(systemName: "icloud.slash")
                      img.tintColor = .gray
                     img.tag=20
                    let labelNoData=UILabel(frame: CGRect(x: img.frame.minX, y: img.frame.maxY+15, width: img.frame.width, height: 30))
                    labelNoData.text="No Data"
                    labelNoData.textAlignment = .center
                    labelNoData.tag=21
                    if(resultArray.count == 0){
                        FavTableView.isHidden=true
                        self.view.addSubview(img)
                                             
                      self.view.addSubview(labelNoData)
                        
                    }
                        
                    else{
                        FavTableView.isHidden=false
                        if let viewWithTag = self.view.viewWithTag(20) {
                                viewWithTag.removeFromSuperview()
                            }else{
                                print("Error")
                            }
                        if let viewWithTag = self.view.viewWithTag(21) {
                                viewWithTag.removeFromSuperview()
                            }else{
                                print("Error")
                            }
                        
                             
                    }
               
            
            
        }
    }
    override func viewDidAppear(_ animated: Bool) {
            resultArray = presenter.fetchAllLeagues(appDel:appDelegate)
            
        let img=UIImageView(frame: CGRect(x:50,y:100,width:100,height:100))
                  img.image=UIImage(systemName: "icloud.slash")
                  img.tintColor = .gray
                 img.tag=20
                let labelNoData=UILabel(frame: CGRect(x: img.frame.minX, y: img.frame.maxY+15, width: img.frame.width, height: 30))
                labelNoData.text="No Data"
                labelNoData.textAlignment = .center
                labelNoData.tag=21
                if(resultArray.count == 0){
                    FavTableView.isHidden=true
                    self.view.addSubview(img)
                                         
                  self.view.addSubview(labelNoData)
                    
                }
                    
                else{
                    FavTableView.isHidden=false
                    if let viewWithTag = self.view.viewWithTag(20) {
                            viewWithTag.removeFromSuperview()
                        }else{
                            print("Error")
                        }
                    if let viewWithTag = self.view.viewWithTag(21) {
                            viewWithTag.removeFromSuperview()
                        }else{
                            print("Error")
                        }
                    
                         
                }
           
            FavTableView.reloadData()
    }
}



