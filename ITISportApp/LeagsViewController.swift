//
//  LeagsViewController.swift
//  ITISportApp
//
//  Created by user189294 on 5/11/22.
//  Copyright © 2022 ititeam. All rights reserved.
//

import UIKit

class LeagsViewController: UIViewController,UITableViewDataSource  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeagsCell", for: indexPath) as! LeagesTableViewCell
        cell.leagsName.text = "Leag1"
       // cell.leagsImage.image = UIImage(named: "sport.jpeg")
        return cell
    }
    

    @IBOutlet weak var LeagsTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        LeagsTableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
