//Student Name: John Lin
//Student Number: 101296282
//Tested On iPad Pro (12.9-inch) (3rd generation)
//  ViewController.swift
//  lab-test-2
//
//  Created by John Lin on 2020-05-28.
//  Copyright © 2020 John Lin. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, UITableViewDelegate, UITableViewDataSource {

    //MARK: Outlets
    @IBOutlet weak var txtLat: UITextField!
    @IBOutlet weak var txtLong: UITextField!
    @IBOutlet weak var switchGeofencing: UISwitch!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: Variables
    let defaultCoordinate = CLLocationCoordinate2DMake(43.6532, -79.3832)
    let MAX_PIN_COUNT = 5
    let PIN_LABEL = ["A", "B", "C", "D", "E"]
    var pins: [MKPointAnnotation] = []
    var directions: [String] = []
    var locationManager: CLLocationManager?
    
    /*test data
     Toronto: 43.6532, -79.3832
     Mississauga: 43.5890, -79.6441
     Oakville: 43.4675, -79.6877
     Orangeville: 43.9200, -80.0943
     Tobermory: 45.2534, -81.6645
     Ottawa: 45.4215, -75.6972
    */
    
    //MARK: Helper functions
    func drawNewestPolyline() {
        let fromCoordinate = self.pins[self.pins.count - 1].coordinate
        let toCoordinate = self.pins[self.pins.count - 2].coordinate
        let locations = [fromCoordinate, toCoordinate]
        let polyline = MKPolyline(coordinates: locations, count: locations.count)
        mapView.addOverlay(polyline)
    }
    
    func getNewestRouteSteps(fromIndex: Int, toIndex: Int) {
        let fromCoordinate = self.pins[fromIndex].coordinate
        let toCoordinate = self.pins[toIndex].coordinate
        
        //setup request
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: fromCoordinate))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: toCoordinate))
        request.transportType = .automobile

        //get directions
        let directions = MKDirections(request: request)
        directions.calculate { (res, err) in
            guard let response = res else {
                self.showMessage(title: "Error", message: "No direction can be found", buttonHandler: nil)
                return
            }
            self.directions.append("Driving Directions from \(self.PIN_LABEL[fromIndex]) to \(self.PIN_LABEL[toIndex])")
            let getTimeClosure = {
                (t: TimeInterval) -> String in
                let time = Int(t)
                let second = 60
                let hour = second * 60
                let day = hour * 24
                let hms = (d: time / day, h: (time % day) / hour, m: ((time % day) % hour) / second, s: ((time % day) % hour) % second)
                return "\(hms.d)d, \(hms.h)h, \(hms.m)m, \(hms.s)s"
            }
            //add route direction for tableView
            for route in response.routes {
                self.directions.append("Estimated time: \(getTimeClosure(route.expectedTravelTime))")
                for step in route.steps {
                    self.directions.append(step.instructions)
                }
            }
            self.tableView.reloadData()
        }
        
    }
    
    func geofencingCheck(currentCoordinate: CLLocationCoordinate2D) -> Bool{
        for pin in self.pins {
            let coordinate = pin.coordinate
            let region = CLCircularRegion(center: coordinate, radius: CLLocationDistance(exactly: 1000)!, identifier: "geofencing")
            if region.contains(currentCoordinate) {
                return true
            }
        }
        return false
    }
    
    func showMessage(title: String, message: String, buttonHandler: ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "ok", style: .default, handler: buttonHandler))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK: Overridden functions
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        mapView.delegate = self
        self.locationManager = CLLocationManager()
        self.locationManager?.delegate = self
        
        //request permission
        self.locationManager?.requestWhenInUseAuthorization()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        //set default region & zoom level
        let span = MKCoordinateSpan(latitudeDelta: 2, longitudeDelta: 2)
        let region = MKCoordinateRegion(center: self.defaultCoordinate, span: span)
        mapView.setRegion(region, animated: true)
        
    }

    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        //is a polyline
        if let overlay = overlay as? MKPolyline {
            let renderer = MKPolylineRenderer(overlay: overlay)
            renderer.strokeColor = UIColor.red
            renderer.lineWidth = 4
            return renderer
        }
        
        // not polyline
        return MKOverlayRenderer()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.directions.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = self.directions[indexPath.row]
        return cell
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        //update map to current location
        let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 3000, longitudinalMeters: 3000)
        mapView.setRegion(region, animated: true)
        
        //check if current location is within 1km of any of the coordinates
        if geofencingCheck(currentCoordinate: location.coordinate) {
            self.view.backgroundColor = UIColor.green
        }else {
            self.view.backgroundColor = UIColor.white
        }
    }
    
    //MARK: Actions
    @IBAction func onAddPressed(_ sender: Any) {
        if self.pins.count < self.MAX_PIN_COUNT {
            
            guard let latString = txtLat.text else {
                showMessage(title: "Error", message: "Please enter the latitude", buttonHandler: nil)
                return
            }
            guard let longString = txtLong.text else {
                showMessage(title: "Error", message: "Please enter the longitude", buttonHandler: nil)
                return
            }
            
            guard let latitude = Double(latString) else {
                showMessage(title: "Error", message: "Latitude must be a number", buttonHandler: nil)
                return
            }
            
            guard let longitude = Double(longString) else {
                showMessage(title: "Error", message: "Longitude must be a number", buttonHandler: nil)
                return
            }
            
            let pin = MKPointAnnotation()
            pin.coordinate = CLLocationCoordinate2DMake(latitude, longitude)
            pin.title = self.PIN_LABEL[self.pins.count]
            
            //add new pin
            self.pins.append(pin)
            mapView.addAnnotation(pin)
            
            //draw the new polyline if available
            if self.pins.count > 1 {
                drawNewestPolyline()
                getNewestRouteSteps(fromIndex: self.pins.count - 2, toIndex: self.pins.count - 1)
            }
        }else {
            showMessage(title: "Error", message: "Cannot add more than 5 pins", buttonHandler: nil)
        }
    }
    
    @IBAction func onClearPressed(_ sender: Any) {
        mapView.removeAnnotations(self.pins)
        for overlay in mapView.overlays {
            if let polyline = overlay as? MKPolyline {
                mapView.removeOverlay(polyline)
            }
        }
        self.pins.removeAll()
        self.directions.removeAll()
        txtLat.text = nil
        txtLong.text = nil
    }
    
    @IBAction func onGFSwitchChanged(_ sender: Any) {
        switch(CLLocationManager.authorizationStatus()) {
        case .authorizedAlways:
            break
        case .authorizedWhenInUse:
            break
        default:
            showMessage(title: "Error", message: "App does not have the proper permission to use this feature", buttonHandler: {
                (UIAlertAction) in
                self.switchGeofencing.isOn = false
            })
            return
        }
        if switchGeofencing.isOn {
            mapView.showsUserLocation = true
            self.locationManager?.startUpdatingLocation()
        }else {
            mapView.showsUserLocation = false
            self.locationManager?.stopUpdatingLocation()
            self.view.backgroundColor = UIColor.white
        }
    }

}

