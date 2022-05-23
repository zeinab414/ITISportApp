//
//  LeagsViewController.swift
//  ITISportApp
//
//  Created by user189294 on 5/11/22.
//  Copyright © 2022 ititeam. All rights reserved.
//

import UIKit
import Kingfisher

class LeagsViewController: UIViewController,UITableViewDataSource,UITableViewDelegate  {
    var sportName:String=""
    var youtubeLink:String=""
    
     let indicator = UIActivityIndicatorView(style: .large)
    var presenter :LeaguesPresenter!
       // Modle for View
       var resultView: [LeaguesValues]=[]
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        return resultView.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeagsCell", for: indexPath) as! LeagesTableViewCell
        cell.leagsImage.layer.cornerRadius = cell.leagsImage.frame.height / 2
        cell.leagsImage.layer.masksToBounds = true
        cell.leagsImage.backgroundColor = .gray
        
        cell.leagsName.text = resultView[indexPath.row].leagueName
        let url = URL(string: resultView[indexPath.row].leagueImage)
        cell.leagsImage.kf.setImage(with: url)
        
        cell.btnDiplayVideo.tag=indexPath.row
        cell.btnDiplayVideo.addTarget(self, action: #selector(displayYoutubeVideo), for: .touchUpInside)
        return cell
    }
    @objc func displayYoutubeVideo(sender:UIButton){
        let myindexPath=IndexPath(row: sender.tag, section: 0)
        print("hello display")
        let youtubeId = "SxTYjptEzZs"
        youtubeLink=resultView[myindexPath.row].youtubeLink
        var youtubeUrl = NSURL(string:"youtube://\(youtubeId)")!
        if UIApplication.shared.canOpenURL(youtubeUrl as URL){
               UIApplication.shared.openURL(youtubeUrl as URL)
                    } else{
                        var myUrl=youtubeLink
                         if(myUrl.isEmpty){
                             myUrl="www.youtube.com/watch?v=AcVtT2d8-kk"
                               }
                               youtubeUrl = NSURL(string:"https://"+myUrl)!
                               UIApplication.shared.openURL(youtubeUrl as URL)
                           }
    }
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let vc = storyboard?.instantiateViewController(withIdentifier: "LeaguesDetailsID") as? LeaguesDetailsViewController
    vc?.legID = resultView[indexPath.row].leagueID
    vc?.legName = resultView[indexPath.row].leagueName
    vc?.myLeagueResult = resultView[indexPath.row]
    present(vc!, animated: true, completion: nil)
      
     }

    @IBOutlet weak var LeagsTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        LeagsTableView.dataSource = self
        LeagsTableView.delegate = self
        // Do any additional setup after loading the view.
        
        indicator.center = self.view.center
        self.view.addSubview(indicator)
        indicator.startAnimating()
        
        presenter = LeaguesPresenter(NWService: NetworkService())
        presenter.attachView(view: self)
        
        presenter.getLeaguesFromAF(myEndPoint: sportName)
      
 
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

}
extension LeagsViewController : SportsProtocol {
    func stopAnimating() {
        indicator.stopAnimating()
        // I have the result
        //presenter.result
    }
    func renderTableView(){
        
        resultView = presenter.resultFromAF.map({ (item) -> LeaguesValues in
            var res:LeaguesValues=LeaguesValues(leagueImage:item.leagueImage ?? "",leagueName:item.leagueName ?? "",youtubeLink:item.youtubeLink ?? "",leagueCountry: item.leagueCountry,leagueID: item.leagueID)
            return res
        })
        if resultView.count==0{
                   LeagsTableView.isHidden=true
                   let img=UIImageView(frame: CGRect(x:50,y:100,width:100,height:100))
                        img.image=UIImage(systemName: "icloud.slash")
                        img.tintColor = .gray
                        self.view.addSubview(img)
                        let labelNoData=UILabel(frame: CGRect(x: img.frame.minX, y: img.frame.maxY+15, width: img.frame.width, height: 30))
                        labelNoData.text="No Data"
                        labelNoData.textAlignment = .center
                        self.view.addSubview(labelNoData)
               }
        self.LeagsTableView.reloadData()
      

 
    }
}
   
   
        




