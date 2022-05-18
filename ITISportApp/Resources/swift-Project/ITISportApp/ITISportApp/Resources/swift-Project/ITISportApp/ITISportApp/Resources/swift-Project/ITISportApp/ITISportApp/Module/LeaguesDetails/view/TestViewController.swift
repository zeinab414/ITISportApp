//
//  TestViewController.swift
//  ITISportApp
//
//  Created by user189294 on 5/14/22.
//  Copyright © 2022 ititeam. All rights reserved.
//

import UIKit

class TestViewController: UIViewController ,UICollectionViewDelegate,UICollectionViewDataSource {
    
    @IBOutlet weak var CV1: UICollectionView!
    
    
    @IBOutlet weak var Cv2: UICollectionView!
    
    var labelArray1 = ["Hend","Mona","Ahmed"]
    
    var labelArray2 = ["Ola","Mai","Omar"]
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView == self.CV1){
            return labelArray1.count
        }
        else{
            return labelArray2.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (collectionView == self.CV1){
            let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! TestCollectionViewCell
            cell1.lable1.text = labelArray1[indexPath.row]
            return cell1
        }
        else{
            let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! TestCollectionViewCell
            cell2.lable2.text = labelArray2[indexPath.row]
            return cell2
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        CV1.delegate = self
        CV1.dataSource = self
        Cv2.delegate = self
        Cv2.dataSource = self

      
    }
    

    

}
