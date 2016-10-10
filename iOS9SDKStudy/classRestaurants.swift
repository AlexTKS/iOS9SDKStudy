//
//  classRestaurants.swift
//  FirstTV
//
//  Created by Александр on 27.06.16.
//  Copyright © 2016 Александр. All rights reserved.
//

import Foundation
import CoreData
import UIKit

public enum RestRating: String {
	case poor  = "dislike"
	case good  = "good"
	case great = "great"
	case nRate = "rating"
}

public class Restaurant: NSManagedObject {
	
	var rating = RestRating.nRate

	// Заполнение полей значениями по умолчанию
	public func FillRestaurant(){
		
		if let ratingRawSQL = self.ratingRaw {
			self.rating = RestRating.init(rawValue: ratingRawSQL)!
		}else{
			self.rating = .nRate
			self.RenewRating()
		}
	}
	
	// Обновление установленого рейтинга для SQL
	public func RenewRating() {
		self.ratingRaw = self.rating.rawValue
	}
	
	// Удаление ресторана из БД
	public func deleteFromContext() {
		if let managedObjectContext = (UIApplication.shared.delegate as? AppDelegate)?.managedObjectContext {
			managedObjectContext.delete(self)
		}
	}
	
}

// Создание в базе нового ресторана
public func AddNewRestaurant(name: String, type: String, location: String, phoneNumber: String, imageName: String?, imageData: Data?, isVisited: Bool) -> Restaurant? {
	
	// Проверка на валидность введенных строк
	if name == "" || type == "" || location == "" {
		return nil
	}
	
	if let managedObjectContext = (UIApplication.shared.delegate as? AppDelegate)?.managedObjectContext {
		let addRestorant = NSEntityDescription.insertNewObject(forEntityName: "Restaurant", into: managedObjectContext) as! Restaurant
		addRestorant.name = name
		addRestorant.type = type
		addRestorant.location = location
		if let imageNamed = imageName {
			addRestorant.image = UIImagePNGRepresentation((UIImage(named: imageNamed))!)
		}
		if let imageDatad = imageData {
			addRestorant.image = imageDatad
		}
		addRestorant.isVisited = isVisited
		addRestorant.phoneNumber = phoneNumber
		
		addRestorant.rating = .nRate
		
		return addRestorant
	}
	return nil
}

// Запрос всех объктов для отображения
public func FetchRestaurants() -> [Restaurant] {
	
	var restaurants: [Restaurant] = []
	
	let fetchRequest: NSFetchRequest<Restaurant> = Restaurant.fetchRequest()
	let sortDescriptor = NSSortDescriptor(key: "sortCriteria", ascending: true)
	fetchRequest.sortDescriptors = [sortDescriptor]
	
	if let managedObjectContext = (UIApplication.shared.delegate as? AppDelegate)?.managedObjectContext {
		let fetchResultController = NSFetchedResultsController<Restaurant>(fetchRequest: fetchRequest, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
		do {
			try fetchResultController.performFetch()
			restaurants = fetchResultController.fetchedObjects!
			for rest in restaurants {
				rest.FillRestaurant()
			}
		} catch {
			print(error)
		}
	}
	
	return restaurants
	
}
