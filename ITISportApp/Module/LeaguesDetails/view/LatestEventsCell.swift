//
//  LatestEventsCell.swift
//  ITISportApp
//
//  Created by user189294 on 5/14/22.
//  Copyright © 2022 ititeam. All rights reserved.
//

import UIKit

class LatestEventsCell: UICollectionViewCell {
    
    @IBOutlet weak var latestEvent_cellBackgroundImage: UIImageView!
    
    @IBOutlet weak var firstTeamScoreLabel: UILabel!
    
    @IBOutlet weak var latestEvent_firstTeamNameLabel: UILabel!
    
    @IBOutlet weak var latestEvent_secondteamNameLabel: UILabel!
    @IBOutlet weak var secondTeamScoreLabel: UILabel!
    
    @IBOutlet weak var latestEvent_firstTeamImage: UIImageView!
    
    
    @IBOutlet weak var latestEvent_secondTeamImage: UIImageView!
    
    @IBOutlet weak var latestEvent_timeLabel: UILabel!
    
    @IBOutlet weak var latestEvent_dateLabel: UILabel!
    @IBOutlet weak var latestEvent_VsLabel: UILabel!
}
