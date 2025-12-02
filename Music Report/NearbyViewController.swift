//
//  NearbyViewController.swift
//  Music Report
//
//  Created by Andrés Serna on 11/24/25.
//

import UIKit
import MapKit

class NearbyViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var lbl_activeUsername: UILabel!
    @IBOutlet weak var map_MapView: MKMapView!
    
    @IBOutlet weak var tbl_eventItems: UITableView!
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
