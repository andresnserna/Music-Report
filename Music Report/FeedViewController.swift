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

        // Do any additional setup after loading the view.
    }
    
    @IBAction func seg_feedPicker(_ sender: UISegmentedControl) {
    }
    @IBAction func btn_newPost(_ sender: UIButton) {
    }
    
    @IBOutlet weak var lbl_activeUsername: UILabel!
    
    @IBOutlet weak var tbl_postItems: UITableView!
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
