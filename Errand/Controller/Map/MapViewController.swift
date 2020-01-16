//
//  MapViewController.swift
//  Errand
//
//  Created by Jim on 2020/1/15.
//  Copyright © 2020 Jim. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class CustomPin: NSObject, MKAnnotation {
  
  var coordinate: CLLocationCoordinate2D
  
  var title: String?
  
  var subtitle: String?
  
  init(pinTitle: String, pinSubTitle: String, location: CLLocationCoordinate2D) {
    
    self.title = pinTitle
    
    self.subtitle = pinSubTitle
    
    self.coordinate = location
  }
}

class MapViewController: UIViewController, MKMapViewDelegate {
  
  let location =  CLLocationCoordinate2D(latitude: 25.033671, longitude: 121.564427)
  
  let pin = CustomPin(pinTitle: "apple", pinSubTitle: "101", location: location)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setUpLocationManager()
    
    self.realTimeMap.addAnnotation(pin)
    
  }
  
  @IBOutlet weak var realTimeMap: MKMapView!
  
  var selectAnnotation: MKPointAnnotation?
  
  let myLocationManager = CLLocationManager()
  
  let latDelta = 0.005
  
  let longDelta = 0.005
  
  override func viewDidAppear(_ animated: Bool) {
    
    super.viewDidAppear(animated)
    
    checkLocationAuth()
    
  }
  
  func checkLocationService() {
    
    if CLLocationManager.locationServicesEnabled() {
      
      checkLocationAuth()
      
    } else {
      
      alertOpen()
    }
  }
  
  func centerViewOnUserLocation() {
    
    // 地圖預設顯示的範圍大小 (數字越小越精確)
    let currentLocationSpan: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: longDelta)
    
    // 設置地圖顯示的範圍與中心點座標
    let center: CLLocation = CLLocation(latitude: 25.05, longitude: 121.515)
    
    let currentRegion: MKCoordinateRegion = MKCoordinateRegion(
      center: center.coordinate,
      span: currentLocationSpan)
    realTimeMap.setRegion(currentRegion, animated: true)
  }
  
  func setUpLocationManager() {
    
    myLocationManager.delegate = self
    
    myLocationManager.distanceFilter = kCLLocationAccuracyNearestTenMeters
    
    myLocationManager.desiredAccuracy = kCLLocationAccuracyBest
    
    realTimeMap.isZoomEnabled = true
    
  }
  
  func checkLocationAuth() {
    
    switch CLLocationManager.authorizationStatus() {
      
    case .authorizedWhenInUse:
      
      realTimeMap.showsUserLocation = true
      
      centerViewOnUserLocation()
      
      myLocationManager.startUpdatingLocation()
      
    case .denied:
      
      alertOpen()

    case .notDetermined:
      
      myLocationManager.requestWhenInUseAuthorization()
      
    case .authorizedAlways:
      
      realTimeMap.showsUserLocation = true
      
      centerViewOnUserLocation()
      
      myLocationManager.startUpdatingLocation()
      
    case .restricted:
      
      alertOpen()
      
    default:
      
      break
    }
  }
  
  func alertOpen() {
    
    let alertController = UIAlertController(title: "定位權限已關閉", message: "請至 設定 > 隱私權 > 定位服務 開啟", preferredStyle: .alert)
    
    let okAction = UIAlertAction(title: "確認", style: .default, handler: nil)
    
    alertController.addAction(okAction)
    
    self.present(alertController, animated: true, completion: nil)
  }
}

extension MapViewController: CLLocationManagerDelegate {
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

    guard let currentLocation = locations.last else { return }
    //總縮放範圍
    let range: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: longDelta)
    
    //自身
    let myLocation = currentLocation.coordinate
    
    let appearRegion: MKCoordinateRegion = MKCoordinateRegion(center: myLocation, span: range)
    
    //在地圖上顯示
    realTimeMap.setRegion(appearRegion, animated: true)
  }
  
  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    
    checkLocationAuth()
    
  }
  
  func mapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView) {
    
      self.selectAnnotation = view.annotation as? MKPointAnnotation

  }

//  func info(sender: UIButton) {
//      print(selectAnnotation?.coordinate)
//  }
  
  func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
    
    self.selectAnnotation = view.annotation as? MKPointAnnotation
    
  }
  
  func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    
    if let test = pin as? CustomPin {
      
    }
    
  }
}
