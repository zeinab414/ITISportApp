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
    let indicator = UIActivityIndicatorView(style: .large)
    var presenter : AllSportsPresenter!
    // Modle for View
    var resultView: [ResultView]=[] // var resultView: [ResultView]!
    //end
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       
        allSportsCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
               if let layout = allSportsCollectionView?.collectionViewLayout as? UICollectionViewFlowLayout{
                        layout.minimumLineSpacing = 0
                    layout.minimumInteritemSpacing = 0
                        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
                     
                    let size = CGSize(width : allSportsCollectionView.frame.width * 0.44999 , height: allSportsCollectionView.frame.height * 0.249)
                        layout.itemSize = size
               }
        if NetworkConnection.shared.isConnected{
            indicator.center = self.view.center
                   self.view.addSubview(indicator)
                   indicator.startAnimating()
                   
                   presenter = AllSportsPresenter(NWService: NetworkService())
                   presenter.attachView(view: self)
                   
                   presenter.getSportsFromAF()
        }
        else{
            allSportsCollectionView.isHidden=true
                         let img=UIImageView(frame: CGRect(x:50,y:100,width:100,height:100))
                              img.image=UIImage(systemName: "icloud.slash")
                              img.tintColor = .gray
                              self.view.addSubview(img)
                              let labelNoData=UILabel(frame: CGRect(x: img.frame.minX, y: img.frame.maxY+15, width: img.frame.width, height: 30))
                              labelNoData.text="No Inernet"
                              labelNoData.textAlignment = .center
                              self.view.addSubview(labelNoData)
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           return resultView.count
           
       }
       
       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sportCell", for: indexPath) as! SportCellCollectionViewCell
           let url = URL(string: resultView[indexPath.row].image)
           cell.sportName.text = resultView[indexPath.row].title
       
           cell.sportImage.kf.setImage(with: url)
           return cell
       }
  
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           return CGSize(width: UIScreen.main.bounds.width/2, height: UIScreen.main.bounds.height/CGFloat(resultView.count))
                }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
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


   
}
extension AllSportsViewController : SportsProtocol {
    func stopAnimating() {
        indicator.stopAnimating()
        
    }
    func renderTableView(){
        
        resultView = presenter.resultFromAF.map({ (item) -> ResultView in
            var res:ResultView=ResultView(title:item.title ?? "",image:item.image ?? "")
            return res
        })
       self.allSportsCollectionView.reloadData()
      

 
    }
}


