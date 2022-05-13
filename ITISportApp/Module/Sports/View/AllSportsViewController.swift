//
//  ViewController.swift
//  ITISportApp
//
//  Created by zeinab ibrahim on 5/11/22.
//  Copyright © 2022 ititeam. All rights reserved.
//

import UIKit
import Kingfisher
protocol SportsProtocol : AnyObject{
    func stopAnimating()
    func renderTableView()
}
struct ResultView{
    var title : String = ""
    var image : String = ""
}

class AllSportsViewController: UIViewController , UICollectionViewDelegate,UICollectionViewDataSource {
    @IBOutlet weak var allSportsCollectionView: UICollectionView!
    var selectedIndex:Int=0
    
    //list
    //vars
    let indicator = UIActivityIndicatorView(style: .large)
    var presenter : AllSportsPresenter!
    // Modle for View
    var resultView: [ResultView]=[] // var resultView: [ResultView]!
    //end
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return resultView.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sportCell", for: indexPath) as! SportCellCollectionViewCell
        let url = URL(string: resultView[indexPath.row].image)
        cell.sportName.text = resultView[indexPath.row].title
      //  cell.sportImage.image = UIImage(named: "newfilmicon.png")
        cell.sportImage.kf.setImage(with: url)
        return cell
    }
  

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       // let service = NetworkService()
       // service.fetchSLeagesResultWithAF()
        
        indicator.center = self.view.center
        self.view.addSubview(indicator)
        indicator.startAnimating()
        
        presenter = AllSportsPresenter(NWService: NetworkService())
        presenter.attachView(view: self)
        
        presenter.getSportsFromAF()
    }
  
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
          
           
         //  return CGSize(width: UIScreen.main.bounds.width/CGFloat(resultView.count/2), height: UIScreen.main.bounds.height/CGFloat(resultView.count))
          
            
    
           return CGSize(width: UIScreen.main.bounds.width/2, height: UIScreen.main.bounds.height/CGFloat(resultView.count))
                }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           // var index=allSportsCollectionView.indexPathForSelectedRow
       // var index=allSportsCollectionView.indexPathsForSelectedItems
        var index=allSportsCollectionView.indexPathsForSelectedItems?.startIndex
            var vc:LeagsViewController=segue.destination as! LeagsViewController
        vc.sportName=resultView [selectedIndex].title
            
        }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex=indexPath.row
        
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "leagueID") as? LeagsViewController
        vc?.sportName = resultView[indexPath.row].title;
           self.navigationController?.pushViewController(vc!, animated: true)
    }

//leagueID
   
}
extension AllSportsViewController : SportsProtocol {
    func stopAnimating() {
        indicator.stopAnimating()
        // I have the result
        //presenter.result
    }
    func renderTableView(){
        
        resultView = presenter.resultFromAF.map({ (item) -> ResultView in
            var res:ResultView=ResultView(title:item.title ?? "",image:item.image ?? "")
            return res
        })
       self.allSportsCollectionView.reloadData()
      

 
    }
}


