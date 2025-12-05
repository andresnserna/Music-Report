//
//  NearbyViewController.swift
//  Music Report
//
//  Created by Andrés Serna on 11/24/25.
//

import UIKit
import MapKit

class NearbyViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let event = events[indexPath.row]
                
        if event.hot_event {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "HotEventCell", for: indexPath) as? HotEventCell else {
                return UITableViewCell()
            }
            cell.configure(with: event)
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "RegularEventCell", for: indexPath) as? RegularEventCell else {
                return UITableViewCell()
            }
            cell.configure(with: event)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "showEventInfo", sender: indexPath)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showRegularEventInfo" {
            if let indexPath = sender as? IndexPath,
               let destinationVC = segue.destination as? EventInfoViewController {
                print("Sending this event: \(events[indexPath.row])")
                destinationVC.selectedEvent = events[indexPath.row]
            }
        }
        
        if segue.identifier == "showHotEventInfo" {
            if let indexPath = sender as? IndexPath,
               let destinationVC = segue.destination as? EventInfoViewController {
                print("Sending this event: \(events[indexPath.row])")
                destinationVC.selectedEvent = events[indexPath.row]
            }
        }
    }
    

    var events = [Events_fromJSON]()  // Array to hold events

    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let username = activeUser {
            lbl_activeUsername.text = "@\(username)"
        }
        
        // Set up table view
        tbl_eventItems.dataSource = self
        tbl_eventItems.delegate = self
        
        // Load events
        loadEvents_local()
        
        //set map region based on all the events loaded AND add pins to map
        loadMap()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let username = activeUser {
            lbl_activeUsername.text = "@\(username)"
        }
    }
    
    func loadEvents_local() {
        events = loadEvents()  // Load from JSON
        tbl_eventItems.reloadData()
    }
    
    func loadMap() {
        //var annotations: [MKAnnotation] = []
        var averageLat: Double = 0
        var averageLon: Double = 0
        var count: Int = 0
        let latDelta = CLLocationDistance(exactly: 50)!
        let lonDelta = CLLocationDistance(exactly: 50)!
        
        for event in events {
            //set averaging vars
            averageLat += event.event_LAT
            averageLon += event.event_LON
            count += 1
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(
                //cast these floats to doubles
                latitude: event.event_LAT,
                longitude: event.event_LON
            )
            annotation.title = event.name
            
            map_MapView.addAnnotation(annotation)
        }
        
        averageLat /= Double(count)
        averageLon /= Double(count)
        
        map_MapView.setRegion(MKCoordinateRegion(
            center: CLLocationCoordinate2D(
                latitude: averageLat,
                longitude: averageLon
            ),
            span: MKCoordinateSpan(
                latitudeDelta: latDelta,
                longitudeDelta: lonDelta
            )
        ), animated: true)
    }
    
    @IBOutlet weak var lbl_activeUsername: UILabel!
    @IBOutlet weak var map_MapView: MKMapView!
    
    @IBOutlet weak var tbl_eventItems: UITableView!

}
