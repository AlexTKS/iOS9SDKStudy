//
//  RestaurantPhoto+CoreDataClass.swift
//  iOS9SDKStudy
//
//  Created by Александр on 23.10.16.
//  Copyright © 2016 Александр. All rights reserved.
//

import Foundation
import CoreData
import UIKit

public class RestaurantPhoto: NSManagedObject {
	
	// Создание в базе нового ресторана
	open class func AddNewRestaurantPhoto() -> RestaurantPhoto? {
		
		if let managedObjectContext = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
			let addRestaurantPhoto = NSEntityDescription.insertNewObject(forEntityName: "RestaurantPhotos", into: managedObjectContext) as! RestaurantPhoto
			
			return addRestaurantPhoto
		}
		return nil
	}

}
