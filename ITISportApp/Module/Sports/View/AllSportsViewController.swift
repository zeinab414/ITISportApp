//
//  ViewController.swift
//  ITISportApp
//
//  Created by zeinab ibrahim on 5/11/22.
//  Copyright © 2022 ititeam. All rights reserved.
//

import UIKit
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

        cell.sportName.text = resultView[indexPath.row].title
      //  cell.sportImage.image = UIImage(named: "newfilmicon.png")
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        indicator.center = self.view.center
        self.view.addSubview(indicator)
        indicator.startAnimating()
        
        presenter = AllSportsPresenter(NWService: NetworkService())
        presenter.attachView(view: self)
        
        presenter.getSportsFromAF()
    }


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

