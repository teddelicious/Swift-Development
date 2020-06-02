//
//  ViewController.swift
//  MapKit-Location
//
//  Created by John Lin on 2020-05-28.
//  Copyright © 2020 John Lin. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    //MARK: Outlets
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var mapView: MKMapView!
    
    //MARK: Variables
    let defaultCoordinate = CLLocationCoordinate2DMake(43.6761, -79.4105)
    var locationManager: CLLocationManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //location usage
        self.locationManager = CLLocationManager()
        self.locationManager?.delegate = self
        
        self.locationManager?.requestWhenInUseAuthorization()
        self.locationManager?.startUpdatingLocation()
        
        //set mapView delegate
        self.mapView.delegate = self
        self.mapView.showsUserLocation = true
        
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: defaultCoordinate, span: span)
        mapView.setRegion(region, animated: true)
        
        //pin location to map
        let defaultPin = MKPointAnnotation()
        defaultPin.coordinate = defaultCoordinate
        defaultPin.title = "George Brown College"
        mapView.addAnnotation(defaultPin)
        
    }
    
    @IBAction func onButtonPressed(_ sender: Any) {
        //search for destination
        var searchedCoordinates = CLLocationCoordinate2D()
        
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = txtSearch.text
        
        let activeSearch = MKLocalSearch(request: searchRequest)
        activeSearch.start { (response, error) in
            guard let response = response else {
                print("no results")
                return
            }
            
            let places = response.mapItems
            for place in places {
                searchedCoordinates = place.placemark.coordinate
                return
            }
        }
        
        let searchedCoordinate = CLLocationCoordinate2D(latitude: 43.6544, longitude: -79.3807)
        let searchedPin = MKPointAnnotation()
        searchedPin.coordinate = searchedCoordinate
        searchedPin.title = txtSearch.text
        mapView.addAnnotation(searchedPin)
        
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: self.defaultCoordinate))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: searchedCoordinate))
        request.transportType = .automobile
        request.requestsAlternateRoutes = false
        
        let directions = MKDirections(request: request)
        directions.calculate {
            (response, error) in
            guard let response = response else {
                print("ERR: no directions found")
                return
            }
            
            for route in response.routes {
                
                for step in route.steps {
                    print(step.instructions)
                }
                self.mapView.addOverlay(route.polyline)
            }
            
        }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        print("calling delegate")
//        guard let overlay as? MKPolyline else {
//            return MKOverlayRenderer()
//        }
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.red
        renderer.lineWidth = 4
        return renderer
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        print("position (\(location.coordinate.latitude), \(location.coordinate.longitude))")
    }
    
}

