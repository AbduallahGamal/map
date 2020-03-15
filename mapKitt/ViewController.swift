//
//  ViewController.swift
//  mapKitt
//
//  Created by Abdalla on 3/15/20.
//  Copyright © 2020 edu.data. All rights reserved.
//
import UIKit
import MapKit

class ViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    var regionInMeters: Double = 30.591681
    var regionInMeterx: Double = 31.4791707
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocationService()
    }
    
    func setUpLocationManager() {
           locationManager.delegate = self
           locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func centerViewOnUserLocation() {
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeterx)
            mapView.setRegion(region, animated: true)
        }
    }

    func checkLocationService() {
        if CLLocationManager.locationServicesEnabled(){
            setUpLocationManager()
            checkLocationServices()
        } else {
            
        }
    }
    
    func checkLocationServices() {
        switch CLLocationManager.authorizationStatus(){
        case .authorizedWhenInUse:
            mapView.showsUserLocation = true
            centerViewOnUserLocation()
            locationManager.startUpdatingLocation()
            break
        case .denied:
            break
        case .authorizedAlways:
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            break
        case .restricted:
            break
        @unknown default:
            print("Error")
        }
    }
}
extension ViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion.init(center: center, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeterx)
        mapView.setRegion(region, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationServices()
    }
}

