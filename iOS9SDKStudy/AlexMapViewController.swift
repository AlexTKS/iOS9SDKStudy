//
//  AlexmapViewViewController.swift
//  iOS9SDKStudy
//
//  Created by Александр on 17.09.16.
//  Copyright © 2016 Александр. All rights reserved.
//

import UIKit
import MapKit

class AlexMapViewController: UIViewController {

	@IBOutlet weak var mapView: MKMapView!
	
	var restaurant: Restaurant!
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		
		let GeoCoder = CLGeocoder()
		GeoCoder.geocodeAddressString(restaurant.Location) { (Placemarks, Error) in
			if Error != nil{
				// alert
				return
			}
			
			if let Placemarks = Placemarks {
				let Placemark = Placemarks[0]
				
				if let location = Placemark.location{
					let annotation = MKPointAnnotation()
					annotation.title = self.restaurant.Name
					annotation.subtitle = self.restaurant.Type
					annotation.coordinate = location.coordinate
					self.mapView.showAnnotations([annotation], animated: true)
					self.mapView.selectAnnotation(annotation, animated: true)
				}
			}
		}
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
