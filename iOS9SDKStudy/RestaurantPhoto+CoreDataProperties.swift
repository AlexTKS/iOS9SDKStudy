//
//  RestaurantPhoto+CoreDataProperties.swift
//  iOS9SDKStudy
//
//  Created by Александр on 23.10.16.
//  Copyright © 2016 Александр. All rights reserved.
//

import Foundation
import CoreData

extension RestaurantPhoto {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RestaurantPhoto> {
        return NSFetchRequest<RestaurantPhoto>(entityName: "RestaurantPhotos");
    }

    @NSManaged public var photo: Data?
    @NSManaged public var photoToMain: Restaurant?

}
