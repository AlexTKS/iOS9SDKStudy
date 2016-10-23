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

open class Restaurant: NSManagedObject {
	
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
		if let managedObjectContext = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
			managedObjectContext.delete(self)
		}
	}
	
	// Создание в базе нового ресторана
	open class func AddNewRestaurant(name: String, type: String, location: String, phoneNumber: String, isVisited: Bool) -> Restaurant? {
		
		// Проверка на валидность введенных строк
		if name == "" || type == "" || location == "" {
			return nil
		}
		
		if let managedObjectContext = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
			let addRestorant = NSEntityDescription.insertNewObject(forEntityName: "Restaurant", into: managedObjectContext) as! Restaurant
			addRestorant.name = name
			addRestorant.type = type
			addRestorant.location = location
			addRestorant.isVisited = isVisited
			addRestorant.phoneNumber = phoneNumber
			
			addRestorant.rating = .nRate
			
			return addRestorant
		}
		return nil
	}
	
	// Запрос всех объктов для отображения
	open class func FetchRestaurants() -> [Restaurant] {
		
		var restaurants: [Restaurant] = []
		
		let fetchRequest: NSFetchRequest<Restaurant> = Restaurant.fetchRequest()
		let sortDescriptor = NSSortDescriptor(key: "sortCriteria", ascending: true)
		fetchRequest.sortDescriptors = [sortDescriptor]
		
		
		// Учим отборы
		/*
		let rtrt = "Cafe Lore"
		let Predicate = NSPredicate.init(format: "name == %@", rtrt)
		fetchRequest.predicate = Predicate
		*/
		
		
		if let managedObjectContext = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
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
	
	public func AddRestaurantImage(image: UIImage?) {
		
		var thumbnail: UIImage? = nil
		
		if let OriginalImage = image {
			let thumbnailSize  = CGSize.init(width: 72, height: 72)
			var thumbnailPoint = CGPoint.init()
			let thumbnailRect  = CGRect.init(origin: thumbnailPoint, size: thumbnailSize)
			let OriginalSize = OriginalImage.size
			let targetSize = CGSize.init(width: min(OriginalSize.height, OriginalSize.width), height: min(OriginalSize.height, OriginalSize.width))
			if OriginalSize.height == OriginalSize.width && !thumbnailSize.equalTo(OriginalSize) {
				UIGraphicsBeginImageContextWithOptions(thumbnailSize, false, 0)
				OriginalImage.draw(in: thumbnailRect)
				thumbnail = UIGraphicsGetImageFromCurrentImageContext()
				UIGraphicsEndImageContext()
			}else if !thumbnailSize.equalTo(OriginalSize){
				let widthFactor  = targetSize.width  / OriginalSize.width
				let heightFactor = targetSize.height / OriginalSize.height
				let scaleFactor  = (widthFactor < heightFactor) ? widthFactor : heightFactor
				let scaledWidth  = OriginalSize.width  * scaleFactor
				let scaledHeight = OriginalSize.height * scaleFactor
				// center the image
				if widthFactor > heightFactor {
					thumbnailPoint.y = (OriginalSize.height - scaledHeight) / 2
				}
				if widthFactor < heightFactor {
					thumbnailPoint.x = (OriginalSize.width - scaledWidth) / 2
				}
				let targetRect = CGRect.init(origin: thumbnailPoint, size: targetSize)
				if let serviceImage = OriginalImage.cgImage {
					if let cropedImage = serviceImage.cropping(to: targetRect) {
						UIGraphicsBeginImageContextWithOptions(thumbnailSize, false, 0)
						let workIV = UIImage.init(cgImage: cropedImage)
						workIV.draw(in: thumbnailRect)
						thumbnail = UIGraphicsGetImageFromCurrentImageContext()
						UIGraphicsEndImageContext()
					}
				}
			}else{
				thumbnail = image
			}
		}
		
		if let thumbnailImage = thumbnail {
			self.image = UIImageJPEGRepresentation(thumbnailImage, 80)
			if let addRestaurantPhoto = RestaurantPhoto.AddNewRestaurantPhoto() {
				addRestaurantPhoto.photo = UIImagePNGRepresentation(image!)
				self.mainToPhoto = addRestaurantPhoto
			}
		}
	}
	
}


