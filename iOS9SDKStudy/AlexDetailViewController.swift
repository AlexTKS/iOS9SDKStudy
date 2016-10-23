//
//  AlexDetailViewController.swift
//  iOS9SDKStudy
//
//  Created by Александр on 15.09.16.
//  Copyright © 2016 Александр. All rights reserved.
//

import UIKit

class AlexDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var detailImage: UIImageView!
	@IBOutlet weak var RateButton: UIButton!
	
	var restaurant:Restaurant!//.init(name: "", type: "", location: "", phoneNumber: "", image: "", isVisited: false)
	private let iBeenHere = "Я был здесь"
	private let tel = "Телефон"
	
	override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		
		if let restaurantImage = restaurant.mainToPhoto?.photo{
			detailImage.image = UIImage.init(data: restaurantImage)
		}
		title = restaurant.name
		tableView.estimatedRowHeight = 36
		tableView.rowHeight = UITableViewAutomaticDimension
		
		UpdateRateButtonImage()
		
    }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.hidesBarsOnSwipe = false
		navigationController?.setNavigationBarHidden(false, animated: animated)
	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		// #warning Incomplete implementation, return the number of sections
		return 1
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		// #warning Incomplete implementation, return the number of rows
		return 5
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell = tableView.dequeueReusableCell(withIdentifier: "rCell", for: indexPath) as! AlexDetailCell
		switch indexPath.row {
		case 0:
			cell.SetCell(pNameL: "Имя", pValueL: restaurant.name)
		case 1:
			cell.SetCell(pNameL: "Тип", pValueL: restaurant.type)
		case 2:
			cell.SetCell(pNameL: "Где найти", pValueL: restaurant.location)
		case 3:
			if let phoneNumber = restaurant.phoneNumber{
				cell.SetCell(pNameL: tel, pValueL: phoneNumber)
			}else{
				cell.SetCell(pNameL: tel, pValueL: "")
			}
		case 4:
			cell.SetCell(pNameL: iBeenHere, pValueL: (restaurant.isVisited) ? "Да": "Нет")
		default:
			cell.SetCell(pNameL: "", pValueL: "")
		}
		return cell
		
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let cell = tableView.cellForRow(at: indexPath) as! AlexDetailCell
		if cell.pName.text == iBeenHere
		{
			let listController = navigationController!.viewControllers[0] as! AlexUITableTableViewController
			restaurant.isVisited = !restaurant.isVisited
			cell.SetCell(pNameL: iBeenHere, pValueL: (restaurant.isVisited) ? "Да": "Нет")
			listController.renewSelectedCell(nil, row: nil)
		}
	}


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
		if segue.identifier! == "RateLink" {
			let detViewController = segue.destination as! AlexRateController
			if let restaurantImage = restaurant.mainToPhoto?.photo{
				detViewController.ImageData = restaurantImage
			}else{
				detViewController.ImageData = restaurant.image
			}
			detViewController.RestoranName = restaurant.name
		}else if segue.identifier! == "MapLink"{
			let detViewController = segue.destination as! AlexMapViewController
			detViewController.restaurant = restaurant
		}
    }
	
	private func UpdateRateButtonImage() -> Void{
		RateButton.setImage(UIImage(named: restaurant.ratingRaw!), for: UIControlState.normal)
	}
	
	@IBAction func close(segue: UIStoryboardSegue){
		if segue.source is AlexRateController{
			let RatingVC = segue.source as! AlexRateController
			if let rating = RatingVC.rating{
				restaurant.rating = rating
				restaurant.RenewRating()
			}
			UpdateRateButtonImage()
		}
		
	}

}
