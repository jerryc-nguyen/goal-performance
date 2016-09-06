//
//  MapViewController.swift
//  GoalPerformance
//
//  Created by sophie on 8/24/16.
//  Copyright © 2016 Group 7. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    var apiClient = APIClient.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let initialLocation = CLLocation(latitude: 21.282778, longitude: -157.829444)
        centerMapOnLocation(initialLocation)
        
        var currentButton: MKUserTrackingBarButtonItem = MKUserTrackingBarButtonItem(mapView: mapView)
        
        self.navigationItem.rightBarButtonItem = currentButton
        
    }

    let regionRadius: CLLocationDistance = 1000
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }

    func displayNearbyFriend(listFriend: [User]) {
        for friend in listFriend {
            
        }
    }
    
}

//extension MapViewController: MKMapViewDelegate {
//    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
//        if let myAnnotation = annotation as? CustomAnnotation {
//            
//            var pinView = mapView.dequeueReusableAnnotationViewWithIdentifier("CustomPinAnnotationView")
//            if pinView == nil {
//                pinView = MKAnnotationView(annotation: myAnnotation, reuseIdentifier: "CustomPinAnnotationView")
//                pinView?.rightCalloutAccessoryView = UIButton(type: .DetailDisclosure)
//                pinView?.canShowCallout = true
//                pinView?.calloutOffset = CGPoint(x: 0.0, y: 4.0)
//                pinView?.contentMode = .ScaleAspectFill
//            } else {
//                
//                pinView?.annotation = annotation
//            }
//            
//            pinView?.image = UIImage(
//            
//            return pinView
//        }
//        return nil
//        
//    }
//}
