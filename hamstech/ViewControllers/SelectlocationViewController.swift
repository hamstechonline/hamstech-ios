//
//  SelectlocationViewController.swift
//  hamstech
//
//  Created by Priyanka on 04/06/20.
//
import UIKit
import GoogleMaps

protocol LocationSendingDelegate: class {
    
    func Locationdata(address: String, Latitude: Double, Longitude: Double, city : String)
   
}



class SelectlocationViewController: UIViewController, GMSMapViewDelegate,CLLocationManagerDelegate {

    @IBOutlet weak var main_View: UIView!
    @IBOutlet weak var map_View: GMSMapView!
    @IBOutlet weak var address_Lbl: UILabel!
    
    
weak var delegate: LocationSendingDelegate?

var marker = GMSMarker()
var locationManager = CLLocationManager()
var city = String()

    override func viewDidLoad() {
        super.viewDidLoad()

        applyShadowOnView(main_View)
        
         let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissView))
               view.addGestureRecognizer(tapGesture)
    
    
                  var currentLoc: CLLocation!
                   
                   if(CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
                   CLLocationManager.authorizationStatus() == .authorizedAlways) {
                       
                   currentLoc = locationManager.location
                       
                   }
                   
                   if currentLoc == nil {
                       
                       currentLoc = CLLocation(latitude: 17.438766, longitude: 78.453033)
                       
                   } else {
                      
                       currentLoc = CLLocation(latitude: currentLoc.coordinate.latitude, longitude: currentLoc.coordinate.longitude)
                       
                   }
            
            
             marker.position = CLLocationCoordinate2DMake(currentLoc.coordinate.latitude,currentLoc.coordinate.longitude)
             map_View.delegate = self
             map_View.isMyLocationEnabled = true
             marker.map = map_View
             map_View.camera = GMSCameraPosition.camera(withTarget: marker.position, zoom: 10)
             marker.isDraggable = true
            getAddressFromLatLon(pdblLatitude: marker.position.latitude, withLongitude: marker.position.longitude)
            
      
        }
        
        
         @objc func dismissView() {
            
            self.delegate?.Locationdata(address: address_Lbl.text!, Latitude: marker.position.latitude, Longitude: marker.position.longitude, city: city)
            
             self.dismiss(animated: true, completion: nil)
            
           }
         
         override func viewWillAppear(_ animated: Bool) {
                
                self.navigationController?.navigationBar.isHidden = true
            }
        
        

        
            func mapView (_ mapView: GMSMapView, didEndDragging didEndDraggingMarker: GMSMarker) {

               getAddressFromLatLon(pdblLatitude: marker.position.latitude, withLongitude: marker.position.longitude)

           }

        func getAddressFromLatLon(pdblLatitude: Double, withLongitude pdblLongitude: Double) {
            var center : CLLocationCoordinate2D = CLLocationCoordinate2D()

            let lat: Double = pdblLatitude
            //21.228124
            let lon: Double = pdblLongitude
            //72.833770
            let ceo: CLGeocoder = CLGeocoder()
            center.latitude = lat
            center.longitude = lon

            let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)


            ceo.reverseGeocodeLocation(loc, completionHandler:
                {(placemarks, error) in
                    if (error != nil)
                    {
                        print("reverse geodcode fail: \(error!.localizedDescription)")
                    }
                    let pm = placemarks! as [CLPlacemark]

                    if pm.count > 0 {

                        let pm = placemarks![0]

                        var addressString : String = ""
                        if pm.subLocality != nil {
                            addressString = addressString + pm.subLocality! + ", "
                        }
                        if pm.thoroughfare != nil {
                            addressString = addressString + pm.thoroughfare! + ", "
                        }
                        if pm.locality != nil {
                            addressString = addressString + pm.locality! + ", "
                            self.city = pm.locality!
                            
                        }
                        if pm.country != nil {
                            addressString = addressString + pm.country! + ", "
                        }
                        if pm.postalCode != nil {
                            addressString = addressString + pm.postalCode! + " "
                        }

                        
                        self.address_Lbl.text = addressString


                  }
            })

        }
        
        
        
    }
