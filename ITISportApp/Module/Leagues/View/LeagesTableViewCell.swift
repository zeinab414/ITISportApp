//
//  LeagesTableViewCell.swift
//  ITISportApp
//
//  Created by user189294 on 5/11/22.
//  Copyright © 2022 ititeam. All rights reserved.
//

import UIKit

class LeagesTableViewCell: UITableViewCell {

    @IBOutlet weak var leagsImage: UIImageView!
    
    @IBOutlet weak var leagsName: UILabel!
    @IBAction func btnDiplayVideo(_ sender: UIButton) {
        var tableCell=LeagsViewController()
        tableCell.diplayYoutubeVideo()
        print("hello btn")
    }
}
