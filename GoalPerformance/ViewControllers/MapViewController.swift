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
    var listFriend: [User]?
    var storyboardManager = StoryboardManager.sharedInstance
    var parentNavigationController : UINavigationController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        
        loadData()

        mapView.showsUserLocation = true
        mapView.userTrackingMode = .Follow
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let currentButton: MKUserTrackingBarButtonItem = MKUserTrackingBarButtonItem(mapView: mapView)
        self.navigationItem.rightBarButtonItem = currentButton
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.whiteColor()
    }

    let regionRadius: CLLocationDistance = 1000
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func loadData() {
        apiClient.getNearbyFriend { (friends) in
            self.listFriend = friends
            let annotations = self.displayNearbyFriend(self.listFriend!)
            
            self.mapView.addAnnotations(annotations)
        }
    }

    func displayNearbyFriend(listFriend: [User]) -> [CustomAnnotation]{
        var annotationArray: [CustomAnnotation] = [CustomAnnotation]()
        
        for friend in listFriend {
            let annotation = CustomAnnotation(friend: friend)
            annotationArray.append(annotation)
        }
        
        return annotationArray
    }
   
}

extension MapViewController: MKMapViewDelegate {
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if let myAnnotation = annotation as? CustomAnnotation {
            
            var pinView = mapView.dequeueReusableAnnotationViewWithIdentifier("CustomPinAnnotationView")
            if pinView == nil {
                pinView = MKAnnotationView(annotation: myAnnotation, reuseIdentifier: "CustomPinAnnotationView")
                pinView!.leftCalloutAccessoryView = UIImageView(frame: CGRect(x:0, y:0, width: 50, height:50))
                pinView!.canShowCallout = true
                pinView?.enabled = true
                
                pinView?.rightCalloutAccessoryView = UIButton(type: .DetailDisclosure)
            }
        
            if let imageView = pinView?.leftCalloutAccessoryView as? UIImageView {
                imageView.sd_setImageWithURL(myAnnotation.avartarUrl)
                pinView?.image = UIImage(named: "location")
            }
            
            
            
            
            return pinView
        }
        return nil
        
    }
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if let annotation = view.annotation as? CustomAnnotation {
            let user = annotation.friend
            let userVC = storyboardManager.getViewController("UserViewController", storyboard: "User") as! UserViewController
            userVC.viewingUser = user
            userVC.navigationItem.rightBarButtonItem?.enabled = false
            userVC.addGoalButton.setTitle("", forState: .Disabled)
            if let userName = user.displayName {
                userVC.navBarTitle = userName
            }
            navigationController?.pushViewController(userVC, animated: true)
        }
    }
}
