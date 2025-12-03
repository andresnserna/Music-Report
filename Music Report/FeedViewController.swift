//
//  FeedViewController.swift
//  Music Report
//
//  Created by Andrés Serna on 11/24/25.
//

import UIKit

class FeedViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if let username = activeUser {
            lbl_activeUsername.text = "@\(username)"
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let username = activeUser {
            lbl_activeUsername.text = "@\(username)"
        }
    }
    
    @IBAction func seg_feedPicker(_ sender: UISegmentedControl) {
    }
    @IBAction func btn_newPost(_ sender: UIButton) {
    }
    
    @IBOutlet weak var lbl_activeUsername: UILabel!
    
    @IBOutlet weak var tbl_postItems: UITableView!
    

}
