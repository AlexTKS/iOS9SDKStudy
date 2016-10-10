//
//  Restaurant+CoreDataProperties.swift
//  iOS9SDKStudy
//
//  Created by Александр on 02.10.16.
//  Copyright © 2016 Александр. All rights reserved.
//

import Foundation
import CoreData


extension Restaurant {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Restaurant> {
        return NSFetchRequest<Restaurant>(entityName: "Restaurant");
    }

    @NSManaged public var name: String
    @NSManaged public var type: String
    @NSManaged public var location: String
    @NSManaged public var image: Data?
    @NSManaged public var isVisited: Bool
    @NSManaged public var phoneNumber: String?
    @NSManaged public var ratingRaw: String?
    @NSManaged public var sortCriteria: Int16

}
