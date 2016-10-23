//
//  AlexUITableTableViewController.swift
//  iOS9SDKStudy
//
//  Created by Александр on 11.09.16.
//  Copyright © 2016 Александр. All rights reserved.
//

import UIKit

class AlexUITableTableViewController: UITableViewController, UISearchResultsUpdating {

	var restaurants: [Restaurant] = []			// Массив всех ресторанов бызы
	var searchRestaurants: [Restaurant] = []	// Массив ресторанов по результатам поиска
	var searchController: UISearchController!
	public var favoriteController = false		// Флаг отображения избранного
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = seılf.editButtonItem
		
		navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
		navigationController?.hidesBarsOnSwipe = true
		
		updateSourceData(initial: true)
		
		// Настройка контроллера поиска
		searchController = UISearchController.init(searchResultsController: nil)
		searchController.dimsBackgroundDuringPresentation = false
		searchController.searchResultsUpdater  = self
		searchController.searchBar.placeholder = "Search restaurant..."
		tableView.tableHeaderView = searchController.searchBar
		
		if favoriteController {
			navigationItem.title = "Favorite"
			navigationItem.leftBarButtonItems = nil
			navigationItem.rightBarButtonItem = nil
		}
    }
	
	public func updateSourceData(initial: Bool) {
		restaurants = Restaurant.FetchRestaurants(favoritesOnly: favoriteController)
		if !initial {
			tableView.reloadData()
		}
	}
	
	// Фильтрация результатов поиска
	func updateSearchResults(for searchController: UISearchController) {
		if let searchText = searchController.searchBar.text {
			searchRestaurants = restaurants.filter({ (Restaurant) -> Bool in
				let nameMach = Restaurant.name.range(of: searchText, options: String.CompareOptions.caseInsensitive, range: nil, locale: nil)
				let locMach  = Restaurant.location.range(of: searchText, options: String.CompareOptions.caseInsensitive, range: nil, locale: nil)
				return nameMach != nil || locMach != nil
			})
		}
		tableView.reloadData()
	}
	
	@IBAction func EditTV(_ sender: AnyObject) {
		if tableView.isEditing{
			//(sender as! UIBarButtonItem).title = "Правка"
			tableView.setEditing(false, animated: true)
			navigationController?.hidesBarsOnSwipe = true
		}else{
			//(sender as! UIBarButtonItem).title = "Готово"
			tableView.setEditing(true, animated: true)
			navigationController?.hidesBarsOnSwipe = false
		}
	}
	/*
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.hidesBarsOnSwipe = true
	}*/

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
		return searchController.isActive ? searchRestaurants.count : restaurants.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RootTableCell", for: indexPath) as! AlexTableViewCell

		cell.restaurant = searchController.isActive ? searchRestaurants[indexPath.row] : restaurants[indexPath.row]
		cell.FillCell()
		
		renewSelectedCell(cell, row: (indexPath as NSIndexPath).row)
		
        return cell
    }
	
	func renewSelectedCell(_ currentCell:AlexTableViewCell?, row:Int?) -> Void
	{
		var cell:AlexTableViewCell
		var index:Int
		
		if let cellIn = currentCell
		{
			cell = cellIn
			index = row!
		}
		else
		{
			let currentIndexPath = tableView.indexPathForSelectedRow!
			cell = tableView.cellForRow(at: currentIndexPath) as! AlexTableViewCell
			index = (currentIndexPath as NSIndexPath).row
		}
		
		if restaurants[index].isVisited
		{
			cell.accessoryType = .checkmark
		}
		else
		{
			cell.accessoryType = .none
		}
	}

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return !searchController.isActive
    }

	/*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
			restaurants.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
	*/
	
	override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
		let DeleteAction = UITableViewRowAction.init(style: .default, title: "Удалить") { (Action, indexPath) in
			// Delete the row from the data source
			self.restaurants[indexPath.row].deleteFromContext()
			self.restaurants.remove(at: indexPath.row)
			tableView.deleteRows(at: [indexPath], with: .fade)
		}
		
		let shareAction = UITableViewRowAction(style: .normal, title: "Поделиться") { (Action, indexPath) in
			let midText = (self.restaurants[indexPath.row].isVisited) ? "был" : "не был"
			let defaultText = "Я " + midText + " в ресторане " + self.restaurants[indexPath.row].name
			let active1 = UIActivity.init()
			let actionController = UIActivityViewController.init(activityItems: [defaultText], applicationActivities: [active1])
			self.present(actionController, animated: true, completion: nil)
		}
		
		return [DeleteAction, shareAction]
	}

    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to toIndexPath: IndexPath) {
		
		if fromIndexPath.row != toIndexPath.row {
			let MovingRest = restaurants[(fromIndexPath as NSIndexPath).row]
			restaurants.remove(at: (fromIndexPath as NSIndexPath).row)
			restaurants.insert(MovingRest, at: (toIndexPath as NSIndexPath).row)
		}
		
		var index = 0
		let maxIndex = restaurants.count - 1
		
		while index < maxIndex {
			if Int(restaurants[index].sortCriteria) != index {
				restaurants[index].sortCriteria = Int16(index)
			}
			index += 1
		}

    }

     // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }


    // MARK: - Navigation

	
    // In a storyboard-based application, you will often want to do a little preparation before navigation
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "detaleShowLink"
		{
			let id = tableView.indexPath(for: sender! as! AlexTableViewCell)
			let detViewController = segue.destination as! AlexDetailViewController
			detViewController.restaurant = searchController.isActive ? searchRestaurants[id!.row] : restaurants[id!.row]
		}
	}
	
	@IBAction func UnwingeToRoot(segue: UIStoryboardSegue){
		
		var SortCriteria = 0
		
		// Add SortCriteria
		for restaurant in restaurants{
			SortCriteria = max(SortCriteria, Int(restaurant.sortCriteria))
		}
		
		if segue.source is AlexAddRestViewController{
			let addVC = segue.source as! AlexAddRestViewController
			if addVC.RestoratAdded {
				addVC.addRestorant.sortCriteria = SortCriteria + 1
				restaurants.append(addVC.addRestorant)
				tableView.reloadData()
			}
		}else if segue.source is AlexDefaultFillTableViewController {
			let sourceVC = segue.source as! AlexDefaultFillTableViewController
			for defRest in sourceVC.restaurants {
				if defRest.ToAdd {
					if let AddedRest = Restaurant.AddNewRestaurant(name: defRest.Name, type: defRest.Type, location: defRest.location, phoneNumber: defRest.phoneNumber, isVisited: defRest.IsVisited) {
						SortCriteria += 1
						AddedRest.sortCriteria = Int16(SortCriteria)
						AddedRest.FillRestaurant()
						AddedRest.AddRestaurantImage(image: UIImage.init(named: defRest.Image))
						restaurants.append(AddedRest)
					}
				}
			}
			tableView.reloadData()
		}
	
	}

}
