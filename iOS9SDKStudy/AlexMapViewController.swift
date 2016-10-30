//
//  AlexmapViewViewController.swift
//  iOS9SDKStudy
//
//  Created by Александр on 17.09.16.
//  Copyright © 2016 Александр. All rights reserved.
//

import UIKit
import MapKit

class AlexMapViewController: UIViewController, MKMapViewDelegate {

	@IBOutlet weak var mapView: MKMapView!
	
	var restaurant: Restaurant!
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		
		let GeoCoder = CLGeocoder()
		GeoCoder.geocodeAddressString(restaurant.location) { (Placemarks, Error) in
			if Error != nil{
				let Alert = UIAlertController.init(title: "Произошла ошибка получения адреса", message: Error as? String, preferredStyle: .alert)
				let AlertAction = UIAlertAction.init(title: "OK", style: .cancel, handler: nil)
				Alert.addAction(AlertAction)
				self.present(Alert, animated: true, completion: nil)
				return
			}
			
			if let Placemarks = Placemarks {
				let Placemark = Placemarks[0]
				
				if let location = Placemark.location{
					let annotation = MKPointAnnotation()
					annotation.title = self.restaurant.name
					annotation.subtitle = self.restaurant.type
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
	
	func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
		let identifier = "MyPin"
		
		if annotation.isKind(of: MKUserLocation.self) {
			return nil
		}
		
		var annotationView: MKPinAnnotationView? = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
		
		if annotationView == nil {
			annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
			annotationView?.canShowCallout = true
		}
		
		let lefIconView = UIImageView(frame: CGRect(x: 0, y: 0, width: 53, height: 53))
		lefIconView.image = UIImage(data: restaurant.image!)
		annotationView?.leftCalloutAccessoryView = lefIconView
		
		return annotationView
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
