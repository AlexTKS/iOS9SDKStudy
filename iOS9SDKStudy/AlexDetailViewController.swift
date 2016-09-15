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
	
	var restaurant = Restaurant.init(name: "", type: "", location: "", phoneNumber: "", image: "", isVisited: false)
	private let iBeenHere = "Я был здесь"
	private let tel = "Телефон"
	
	override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		
		detailImage.image = UIImage.init(named: restaurant.Image)
		title = restaurant.Name
		//tableView.estimatedRowHeight = 36
		//tableView.rowHeight = UITableViewAutomaticDimension
		
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
			cell.SetCell(pNameL: "Имя", pValueL: restaurant.Name)
		case 1:
			cell.SetCell(pNameL: "Тип", pValueL: restaurant.Type)
		case 2:
			cell.SetCell(pNameL: "Где найти", pValueL: restaurant.Location)
		case 3:
			cell.SetCell(pNameL: tel, pValueL: restaurant.phoneNumber)
		case 4:
			cell.SetCell(pNameL: iBeenHere, pValueL: (restaurant.IsVisited) ? "Да": "Нет")
		default:
			cell.SetCell(pNameL: "", pValueL: "")
		}
		return cell
		
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
