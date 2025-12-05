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
        populateEventInfoVCLabels()
    }
    
    @IBOutlet weak var map_eventMapView: MKMapView!
    @IBOutlet weak var lbl_eventTitle: UILabel!
    @IBOutlet weak var lbl_eventAddress: UILabel!
    @IBOutlet weak var lbl_eventDate: UILabel!
    @IBOutlet weak var lbl_eventDescription: UILabel!
    
    @IBAction func btn_getTickets(_ sender: Any) {
        guard let event = selectedEvent else {
            print("Error grabbing event")
            return
        }
        
        // ticketmaster search for the event name
        let searchQuery = event.name
        let encodedQuery = searchQuery.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let searchURL = "https://www.ticketmaster.com/search?q=\(encodedQuery)"
        
        if let url = URL(string: searchURL) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    func populateEventInfoVCLabels() {
        guard let event = selectedEvent else {
            print("Error grabbing event")
            return
        }
        print("here is the event: \(event)")
        lbl_eventTitle.text = event.name
        lbl_eventAddress.text = event.address
        lbl_eventDate.text = event.date_START
        lbl_eventDescription.text = event.event_description
        
        // add map annotation
        let coordinate = CLLocationCoordinate2D(latitude: event.event_LAT, longitude: event.event_LON)
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = event.name
        map_eventMapView.addAnnotation(annotation)
        
        // Center map on event 
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        map_eventMapView.setRegion(region, animated: false)
    }
    
}
