//
//  EventInfoViewController.swift
//  Music Report
//
//  Created by Andrés Serna on 11/24/25.
//

import UIKit
import MapKit

class EventInfoViewController: UIViewController {
    
    var selectedEvent: Event?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var map_eventMapView: MKMapView!
    @IBOutlet weak var lbl_eventTitle: UILabel!
    @IBOutlet weak var lbl_eventAddress: UILabel!
    @IBOutlet weak var lbl_eventDate: UILabel!
    @IBOutlet weak var lbl_eventDescription: UILabel!
    @IBAction func btn_getTickets(_ sender: Any) {
    }
    
}
