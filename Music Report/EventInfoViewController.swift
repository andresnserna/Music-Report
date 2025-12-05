//
//  EventInfoViewController.swift
//  Music Report
//
//  Created by Andrés Serna on 11/24/25.
//

import UIKit
import MapKit

class EventInfoViewController: UIViewController {
    
    var selectedEvent: Events_fromJSON?

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Call it here instead, after selectedEvent has been set
        populateEventInfoVCLabels()
    }
    
    @IBOutlet weak var map_eventMapView: MKMapView!
    @IBOutlet weak var lbl_eventTitle: UILabel!
    @IBOutlet weak var lbl_eventAddress: UILabel!
    @IBOutlet weak var lbl_eventDate: UILabel!
    @IBOutlet weak var lbl_eventDescription: UILabel!
    
    @IBAction func btn_getTickets(_ sender: Any) {
        guard let event = selectedEvent else { return }
        
        // ticketmaster search for the event name
        let searchQuery = event.name
        let encodedQuery = searchQuery.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let searchURL = "https://www.ticketmaster.com/search?q=\(encodedQuery)"
        
        if let url = URL(string: searchURL) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    func populateEventInfoVCLabels() {
        guard let event = selectedEvent else { return }
        lbl_eventTitle.text = event.name
        lbl_eventAddress.text = event.address
        lbl_eventDate.text = event.date_START
        lbl_eventDescription.text = event.event_description
    }
    
}
