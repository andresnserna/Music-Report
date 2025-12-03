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
    
    @IBOutlet weak var lbl_activeUsername: UILabel!
    @IBOutlet weak var map_MapView: MKMapView!
    
    @IBOutlet weak var tbl_eventItems: UITableView!

}
