//
//  ViewController.swift
//  ITISportApp
//
//  Created by zeinab ibrahim on 5/11/22.
//  Copyright © 2022 ititeam. All rights reserved.
//

import UIKit

class AllSportsViewController: UIViewController , UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sportCell", for: indexPath) as! SportCellCollectionViewCell
//        let label = UILabel(frame: CGRect(x: 0, y: 0, width: cell.bounds.width, height: 30
//        ))
//        label.text = "sport"
//        cell.addSubview(label)
        cell.sportName.text = "sport"
        cell.sportImage.image = UIImage(named: "newfilmicon.png")
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

